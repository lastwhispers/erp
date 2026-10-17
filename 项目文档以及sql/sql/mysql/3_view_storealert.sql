-- 库存预警视图：现有库存 < 已接单未发货需求 的商品
-- 对应 Oracle 版 4、订单与库存视图.sql，改写点：
--   g.uuid = s.goodsuuid(+)  ->  LEFT JOIN
--   nvl(num,0)               ->  ifnull(s.num,0)
CREATE OR REPLACE VIEW view_storealert AS
SELECT a.uuid,
       a.name,
       a.storenum,
       b.outnum
FROM (
    SELECT g.uuid, g.name, SUM(IFNULL(s.num, 0)) AS storenum
    FROM goods g
    LEFT JOIN storedetail s ON s.goodsuuid = g.uuid
    GROUP BY g.uuid, g.name
) a
JOIN (
    SELECT ol.goodsuuid, SUM(ol.num) AS outnum
    FROM orderdetail ol
    JOIN orders o ON o.uuid = ol.ordersuuid
    WHERE o.type = '2' AND ol.state = '0'
    GROUP BY ol.goodsuuid
) b ON b.goodsuuid = a.uuid;
