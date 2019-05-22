CREATE VIEW VIEW_STOREALERT AS
select a.uuid,a.name,a.storenum,b.outnum from (
  select g.uuid,g.name,sum(nvl(num,0)) storenum from goods g, storedetail s
  where g.uuid = s.goodsuuid(+)
  group by g.uuid,g.name
) a, (
  select ol.goodsuuid,sum(ol.num) as outnum from orderdetail ol, orders s
  where s.uuid=ol.ordersuuid
  and s.type='2' and ol.state='0'
  group by ol.goodsuuid
) b
where a.uuid =b.goodsuuid;