"""Oracle (PLSQL Developer export) -> MySQL 8/9 DDL + data converter."""
import re
import sys
from datetime import datetime

SRC = sys.argv[1]
OUT_SCHEMA = sys.argv[2]
OUT_DATA = sys.argv[3]

ORACLE_FMT_MAP = [
    ('yyyy', r'(?i)(\d{4})'),
    ('yy', r'(?i)(\d{2})'),
    ('mm', r'(?i)(\d{1,2})'),
    ('dd', r'(?i)(\d{1,2})'),
    ('hh24', r'(?i)(\d{1,2})'),
    ('mi', r'(?i)(\d{1,2})'),
    ('ss', r'(?i)(\d{1,2})'),
]


def to_date_to_mysql(value, fmt):
    """Rewrite an Oracle to_date literal into a MySQL 'YYYY-MM-DD[ HH:MM:SS]' string."""
    tokens = re.findall(r'(?i)yyyy|yy|mm|dd|hh24|mi|ss|.', fmt)
    parts = {}
    vi = 0
    for tok in tokens:
        key = tok.lower()
        if key in ('yyyy', 'yy', 'mm', 'dd', 'hh24', 'mi', 'ss'):
            width = {'yyyy': 4, 'yy': 2, 'mm': 2, 'dd': 2, 'hh24': 2, 'mi': 2, 'ss': 2}[key]
            m = re.match(r'(\d{%d}|\d{%d})' % (width, width - 1), value[vi:])
            if not m:
                raise ValueError('cannot parse %r against %r' % (value, fmt))
            parts[key] = m.group(1).zfill(width)
            vi += len(m.group(1))
        else:
            if value[vi:vi + len(tok)] != tok:
                raise ValueError('separator mismatch %r in %r' % (tok, value))
            vi += len(tok)
    if vi != len(value):
        raise ValueError('trailing chars in %r' % value)
    year = parts.get('yyyy') or ('20' + parts['yy'])
    out = '%s-%s-%s' % (year, parts.get('mm', '01'), parts.get('dd', '01'))
    if 'hh24' in parts:
        out += ' %s:%s:%s' % (parts['hh24'], parts.get('mi', '00'), parts.get('ss', '00'))
    return out


def convert_column_types(text):
    text = re.sub(r'(?i)\bvarchar2\s*\(', 'varchar(', text)
    text = re.sub(r'(?i)\bnvarchar2\s*\(', 'varchar(', text)
    text = re.sub(r'(?i)\bchar\s*\(\s*1\s*\)', 'varchar(1)', text)
    text = re.sub(r'(?i)\bnumber\s*\(\s*(\d+)\s*,\s*(\d+)\s*\)', r'decimal(\1,\2)', text)
    text = re.sub(r'(?i)\bnumber\s*\(\s*(\d+)\s*\)', r'bigint', text)
    text = re.sub(r'(?i)\bnumber\b(?!\s*\()', 'bigint', text)
    text = re.sub(r'(?i)\bdate\b(?!\w)', 'datetime', text)
    return text


raw = open(SRC, encoding='gb18030').read()
raw = re.sub(r"(?im)^\s*comment\s+on\s+(?:table|column)\s+[\w.]+\s+is\s+'(?:[^']|'')*'\s*;", '', raw)
raw = re.sub(r"(?im)^\s*(?:prompt|set\s+\w+)\b.*$", '', raw)
raw = re.sub(r"(?im)^\s*commit\s*;\s*$", '', raw)

blocks = []
current = []
for line in raw.splitlines():
    stripped = line.strip()
    if not stripped:
        continue
    current.append(line)
    if stripped.endswith(';'):
        blocks.append('\n'.join(current))
        current = []
if current:
    blocks.append('\n'.join(current))

schema, data = [], []

# 预扫描：哪些表的主键是单列 UUID，这些表要用 AUTO_INCREMENT，插入后需顶高起点
uuid_pk_tables = set()
for blk in blocks:
    m = re.match(r'(?i)^alter\s+table\s+(\w+)\s+add\s+constraint\s+\w+\s+primary\s+key\s*\(\s*uuid\s*\)',
                 blk.strip().rstrip(';').strip())
    if m:
        uuid_pk_tables.add(m.group(1).upper())

max_id = {}

for blk in blocks:
    blk = blk.strip().rstrip(';').strip()
    if not blk:
        continue

    m = re.match(r'(?i)^alter\s+table\s+(\w+)\s+add\s+constraint\s+(\w+)\s+primary\s+key\s*\(([^)]*)\)', blk)
    if m:
        table, cols = m.group(1).upper(), [c.strip().upper() for c in m.group(3).split(',')]
        if cols == ['UUID']:
            # MySQL 要求 AUTO_INCREMENT 列必须同时是键，两者必须在同一条 ALTER 里完成
            schema.append('ALTER TABLE `%s` MODIFY COLUMN `uuid` bigint NOT NULL AUTO_INCREMENT, '
                          'ADD PRIMARY KEY (`uuid`);' % table.lower())
        else:
            schema.append('ALTER TABLE `%s` ADD PRIMARY KEY (`%s`);'
                          % (table.lower(), '`, `'.join(c.lower() for c in cols)))
        continue

    if re.match(r'(?i)^create\s+table\s+', blk):
        body = convert_column_types(blk)
        body = re.sub(r'(?im)^create\s+table\s+(\w+)', lambda m: 'CREATE TABLE `%s`' % m.group(1).lower(),
                      body, count=1)
        body = body.rstrip()
        assert body.endswith(')'), body[-40:]
        body = body[:-1].rstrip()
        schema.append(body + '\n) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;')
        continue

    if re.match(r'(?i)^insert\s+into\s+', blk):
        blk = re.sub(r"(?i)to_date\(\s*'([^']*)'\s*,\s*'([^']*)'\s*\)",
                     lambda m: "'%s'" % to_date_to_mysql(m.group(1), m.group(2)), blk)
        table = re.match(r'(?i)^insert\s+into\s+(\w+)', blk).group(1)
        cols = re.match(r'(?is)^insert\s+into\s+\w+\s*\((.*?)\)', blk).group(1)
        values = re.search(r'(?is)values\s*\((.*)\)$', blk).group(1)
        stmt = 'INSERT INTO `%s` (%s) VALUES (%s);' % (table.lower(), cols.strip(), values.strip())
        data.append(stmt)
        if table.upper() in uuid_pk_tables:
            first = values.strip().split(',')[0].strip()
            if first.isdigit():
                max_id[table.upper()] = max(max_id.get(table.upper(), 0), int(first))
        continue

    sys.stderr.write('UNHANDLED BLOCK:\n%s\n---\n' % blk[:300])

open(OUT_SCHEMA, 'w', encoding='utf-8').write('\n\n'.join(schema) + '\n')
open(OUT_DATA, 'w', encoding='utf-8').write('\n'.join(data) + '\n')

if len(sys.argv) > 4:
    resets = ['ALTER TABLE `%s` AUTO_INCREMENT = %d;' % (t.lower(), v + 1) for t, v in sorted(max_id.items())]
    open(sys.argv[4], 'w', encoding='utf-8').write(
        '-- 种子数据显式插入了主键，必须把自增起点顶到最大值之后，否则新增记录撞主键\n'
        + '\n'.join(resets) + '\n')

print('tables=%d inserts=%d alter_pk=%d auto_increment_reset=%d' % (
    sum(1 for s in schema if s.startswith('CREATE')),
    len(data),
    sum(1 for s in schema if s.startswith('ALTER')),
    len(max_id)))
