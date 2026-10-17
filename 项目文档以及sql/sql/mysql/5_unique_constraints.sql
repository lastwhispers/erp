-- 库存表缺 (goodsuuid, storeuuid) 唯一约束：
-- OrderdetailBiz 入库走"查无此行则插入、有则累加"，没有唯一键时两个并发入库都会判定
-- "查无此行"而各插一行，库存被拆散；种子数据里 14/4、15/5 本来就带着这种重复。
-- 先合并重复行，再加约束。
UPDATE storedetail s
JOIN (
    SELECT goodsuuid, storeuuid, SUM(num) AS total, MIN(uuid) AS keep_uuid
    FROM storedetail
    GROUP BY goodsuuid, storeuuid
    HAVING COUNT(*) > 1
) d ON s.goodsuuid = d.goodsuuid AND s.storeuuid = d.storeuuid
SET s.num = d.total
WHERE s.uuid = d.keep_uuid;

DELETE s
FROM storedetail s
JOIN (
    SELECT goodsuuid, storeuuid, MIN(uuid) AS keep_uuid
    FROM storedetail
    GROUP BY goodsuuid, storeuuid
    HAVING COUNT(*) > 1
) d ON s.goodsuuid = d.goodsuuid AND s.storeuuid = d.storeuuid
WHERE s.uuid <> d.keep_uuid;

ALTER TABLE storedetail ADD UNIQUE KEY uk_storedetail_goods_store (goodsuuid, storeuuid);
