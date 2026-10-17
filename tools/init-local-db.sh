#!/usr/bin/env bash
# 重建本地 MySQL 的 erp 库：转换 Oracle 脚本 -> 建表 -> 灌种子数据 -> 建预警视图 -> 顶高自增起点
set -euo pipefail

cd "$(dirname "$0")/.."
SRC="项目文档以及sql/sql/erpsql/3、erp.sql"
OUT="项目文档以及sql/sql/mysql"

if [[ "${1:-}" != "-y" ]]; then
  read -r -p "将 DROP 并重建本地 MySQL 的 erp 库，确认？[y/N] " a
  [[ "$a" == "y" || "$a" == "Y" ]] || { echo "已取消"; exit 1; }
fi

echo "==> 1/4 转换 Oracle 脚本"
python3 tools/ora2mysql.py "$SRC" "$OUT/1_schema.sql" "$OUT/2_data.sql" "$OUT/4_auto_increment.sql"

echo "==> 2/4 建库"
mysql -u root -e "DROP DATABASE IF EXISTS erp; CREATE DATABASE erp DEFAULT CHARACTER SET utf8mb4;
CREATE USER IF NOT EXISTS 'erp'@'127.0.0.1' IDENTIFIED BY 'erp';
CREATE USER IF NOT EXISTS 'erp'@'localhost'  IDENTIFIED BY 'erp';
GRANT ALL ON erp.* TO 'erp'@'127.0.0.1'; GRANT ALL ON erp.* TO 'erp'@'localhost'; FLUSH PRIVILEGES;"

# 必须显式指定连接字符集，否则客户端按 latin1 灌入，中文会变成双重编码
echo "==> 3/4 导入结构与数据"
for f in 1_schema 2_data 3_view_storealert 4_auto_increment 5_unique_constraints; do
  mysql -u root --default-character-set=utf8mb4 erp < "$OUT/$f.sql"
done

echo "==> 4/4 校验"
mysql -u root --default-character-set=utf8mb4 erp -e "
SELECT COUNT(*) AS 表数 FROM information_schema.tables WHERE table_schema='erp';
SELECT menuname, HEX(LEFT(menuname,1)) AS 应为E7B3BB FROM menu WHERE menuid='0';
SELECT COUNT(*) AS 预警商品数 FROM view_storealert;"

echo "完成。下一步：./tools/run-local.sh"
