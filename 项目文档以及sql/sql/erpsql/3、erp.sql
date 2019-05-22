prompt PL/SQL Developer import file
prompt Created on 2019年1月13日 by Administrator
set feedback off
set define off
prompt Creating DEP...
create table DEP
(
  uuid NUMBER not null,
  name VARCHAR2(30),
  tele VARCHAR2(30)
)
;
comment on table DEP
  is '部门';
comment on column DEP.uuid
  is '编号';
comment on column DEP.name
  is '部门名称';
comment on column DEP.tele
  is '联系电话';
alter table DEP
  add constraint PK_DEP primary key (UUID);

prompt Creating EMP...
create table EMP
(
  uuid     NUMBER not null,
  username VARCHAR2(15),
  pwd      VARCHAR2(32),
  name     VARCHAR2(28),
  gender   NUMBER,
  email    VARCHAR2(255),
  tele     VARCHAR2(30),
  address  VARCHAR2(255),
  birthday DATE,
  depuuid  NUMBER
)
;
comment on table EMP
  is '员工';
comment on column EMP.uuid
  is '编号';
comment on column EMP.username
  is '登陆名';
comment on column EMP.pwd
  is '登陆密码';
comment on column EMP.name
  is '真实姓名';
comment on column EMP.gender
  is '性别';
comment on column EMP.email
  is '邮件地址';
comment on column EMP.tele
  is '联系电话';
comment on column EMP.address
  is '联系地址';
comment on column EMP.birthday
  is '出生年月日';
comment on column EMP.depuuid
  is '部门编号';
alter table EMP
  add constraint PK_EMP primary key (UUID);

prompt Creating EMP_ROLE...
create table EMP_ROLE
(
  empuuid  NUMBER,
  roleuuid NUMBER
)
;
comment on table EMP_ROLE
  is '员工角色';
comment on column EMP_ROLE.empuuid
  is '员工编号';
comment on column EMP_ROLE.roleuuid
  is '角色编号';

prompt Creating GOODS...
create table GOODS
(
  uuid          NUMBER not null,
  name          VARCHAR2(30),
  origin        VARCHAR2(30),
  producer      VARCHAR2(30),
  unit          VARCHAR2(30),
  inprice       NUMBER(8,2),
  outprice      NUMBER(8,2),
  goodstypeuuid NUMBER
)
;
comment on table GOODS
  is '商品';
comment on column GOODS.uuid
  is '编号';
comment on column GOODS.name
  is '名称';
comment on column GOODS.origin
  is '产地';
comment on column GOODS.producer
  is '厂家';
comment on column GOODS.unit
  is '计量单位';
comment on column GOODS.inprice
  is '进货价格';
comment on column GOODS.outprice
  is '销售价格';
comment on column GOODS.goodstypeuuid
  is '商品类型';
alter table GOODS
  add constraint PK_GOODS primary key (UUID);

prompt Creating GOODSTYPE...
create table GOODSTYPE
(
  uuid NUMBER not null,
  name VARCHAR2(30)
)
;
comment on table GOODSTYPE
  is '商品分类';
comment on column GOODSTYPE.uuid
  is '商品类型编号';
comment on column GOODSTYPE.name
  is '商品类型名称';
alter table GOODSTYPE
  add constraint PK_GOODSTYPE primary key (UUID);

prompt Creating INVENTORY...
create table INVENTORY
(
  uuid       NUMBER not null,
  goodsuuid  NUMBER,
  storeuuid  NUMBER,
  num        NUMBER,
  type       CHAR(1),
  createtime DATE,
  checktime  DATE,
  creater    NUMBER,
  checker    NUMBER,
  state      CHAR(1),
  remark     VARCHAR2(200)
)
;
comment on table INVENTORY
  is '盘盈盘亏';
comment on column INVENTORY.uuid
  is '编号';
comment on column INVENTORY.goodsuuid
  is '商品';
comment on column INVENTORY.storeuuid
  is '仓库';
comment on column INVENTORY.num
  is '数量';
comment on column INVENTORY.type
  is '类型';
comment on column INVENTORY.createtime
  is '登记日期';
comment on column INVENTORY.checktime
  is '审核日期';
comment on column INVENTORY.creater
  is '登记人';
comment on column INVENTORY.checker
  is '审核人';
comment on column INVENTORY.state
  is '状态';
comment on column INVENTORY.remark
  is '备注';
alter table INVENTORY
  add constraint PK_INVENTORY primary key (UUID);

prompt Creating MENU...
create table MENU
(
  menuid   VARCHAR2(20) not null,
  menuname VARCHAR2(30),
  icon     VARCHAR2(20),
  url      VARCHAR2(255),
  pid      VARCHAR2(20)
)
;
comment on table MENU
  is '菜单';
comment on column MENU.menuid
  is '菜单ID';
comment on column MENU.menuname
  is '菜单名称';
comment on column MENU.icon
  is '图标';
comment on column MENU.url
  is 'URL';
comment on column MENU.pid
  is '上级菜单ID';
alter table MENU
  add constraint PK_MENU primary key (MENUID);

prompt Creating ORDERDETAIL...
create table ORDERDETAIL
(
  uuid       NUMBER not null,
  goodsuuid  NUMBER,
  goodsname  VARCHAR2(50),
  price      NUMBER(10,2),
  num        NUMBER,
  money      NUMBER(10,2),
  endtime    DATE,
  ender      NUMBER,
  storeuuid  NUMBER,
  state      CHAR(1),
  ordersuuid NUMBER
)
;
comment on table ORDERDETAIL
  is '订单明细';
comment on column ORDERDETAIL.uuid
  is '编号';
comment on column ORDERDETAIL.goodsuuid
  is '商品编号';
comment on column ORDERDETAIL.goodsname
  is '商品名称';
comment on column ORDERDETAIL.price
  is '价格';
comment on column ORDERDETAIL.num
  is '数量';
comment on column ORDERDETAIL.money
  is '金额';
comment on column ORDERDETAIL.endtime
  is '结束日期';
comment on column ORDERDETAIL.ender
  is '库管员';
comment on column ORDERDETAIL.storeuuid
  is '仓库编号';
comment on column ORDERDETAIL.state
  is '采购：0=未入库，1=已入库  销售：0=未出库，1=已出库';
comment on column ORDERDETAIL.ordersuuid
  is '订单编号';
alter table ORDERDETAIL
  add constraint PK_ORDERDETAIL primary key (UUID);

prompt Creating ORDERS...
create table ORDERS
(
  uuid         NUMBER not null,
  createtime   DATE,
  checktime    DATE,
  starttime    DATE,
  endtime      DATE,
  type         CHAR(1),
  creater      NUMBER,
  checker      NUMBER,
  starter      NUMBER,
  ender        NUMBER,
  supplieruuid NUMBER,
  totalmoney   NUMBER(10,2),
  state        CHAR(1),
  waybillsn    NUMBER
)
;
comment on table ORDERS
  is '订单';
comment on column ORDERS.uuid
  is '编号';
comment on column ORDERS.createtime
  is '生成日期';
comment on column ORDERS.checktime
  is '审核日期';
comment on column ORDERS.starttime
  is '确认日期';
comment on column ORDERS.endtime
  is '入库或出库日期';
comment on column ORDERS.type
  is '1:采购 2:销售';
comment on column ORDERS.creater
  is '下单员';
comment on column ORDERS.checker
  is '审核员';
comment on column ORDERS.starter
  is '采购员';
comment on column ORDERS.ender
  is '库管员';
comment on column ORDERS.supplieruuid
  is '供应商或客户';
comment on column ORDERS.totalmoney
  is '合计金额';
comment on column ORDERS.state
  is '采购: 0:未审核 1:已审核, 2:已确认, 3:已入库；销售：0:未出库 1:已出库';
comment on column ORDERS.waybillsn
  is '运单号';
alter table ORDERS
  add constraint PK_ORDERS primary key (UUID);

prompt Creating RETURNORDERDETAIL...
create table RETURNORDERDETAIL
(
  uuid       NUMBER not null,
  goodsuuid  NUMBER,
  goodsname  VARCHAR2(50),
  price      NUMBER(10,2),
  num        NUMBER,
  money      NUMBER(10,2),
  endtime    DATE,
  ender      NUMBER,
  storeuuid  NUMBER,
  state      CHAR(1),
  ordersuuid NUMBER
)
;
comment on table RETURNORDERDETAIL
  is '退货订单明细';
comment on column RETURNORDERDETAIL.uuid
  is '编号';
comment on column RETURNORDERDETAIL.goodsuuid
  is '商品编号';
comment on column RETURNORDERDETAIL.goodsname
  is '商品名称';
comment on column RETURNORDERDETAIL.price
  is '价格';
comment on column RETURNORDERDETAIL.num
  is '数量';
comment on column RETURNORDERDETAIL.money
  is '金额';
comment on column RETURNORDERDETAIL.endtime
  is '结束日期';
comment on column RETURNORDERDETAIL.ender
  is '库管员';
comment on column RETURNORDERDETAIL.storeuuid
  is '仓库编号';
comment on column RETURNORDERDETAIL.state
  is '状态';
comment on column RETURNORDERDETAIL.ordersuuid
  is '退货订单编号';
alter table RETURNORDERDETAIL
  add constraint PK_RETURNORDERDETAIL primary key (UUID);

prompt Creating RETURNORDERS...
create table RETURNORDERS
(
  uuid         NUMBER not null,
  createtime   DATE,
  checktime    DATE,
  endtime      DATE,
  type         CHAR(1),
  creater      NUMBER,
  checker      NUMBER,
  ender        NUMBER,
  supplieruuid NUMBER,
  totalmoney   NUMBER(10,2),
  state        CHAR(1),
  waybillsn    NUMBER,
  ordersuuid   NUMBER
)
;
comment on table RETURNORDERS
  is '退货订单';
comment on column RETURNORDERS.uuid
  is '编号';
comment on column RETURNORDERS.createtime
  is '生成日期';
comment on column RETURNORDERS.checktime
  is '检查日期';
comment on column RETURNORDERS.endtime
  is '结束日期';
comment on column RETURNORDERS.type
  is '订单类型';
comment on column RETURNORDERS.creater
  is '下单员';
comment on column RETURNORDERS.checker
  is '审核员工编号';
comment on column RETURNORDERS.ender
  is '库管员';
comment on column RETURNORDERS.supplieruuid
  is '供应商及客户编号';
comment on column RETURNORDERS.totalmoney
  is '合计金额';
comment on column RETURNORDERS.state
  is '订单状态';
comment on column RETURNORDERS.waybillsn
  is '运单号';
comment on column RETURNORDERS.ordersuuid
  is '原订单编号';
alter table RETURNORDERS
  add constraint PK_RETURNORDERS primary key (UUID);

prompt Creating ROLE...
create table ROLE
(
  uuid NUMBER not null,
  name VARCHAR2(30)
)
;
comment on table ROLE
  is '角色';
comment on column ROLE.uuid
  is '编号';
comment on column ROLE.name
  is '名称';
alter table ROLE
  add constraint PK_ROLE primary key (UUID);

prompt Creating ROLE_MENU...
create table ROLE_MENU
(
  menuuuid VARCHAR2(10),
  roleuuid NUMBER
)
;
comment on table ROLE_MENU
  is '角色菜单';
comment on column ROLE_MENU.menuuuid
  is '菜单编号';

prompt Creating STORE...
create table STORE
(
  uuid    NUMBER not null,
  name    VARCHAR2(30),
  empuuid NUMBER
)
;
comment on table STORE
  is '仓库';
comment on column STORE.uuid
  is '编号';
comment on column STORE.name
  is '名称';
comment on column STORE.empuuid
  is '员工编号';
alter table STORE
  add constraint PK_STORE primary key (UUID);

prompt Creating STOREDETAIL...
create table STOREDETAIL
(
  uuid      NUMBER not null,
  storeuuid NUMBER,
  goodsuuid NUMBER,
  num       NUMBER
)
;
comment on table STOREDETAIL
  is '仓库库存';
comment on column STOREDETAIL.uuid
  is '编号';
comment on column STOREDETAIL.storeuuid
  is '仓库编号';
comment on column STOREDETAIL.goodsuuid
  is '商品编号';
comment on column STOREDETAIL.num
  is '数量';
alter table STOREDETAIL
  add constraint PK_STOREDETAIL primary key (UUID);

prompt Creating STOREOPER...
create table STOREOPER
(
  uuid      NUMBER not null,
  empuuid   NUMBER,
  opertime  DATE,
  storeuuid NUMBER,
  goodsuuid NUMBER,
  num       NUMBER,
  type      CHAR(1)
)
;
comment on table STOREOPER
  is '仓库操作记录';
comment on column STOREOPER.uuid
  is '编号';
comment on column STOREOPER.empuuid
  is '操作员工编号';
comment on column STOREOPER.opertime
  is '操作日期';
comment on column STOREOPER.storeuuid
  is '仓库编号';
comment on column STOREOPER.goodsuuid
  is '商品编号';
comment on column STOREOPER.num
  is '数量';
comment on column STOREOPER.type
  is '1：入库 2：出库';
alter table STOREOPER
  add constraint PK_STOREOPER primary key (UUID);

prompt Creating SUPPLIER...
create table SUPPLIER
(
  uuid    NUMBER not null,
  name    VARCHAR2(30),
  address VARCHAR2(100),
  contact VARCHAR2(30),
  tele    VARCHAR2(30),
  email   VARCHAR2(100),
  type    CHAR(1)
)
;
comment on table SUPPLIER
  is '供应商';
comment on column SUPPLIER.uuid
  is '编号';
comment on column SUPPLIER.name
  is '名称';
comment on column SUPPLIER.address
  is '联系地址';
comment on column SUPPLIER.contact
  is '联系人';
comment on column SUPPLIER.tele
  is '联系电话';
comment on column SUPPLIER.email
  is '邮件地址';
comment on column SUPPLIER.type
  is '1：供应商 2：客户';
alter table SUPPLIER
  add constraint PK_SUPPLIER primary key (UUID);

prompt Loading DEP...
insert into DEP (uuid, name, tele)
values (30, '管理员组', '15037454890');
insert into DEP (uuid, name, tele)
values (32, '采购部', '15037454890');
insert into DEP (uuid, name, tele)
values (33, '销售部', '15037721890');
insert into DEP (uuid, name, tele)
values (34, '公关部', '15037454890');
insert into DEP (uuid, name, tele)
values (35, '行政部', '15399997474');
insert into DEP (uuid, name, tele)
values (36, '人事部', '15037454890');
insert into DEP (uuid, name, tele)
values (37, '运输部', '15037454890');
insert into DEP (uuid, name, tele)
values (40, '仓储部', '15388889881');
insert into DEP (uuid, name, tele)
values (41, '客服部', '15388889557');
insert into DEP (uuid, name, tele)
values (42, '财务部', '15360724444');
insert into DEP (uuid, name, tele)
values (43, '运营部', '15360724444 ');
commit;
prompt 11 records loaded
prompt Loading EMP...
insert into EMP (uuid, username, pwd, name, gender, email, tele, address, birthday, depuuid)
values (13, 'admin', '3ef7164d1f6167cb9f2658c07d3c2f0a', '高俊', 1, 'admin@163.cn', '12345678', '河南平顶山', to_date('23-12-2018', 'dd-mm-yyyy'), 30);
insert into EMP (uuid, username, pwd, name, gender, email, tele, address, birthday, depuuid)
values (25, 'stf', '7520fe5a605a2e73f4912de6e5b4c1fd', '石腾飞', 1, 'stf@163.com', '15035945668', '河南驻马店', to_date('06-02-1996', 'dd-mm-yyyy'), 40);
insert into EMP (uuid, username, pwd, name, gender, email, tele, address, birthday, depuuid)
values (15, 'zyx', '3c266b0fbab1d192f3178c441293f28a', '张雅欣', 0, 'zyx@gmail.cn', '13783596945', '河南郑州', to_date('30-06-1998', 'dd-mm-yyyy'), 35);
insert into EMP (uuid, username, pwd, name, gender, email, tele, address, birthday, depuuid)
values (16, 'fyh', '7f9b59bdc173e63c01582e127dde5f23', '范英豪', 1, 'fyh@163.cn', '15236484564', '河南新乡', to_date('15-07-1998', 'dd-mm-yyyy'), 36);
insert into EMP (uuid, username, pwd, name, gender, email, tele, address, birthday, depuuid)
values (17, 'whz', '02c482baa251c32c23d0adbf5f7612b8', '王宏志', 1, 'whz@163.cn', '15815418847', '浙江杭州', to_date('09-02-1998', 'dd-mm-yyyy'), 32);
insert into EMP (uuid, username, pwd, name, gender, email, tele, address, birthday, depuuid)
values (18, 'lhp', '8bf7134c1a8b4cbd72be4410de4b0f3a', '李贺鹏', 1, 'lhp@163.com', '15034594843', '河南洛阳', to_date('15-07-1998', 'dd-mm-yyyy'), 35);
insert into EMP (uuid, username, pwd, name, gender, email, tele, address, birthday, depuuid)
values (24, 'xps', 'b70820940def324b69d6821fe423ca45', '徐培珊', 0, 'xps@163.com', '15037584635', '河南平顶山', to_date('29-07-1997', 'dd-mm-yyyy'), 33);
commit;
prompt 7 records loaded
prompt Loading EMP_ROLE...
insert into EMP_ROLE (empuuid, roleuuid)
values (16, 7);
insert into EMP_ROLE (empuuid, roleuuid)
values (15, 6);
insert into EMP_ROLE (empuuid, roleuuid)
values (17, 9);
insert into EMP_ROLE (empuuid, roleuuid)
values (18, 8);
insert into EMP_ROLE (empuuid, roleuuid)
values (24, 10);
insert into EMP_ROLE (empuuid, roleuuid)
values (25, 4);
insert into EMP_ROLE (empuuid, roleuuid)
values (25, 5);
insert into EMP_ROLE (empuuid, roleuuid)
values (13, 3);
commit;
prompt 8 records loaded
prompt Loading GOODS...
insert into GOODS (uuid, name, origin, producer, unit, inprice, outprice, goodstypeuuid)
values (19, '十三香', '河南', '京东', '袋', 1.1, 2, 10);
insert into GOODS (uuid, name, origin, producer, unit, inprice, outprice, goodstypeuuid)
values (22, '苹果', '河南平顶山', '喜乐融', '个', 2.5, 3, 7);
insert into GOODS (uuid, name, origin, producer, unit, inprice, outprice, goodstypeuuid)
values (13, '水蜜桃', '北京', '北京水果之乡', '斤', 2.34, 4.23, 7);
insert into GOODS (uuid, name, origin, producer, unit, inprice, outprice, goodstypeuuid)
values (14, '大鸭梨', '北京', '北京水果之乡', '斤', 1.11, 3.55, 7);
insert into GOODS (uuid, name, origin, producer, unit, inprice, outprice, goodstypeuuid)
values (15, '猕猴桃', '北京', '北京水果之乡', '斤', 6.33, 9.02, 7);
insert into GOODS (uuid, name, origin, producer, unit, inprice, outprice, goodstypeuuid)
values (16, '甜面酱', '北京', '七必居', '袋', 4.11, 6.33, 10);
insert into GOODS (uuid, name, origin, producer, unit, inprice, outprice, goodstypeuuid)
values (17, '可比克', '北京', '北京山寨食品有限公司', '袋', 3.88, 6.33, 9);
insert into GOODS (uuid, name, origin, producer, unit, inprice, outprice, goodstypeuuid)
values (18, '好吃点', '河北', '河北好吃点食品公司', '袋', 4.22, 5.21, 9);
insert into GOODS (uuid, name, origin, producer, unit, inprice, outprice, goodstypeuuid)
values (25, '铅笔', '河南', '喜乐融', '个', 1, 2, 11);
insert into GOODS (uuid, name, origin, producer, unit, inprice, outprice, goodstypeuuid)
values (26, '神州笔记本', '河南', '喜乐融', '台', 6000, 7500, 12);
commit;
prompt 10 records loaded
prompt Loading GOODSTYPE...
insert into GOODSTYPE (uuid, name)
values (7, '水果');
insert into GOODSTYPE (uuid, name)
values (11, '文具用品');
insert into GOODSTYPE (uuid, name)
values (9, '儿童食品');
insert into GOODSTYPE (uuid, name)
values (10, '调味品');
insert into GOODSTYPE (uuid, name)
values (12, '电子产品');
commit;
prompt 5 records loaded
prompt Loading INVENTORY...
prompt Table is empty
prompt Loading MENU...
insert into MENU (menuid, menuname, icon, url, pid)
values ('504', '盘盈盘亏登记', 'icon-sys', null, '500');
insert into MENU (menuid, menuname, icon, url, pid)
values ('505', '盘盈盘亏审核', 'icon-sys', null, '500');
insert into MENU (menuid, menuname, icon, url, pid)
values ('506', '盘盈盘亏查询', 'icon-sys', null, '500');
insert into MENU (menuid, menuname, icon, url, pid)
values ('306', '采购退货查询', 'icon-sys', null, '300');
insert into MENU (menuid, menuname, icon, url, pid)
values ('307', '采购退货登记', 'icon-sys', null, '300');
insert into MENU (menuid, menuname, icon, url, pid)
values ('308', '采购退货审核', 'icon-sys', null, '300');
insert into MENU (menuid, menuname, icon, url, pid)
values ('309', '采购退货出库', 'icon-sys', null, '300');
insert into MENU (menuid, menuname, icon, url, pid)
values ('602', '角色设置', 'icon-sys', 'role.html', '600');
insert into MENU (menuid, menuname, icon, url, pid)
values ('603', '角色权限设置', 'icon-sys', 'roleMenuSet.html', '600');
insert into MENU (menuid, menuname, icon, url, pid)
values ('604', '用户角色设置', 'icon-sys', 'empRoleSet.html', '600');
insert into MENU (menuid, menuname, icon, url, pid)
values ('404', '销售统计报表', 'icon-sys', 'report_order.html', '400');
insert into MENU (menuid, menuname, icon, url, pid)
values ('405', '销售趋势报表', 'icon-sys', 'report_trend.html', '400');
insert into MENU (menuid, menuname, icon, url, pid)
values ('103', '供应商', 'icon-sys', 'supplier.html?type=1', '100');
insert into MENU (menuid, menuname, icon, url, pid)
values ('104', '客户', 'icon-sys', 'supplier.html?type=2', '100');
insert into MENU (menuid, menuname, icon, url, pid)
values ('0', '系统菜单', 'icon-sys', '-', '-1');
insert into MENU (menuid, menuname, icon, url, pid)
values ('100', '基础数据', 'icon-sys', '-', '0');
insert into MENU (menuid, menuname, icon, url, pid)
values ('101', '商品类型', 'icon-sys', 'goodstype.html', '100');
insert into MENU (menuid, menuname, icon, url, pid)
values ('102', '商品', 'icon-sys', 'goods.html', '100');
insert into MENU (menuid, menuname, icon, url, pid)
values ('105', '仓库', 'icon-sys', 'store.html', '100');
insert into MENU (menuid, menuname, icon, url, pid)
values ('200', '人事管理', 'icon-sys', '-', '0');
insert into MENU (menuid, menuname, icon, url, pid)
values ('201', '部门', 'icon-sys', 'dep.html', '200');
insert into MENU (menuid, menuname, icon, url, pid)
values ('202', '员工', 'icon-sys', 'emp.html', '200');
insert into MENU (menuid, menuname, icon, url, pid)
values ('300', '采购管理', 'icon-sys', '-', '0');
insert into MENU (menuid, menuname, icon, url, pid)
values ('600', '权限管理', 'icon-sys', '-', '0');
insert into MENU (menuid, menuname, icon, url, pid)
values ('601', '重置密码', 'icon-sys', 'pwd.html', '600');
insert into MENU (menuid, menuname, icon, url, pid)
values ('400', '销售管理', 'icon-sys', '-', '0');
insert into MENU (menuid, menuname, icon, url, pid)
values ('301', '采购订单查询', 'icon-sys', 'orders.html?oper=orders&type=1', '300');
insert into MENU (menuid, menuname, icon, url, pid)
values ('302', '采购订单审核', 'icon-sys', 'orders.html?oper=doCheck&type=1', '300');
insert into MENU (menuid, menuname, icon, url, pid)
values ('303', '采购订单确认', 'icon-sys', 'orders.html?oper=doStart&type=1', '300');
insert into MENU (menuid, menuname, icon, url, pid)
values ('304', '采购订单入库', 'icon-sys', 'orders.html?oper=doInStore&type=1', '300');
insert into MENU (menuid, menuname, icon, url, pid)
values ('305', '我的采购订单', 'icon-sys', 'orders.html?oper=myorders&type=1', '300');
insert into MENU (menuid, menuname, icon, url, pid)
values ('401', '销售订单查询', 'icon-sys', 'orders.html?oper=orders&type=2', '400');
insert into MENU (menuid, menuname, icon, url, pid)
values ('402', '销售订单录入', 'icon-sys', 'orders.html?oper=myorders&type=2', '400');
insert into MENU (menuid, menuname, icon, url, pid)
values ('403', '销售订单出库', 'icon-sys', 'orders.html?oper=doOutStore&type=2', '400');
insert into MENU (menuid, menuname, icon, url, pid)
values ('500', '库存管理', 'icon-sys', '-', '0');
insert into MENU (menuid, menuname, icon, url, pid)
values ('501', '库存查询', 'icon-sys', 'storedetail.html', '500');
insert into MENU (menuid, menuname, icon, url, pid)
values ('502', '库存变动记录', 'icon-sys', 'storeoper.html', '500');
insert into MENU (menuid, menuname, icon, url, pid)
values ('503', '库存预警', 'icon-sys', 'storealert.html', '500');
insert into MENU (menuid, menuname, icon, url, pid)
values ('406', '销售退货查询', 'icon-sys', null, '400');
insert into MENU (menuid, menuname, icon, url, pid)
values ('407', '销售退货登记', 'icon-sys', null, '400');
insert into MENU (menuid, menuname, icon, url, pid)
values ('408', '销售退货审核', 'icon-sys', null, '400');
insert into MENU (menuid, menuname, icon, url, pid)
values ('409', '销售退货入库', 'icon-sys', null, '400');
commit;
prompt 42 records loaded
prompt Loading ORDERDETAIL...
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (101, 25, '铅笔', 1.1, 10000, 11000, null, null, null, '0', 61);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (102, 19, '十三香', 1.1, 2000, 2200, null, null, null, '0', 61);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (52, 14, '大鸭梨', 3.55, 100, 355, to_date('26-12-2018 18:54:39', 'dd-mm-yyyy hh24:mi:ss'), 13, 4, '1', 32);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (53, 13, '水蜜桃', 4.23, 100, 423, to_date('26-12-2018 18:56:09', 'dd-mm-yyyy hh24:mi:ss'), 13, 4, '1', 32);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (45, 22, '苹果', 2.5, 500, 1250, null, null, null, '0', 29);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (46, 16, '甜面酱', 4.11, 1000, 4110, to_date('27-12-2018 17:42:10', 'dd-mm-yyyy hh24:mi:ss'), 13, 5, '1', 30);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (47, 18, '好吃点', 4.22, 3000, 12660, to_date('27-12-2018 17:42:05', 'dd-mm-yyyy hh24:mi:ss'), 13, 4, '1', 30);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (48, 13, '水蜜桃', 2.34, 500, 1170, to_date('27-12-2018 16:11:07', 'dd-mm-yyyy hh24:mi:ss'), 13, 4, '1', 31);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (49, 15, '猕猴桃', 6.33, 1000, 6330, to_date('28-12-2018 11:20:02', 'dd-mm-yyyy hh24:mi:ss'), 13, 5, '1', 31);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (50, 14, '大鸭梨', 1.11, 300, 333, to_date('28-12-2018 11:20:06', 'dd-mm-yyyy hh24:mi:ss'), 13, 5, '1', 31);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (51, 17, '可比克', 3.88, 1000, 3880, to_date('28-12-2018 11:20:09', 'dd-mm-yyyy hh24:mi:ss'), 13, 4, '1', 31);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (54, 15, '猕猴桃', 9.02, 200, 1804, to_date('26-12-2018 17:27:39', 'dd-mm-yyyy hh24:mi:ss'), 13, 4, '1', 33);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (55, 17, '可比克', 6.33, 300, 1899, to_date('26-12-2018 17:34:04', 'dd-mm-yyyy hh24:mi:ss'), 13, 4, '1', 33);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (56, 19, '十三香', 2, 100, 200, to_date('28-12-2018 10:50:57', 'dd-mm-yyyy hh24:mi:ss'), 13, 4, '1', 34);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (57, 16, '甜面酱', 6.33, 200, 1266, to_date('28-12-2018 10:51:02', 'dd-mm-yyyy hh24:mi:ss'), 13, 5, '1', 34);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (58, 17, '可比克', 3.88, 300, 1164, to_date('26-12-2018 17:33:49', 'dd-mm-yyyy hh24:mi:ss'), 13, 4, '1', 35);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (86, 14, '大鸭梨', 3.55, 10000, 35500, null, null, null, '0', 50);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (90, 15, '猕猴桃', 6.33, 1000, 6330, null, null, null, '0', 53);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (91, 22, '苹果', 2.5, 2000, 5000, null, null, null, '0', 53);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (42, 13, '水蜜桃', 2.34, 2000, 4680, null, null, null, '0', 28);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (43, 22, '苹果', 2.5, 1000, 2500, null, null, null, '0', 28);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (44, 14, '大鸭梨', 1.11, 1000, 1110, null, null, null, '0', 29);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (79, 14, '大鸭梨', 3.55, 100, 355, to_date('28-12-2018 11:19:03', 'dd-mm-yyyy hh24:mi:ss'), 13, 4, '1', 47);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (80, 15, '猕猴桃', 9.02, 100, 902, to_date('28-12-2018 11:20:20', 'dd-mm-yyyy hh24:mi:ss'), 13, 5, '1', 47);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (89, 13, '水蜜桃', 2.34, 100, 234, to_date('28-12-2018 12:18:32', 'dd-mm-yyyy hh24:mi:ss'), 13, 5, '1', 52);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (92, 26, '神州笔记本', 7500, 1, 7500, to_date('28-12-2018 12:45:12', 'dd-mm-yyyy hh24:mi:ss'), 13, 5, '1', 54);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (93, 25, '铅笔', 2, 10000, 20000, null, null, null, '0', 55);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (73, 22, '苹果', 3, 100, 300, to_date('28-12-2018 11:12:03', 'dd-mm-yyyy hh24:mi:ss'), 13, 5, '1', 44);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (74, 16, '甜面酱', 6.33, 100, 633, to_date('28-12-2018 11:12:10', 'dd-mm-yyyy hh24:mi:ss'), 13, 5, '1', 44);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (97, 13, '水蜜桃', 4.23, 1000, 4230, null, null, null, '0', 58);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (64, 15, '猕猴桃', 6.33, 200, 1266, null, null, null, '0', 39);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (65, 25, '铅笔', 1, 1000, 1000, to_date('28-12-2018 10:58:11', 'dd-mm-yyyy hh24:mi:ss'), 13, 5, '1', 40);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (66, 14, '大鸭梨', 1.11, 2000, 2220, to_date('28-12-2018 10:58:14', 'dd-mm-yyyy hh24:mi:ss'), 13, 4, '1', 40);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (67, 25, '铅笔', 2, 200, 400, to_date('28-12-2018 10:58:54', 'dd-mm-yyyy hh24:mi:ss'), 13, 5, '1', 41);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (68, 13, '水蜜桃', 4.23, 100, 423, to_date('28-12-2018 10:58:58', 'dd-mm-yyyy hh24:mi:ss'), 13, 5, '1', 41);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (69, 26, '神州笔记本', 6000, 10, 60000, to_date('28-12-2018 11:02:41', 'dd-mm-yyyy hh24:mi:ss'), 13, 5, '1', 42);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (70, 13, '水蜜桃', 2.34, 2000, 4680, to_date('28-12-2018 11:02:33', 'dd-mm-yyyy hh24:mi:ss'), 13, 4, '1', 42);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (60, 13, '水蜜桃', 2.55, 100, 255, null, null, null, '0', 37);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (61, 15, '猕猴桃', 6.33, 500, 3165, null, null, null, '0', 37);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (63, 22, '苹果', 2.5, 100, 250, null, null, null, '0', 39);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (71, 26, '神州笔记本', 7500, 1, 7500, to_date('28-12-2018 11:03:16', 'dd-mm-yyyy hh24:mi:ss'), 13, 5, '1', 43);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (72, 13, '水蜜桃', 4.23, 100, 423, to_date('28-12-2018 11:03:20', 'dd-mm-yyyy hh24:mi:ss'), 13, 4, '1', 43);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (75, 13, '水蜜桃', 4.23, 200, 846, to_date('28-12-2018 11:14:33', 'dd-mm-yyyy hh24:mi:ss'), 13, 4, '1', 45);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (76, 17, '可比克', 6.33, 200, 1266, to_date('28-12-2018 11:14:39', 'dd-mm-yyyy hh24:mi:ss'), 13, 4, '1', 45);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (87, 16, '甜面酱', 4.11, 100, 411, null, null, null, '0', 51);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (88, 22, '苹果', 2.5, 200, 500, null, null, null, '0', 51);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (98, 19, '十三香', 1.1, 10000, 11000, null, null, null, '0', 59);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (99, 16, '甜面酱', 4.11, 20000, 82200, null, null, null, '0', 59);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (100, 19, '十三香', 2, 8000, 16000, null, null, null, '0', 60);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (62, 19, '十三香', 1.5, 100, 150, null, null, null, '0', 38);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (77, 13, '水蜜桃', 4.23, 100, 423, to_date('28-12-2018 11:18:20', 'dd-mm-yyyy hh24:mi:ss'), 13, 4, '1', 46);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (78, 25, '铅笔', 2, 100, 200, to_date('28-12-2018 11:18:23', 'dd-mm-yyyy hh24:mi:ss'), 13, 5, '1', 46);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (81, 15, '猕猴桃', 6.33, 10000, 63300, null, null, null, '0', 48);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (82, 26, '神州笔记本', 6000, 200, 1200000, null, null, null, '0', 48);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (59, 13, '水蜜桃', 2.34, 200, 468, to_date('26-12-2018 18:56:05', 'dd-mm-yyyy hh24:mi:ss'), 13, 4, '1', 36);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (83, 13, '水蜜桃', 2.34, 10000, 23400, null, null, null, '0', 48);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (84, 16, '甜面酱', 6.33, 100, 633, to_date('28-12-2018 11:20:44', 'dd-mm-yyyy hh24:mi:ss'), 13, 5, '1', 49);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (85, 13, '水蜜桃', 4.23, 200, 846, to_date('28-12-2018 11:20:47', 'dd-mm-yyyy hh24:mi:ss'), 13, 4, '1', 49);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (94, 13, '水蜜桃', 2.34, 1000, 2340, to_date('29-12-2018 14:36:28', 'dd-mm-yyyy hh24:mi:ss'), 13, 5, '1', 56);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (95, 14, '大鸭梨', 1.11, 2000, 2220, to_date('29-12-2018 14:36:32', 'dd-mm-yyyy hh24:mi:ss'), 13, 4, '1', 56);
insert into ORDERDETAIL (uuid, goodsuuid, goodsname, price, num, money, endtime, ender, storeuuid, state, ordersuuid)
values (96, 13, '水蜜桃', 4.23, 1000, 4230, to_date('12-01-2019 19:13:25', 'dd-mm-yyyy hh24:mi:ss'), 13, 5, '1', 57);
commit;
prompt 61 records loaded
prompt Loading ORDERS...
insert into ORDERS (uuid, createtime, checktime, starttime, endtime, type, creater, checker, starter, ender, supplieruuid, totalmoney, state, waybillsn)
values (61, to_date('13-01-2019 12:14:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('13-01-2019 12:14:12', 'dd-mm-yyyy hh24:mi:ss'), null, null, '1', 13, 13, null, null, 5, 13200, '1', null);
insert into ORDERS (uuid, createtime, checktime, starttime, endtime, type, creater, checker, starter, ender, supplieruuid, totalmoney, state, waybillsn)
values (32, to_date('01-11-2018 17:25:49', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('26-12-2018 18:56:09', 'dd-mm-yyyy hh24:mi:ss'), '2', 13, null, null, 13, 7, 778, '1', 2);
insert into ORDERS (uuid, createtime, checktime, starttime, endtime, type, creater, checker, starter, ender, supplieruuid, totalmoney, state, waybillsn)
values (30, to_date('26-12-2018 17:22:54', 'dd-mm-yyyy hh24:mi:ss'), to_date('26-12-2018 17:23:29', 'dd-mm-yyyy hh24:mi:ss'), to_date('26-12-2018 17:23:37', 'dd-mm-yyyy hh24:mi:ss'), to_date('27-12-2018 17:42:10', 'dd-mm-yyyy hh24:mi:ss'), '1', 13, 13, 13, 13, 3, 16770, '3', null);
insert into ORDERS (uuid, createtime, checktime, starttime, endtime, type, creater, checker, starter, ender, supplieruuid, totalmoney, state, waybillsn)
values (31, to_date('26-12-2018 17:23:19', 'dd-mm-yyyy hh24:mi:ss'), to_date('26-12-2018 17:23:45', 'dd-mm-yyyy hh24:mi:ss'), to_date('27-12-2018 16:09:14', 'dd-mm-yyyy hh24:mi:ss'), to_date('28-12-2018 11:20:09', 'dd-mm-yyyy hh24:mi:ss'), '1', 13, 13, 13, 13, 3, 11713, '3', null);
insert into ORDERS (uuid, createtime, checktime, starttime, endtime, type, creater, checker, starter, ender, supplieruuid, totalmoney, state, waybillsn)
values (33, to_date('01-10-2018 17:27:28', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('26-12-2018 17:34:04', 'dd-mm-yyyy hh24:mi:ss'), '2', 13, null, null, 13, 8, 3703, '1', 1);
insert into ORDERS (uuid, createtime, checktime, starttime, endtime, type, creater, checker, starter, ender, supplieruuid, totalmoney, state, waybillsn)
values (34, to_date('01-08-2018 17:28:37', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('28-12-2018 10:51:02', 'dd-mm-yyyy hh24:mi:ss'), '2', 13, null, null, 13, 8, 1466, '1', 3);
insert into ORDERS (uuid, createtime, checktime, starttime, endtime, type, creater, checker, starter, ender, supplieruuid, totalmoney, state, waybillsn)
values (35, to_date('26-12-2018 17:33:23', 'dd-mm-yyyy hh24:mi:ss'), to_date('26-12-2018 17:33:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('26-12-2018 17:33:39', 'dd-mm-yyyy hh24:mi:ss'), to_date('26-12-2018 17:33:49', 'dd-mm-yyyy hh24:mi:ss'), '1', 13, 13, 13, 13, 3, 1164, '3', null);
insert into ORDERS (uuid, createtime, checktime, starttime, endtime, type, creater, checker, starter, ender, supplieruuid, totalmoney, state, waybillsn)
values (50, to_date('28-12-2018 11:49:27', 'dd-mm-yyyy hh24:mi:ss'), null, null, null, '2', 13, null, null, null, 11, 35500, '0', null);
insert into ORDERS (uuid, createtime, checktime, starttime, endtime, type, creater, checker, starter, ender, supplieruuid, totalmoney, state, waybillsn)
values (53, to_date('28-12-2018 12:17:34', 'dd-mm-yyyy hh24:mi:ss'), to_date('13-01-2019 12:22:49', 'dd-mm-yyyy hh24:mi:ss'), null, null, '1', 13, 15, null, null, 10, 11330, '1', null);
insert into ORDERS (uuid, createtime, checktime, starttime, endtime, type, creater, checker, starter, ender, supplieruuid, totalmoney, state, waybillsn)
values (28, to_date('26-12-2018 17:22:14', 'dd-mm-yyyy hh24:mi:ss'), to_date('27-12-2018 16:09:06', 'dd-mm-yyyy hh24:mi:ss'), to_date('13-01-2019 12:14:19', 'dd-mm-yyyy hh24:mi:ss'), null, '1', 13, 13, 13, null, 5, 7180, '2', null);
insert into ORDERS (uuid, createtime, checktime, starttime, endtime, type, creater, checker, starter, ender, supplieruuid, totalmoney, state, waybillsn)
values (29, to_date('26-12-2018 17:22:35', 'dd-mm-yyyy hh24:mi:ss'), to_date('28-12-2018 12:08:35', 'dd-mm-yyyy hh24:mi:ss'), to_date('28-12-2018 12:10:37', 'dd-mm-yyyy hh24:mi:ss'), null, '1', 13, 13, 13, null, 6, 2360, '2', null);
insert into ORDERS (uuid, createtime, checktime, starttime, endtime, type, creater, checker, starter, ender, supplieruuid, totalmoney, state, waybillsn)
values (47, to_date('20-09-2018 11:18:54', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('28-12-2018 11:20:20', 'dd-mm-yyyy hh24:mi:ss'), '2', 13, null, null, 13, 11, 1257, '1', 9);
insert into ORDERS (uuid, createtime, checktime, starttime, endtime, type, creater, checker, starter, ender, supplieruuid, totalmoney, state, waybillsn)
values (52, to_date('28-12-2018 12:09:56', 'dd-mm-yyyy hh24:mi:ss'), to_date('28-12-2018 12:17:53', 'dd-mm-yyyy hh24:mi:ss'), to_date('28-12-2018 12:18:04', 'dd-mm-yyyy hh24:mi:ss'), to_date('28-12-2018 12:18:32', 'dd-mm-yyyy hh24:mi:ss'), '1', 13, 13, 13, 13, 3, 234, '3', null);
insert into ORDERS (uuid, createtime, checktime, starttime, endtime, type, creater, checker, starter, ender, supplieruuid, totalmoney, state, waybillsn)
values (44, to_date('01-05-2018 11:11:56', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('28-12-2018 11:12:10', 'dd-mm-yyyy hh24:mi:ss'), '2', 13, null, null, 13, 8, 933, '1', 6);
insert into ORDERS (uuid, createtime, checktime, starttime, endtime, type, creater, checker, starter, ender, supplieruuid, totalmoney, state, waybillsn)
values (54, to_date('28-12-2018 12:45:02', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('28-12-2018 12:45:12', 'dd-mm-yyyy hh24:mi:ss'), '2', 13, null, null, 13, 11, 7500, '1', 11);
insert into ORDERS (uuid, createtime, checktime, starttime, endtime, type, creater, checker, starter, ender, supplieruuid, totalmoney, state, waybillsn)
values (55, to_date('28-12-2018 16:23:55', 'dd-mm-yyyy hh24:mi:ss'), null, null, null, '2', 13, null, null, null, 7, 20000, '0', null);
insert into ORDERS (uuid, createtime, checktime, starttime, endtime, type, creater, checker, starter, ender, supplieruuid, totalmoney, state, waybillsn)
values (58, to_date('12-01-2019 19:13:18', 'dd-mm-yyyy hh24:mi:ss'), null, null, null, '2', 13, null, null, null, 11, 4230, '0', null);
insert into ORDERS (uuid, createtime, checktime, starttime, endtime, type, creater, checker, starter, ender, supplieruuid, totalmoney, state, waybillsn)
values (40, to_date('28-12-2018 10:57:45', 'dd-mm-yyyy hh24:mi:ss'), to_date('28-12-2018 10:57:52', 'dd-mm-yyyy hh24:mi:ss'), to_date('28-12-2018 10:57:57', 'dd-mm-yyyy hh24:mi:ss'), to_date('28-12-2018 10:58:14', 'dd-mm-yyyy hh24:mi:ss'), '1', 13, 13, 13, 13, 3, 3220, '3', null);
insert into ORDERS (uuid, createtime, checktime, starttime, endtime, type, creater, checker, starter, ender, supplieruuid, totalmoney, state, waybillsn)
values (41, to_date('01-06-2018 10:58:42', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('28-12-2018 10:58:58', 'dd-mm-yyyy hh24:mi:ss'), '2', 13, null, null, 13, 11, 823, '1', 4);
insert into ORDERS (uuid, createtime, checktime, starttime, endtime, type, creater, checker, starter, ender, supplieruuid, totalmoney, state, waybillsn)
values (42, to_date('28-12-2018 11:02:13', 'dd-mm-yyyy hh24:mi:ss'), to_date('28-12-2018 11:02:22', 'dd-mm-yyyy hh24:mi:ss'), to_date('28-12-2018 11:02:27', 'dd-mm-yyyy hh24:mi:ss'), to_date('28-12-2018 11:02:41', 'dd-mm-yyyy hh24:mi:ss'), '1', 13, 13, 13, 13, 3, 64680, '3', null);
insert into ORDERS (uuid, createtime, checktime, starttime, endtime, type, creater, checker, starter, ender, supplieruuid, totalmoney, state, waybillsn)
values (37, to_date('27-12-2018 16:08:54', 'dd-mm-yyyy hh24:mi:ss'), to_date('13-01-2019 12:19:37', 'dd-mm-yyyy hh24:mi:ss'), null, null, '1', 13, 13, null, null, 5, 3420, '1', null);
insert into ORDERS (uuid, createtime, checktime, starttime, endtime, type, creater, checker, starter, ender, supplieruuid, totalmoney, state, waybillsn)
values (39, to_date('27-12-2018 17:36:12', 'dd-mm-yyyy hh24:mi:ss'), null, null, null, '1', 13, null, null, null, 10, 1516, '0', null);
insert into ORDERS (uuid, createtime, checktime, starttime, endtime, type, creater, checker, starter, ender, supplieruuid, totalmoney, state, waybillsn)
values (43, to_date('01-12-2018 11:03:07', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('28-12-2018 11:03:20', 'dd-mm-yyyy hh24:mi:ss'), '2', 13, null, null, 13, 7, 7923, '1', 5);
insert into ORDERS (uuid, createtime, checktime, starttime, endtime, type, creater, checker, starter, ender, supplieruuid, totalmoney, state, waybillsn)
values (45, to_date('01-03-2018 11:14:21', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('28-12-2018 11:14:39', 'dd-mm-yyyy hh24:mi:ss'), '2', 13, null, null, 13, 11, 2112, '1', 7);
insert into ORDERS (uuid, createtime, checktime, starttime, endtime, type, creater, checker, starter, ender, supplieruuid, totalmoney, state, waybillsn)
values (51, to_date('28-12-2018 12:08:24', 'dd-mm-yyyy hh24:mi:ss'), null, null, null, '1', 13, null, null, null, 10, 911, '0', null);
insert into ORDERS (uuid, createtime, checktime, starttime, endtime, type, creater, checker, starter, ender, supplieruuid, totalmoney, state, waybillsn)
values (59, to_date('13-01-2019 11:58:46', 'dd-mm-yyyy hh24:mi:ss'), null, null, null, '1', 13, null, null, null, 3, 93200, '0', null);
insert into ORDERS (uuid, createtime, checktime, starttime, endtime, type, creater, checker, starter, ender, supplieruuid, totalmoney, state, waybillsn)
values (60, to_date('13-01-2019 12:00:14', 'dd-mm-yyyy hh24:mi:ss'), null, null, null, '2', 13, null, null, null, 11, 16000, '0', null);
insert into ORDERS (uuid, createtime, checktime, starttime, endtime, type, creater, checker, starter, ender, supplieruuid, totalmoney, state, waybillsn)
values (38, to_date('27-12-2018 16:25:41', 'dd-mm-yyyy hh24:mi:ss'), null, null, null, '1', 13, null, null, null, 5, 150, '0', null);
insert into ORDERS (uuid, createtime, checktime, starttime, endtime, type, creater, checker, starter, ender, supplieruuid, totalmoney, state, waybillsn)
values (46, to_date('01-07-2018 11:17:50', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('28-12-2018 11:18:23', 'dd-mm-yyyy hh24:mi:ss'), '2', 13, null, null, 13, 8, 623, '1', 8);
insert into ORDERS (uuid, createtime, checktime, starttime, endtime, type, creater, checker, starter, ender, supplieruuid, totalmoney, state, waybillsn)
values (48, to_date('20-09-2018 11:19:38', 'dd-mm-yyyy hh24:mi:ss'), to_date('28-12-2018 11:19:45', 'dd-mm-yyyy hh24:mi:ss'), to_date('28-12-2018 11:19:50', 'dd-mm-yyyy hh24:mi:ss'), null, '1', 13, 13, 13, null, 6, 1286700, '2', null);
insert into ORDERS (uuid, createtime, checktime, starttime, endtime, type, creater, checker, starter, ender, supplieruuid, totalmoney, state, waybillsn)
values (36, to_date('26-12-2018 18:55:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('26-12-2018 18:55:46', 'dd-mm-yyyy hh24:mi:ss'), to_date('26-12-2018 18:55:51', 'dd-mm-yyyy hh24:mi:ss'), to_date('26-12-2018 18:56:05', 'dd-mm-yyyy hh24:mi:ss'), '1', 13, 13, 13, 13, 3, 468, '3', null);
insert into ORDERS (uuid, createtime, checktime, starttime, endtime, type, creater, checker, starter, ender, supplieruuid, totalmoney, state, waybillsn)
values (49, to_date('01-04-2018 11:20:38', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('28-12-2018 11:20:47', 'dd-mm-yyyy hh24:mi:ss'), '2', 13, null, null, 13, 11, 1479, '1', 10);
insert into ORDERS (uuid, createtime, checktime, starttime, endtime, type, creater, checker, starter, ender, supplieruuid, totalmoney, state, waybillsn)
values (56, to_date('29-12-2018 14:36:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('29-12-2018 14:36:10', 'dd-mm-yyyy hh24:mi:ss'), to_date('29-12-2018 14:36:19', 'dd-mm-yyyy hh24:mi:ss'), to_date('29-12-2018 14:36:32', 'dd-mm-yyyy hh24:mi:ss'), '1', 13, 13, 13, 13, 3, 4560, '3', null);
insert into ORDERS (uuid, createtime, checktime, starttime, endtime, type, creater, checker, starter, ender, supplieruuid, totalmoney, state, waybillsn)
values (57, to_date('29-12-2018 14:37:06', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('12-01-2019 19:13:25', 'dd-mm-yyyy hh24:mi:ss'), '2', 13, null, null, 13, 8, 4230, '1', 12);
commit;
prompt 34 records loaded
prompt Loading RETURNORDERDETAIL...
prompt Table is empty
prompt Loading RETURNORDERS...
prompt Table is empty
prompt Loading ROLE...
insert into ROLE (uuid, name)
values (4, '库管员');
insert into ROLE (uuid, name)
values (5, '总经理');
insert into ROLE (uuid, name)
values (6, '采购主管');
insert into ROLE (uuid, name)
values (7, '采购专员');
insert into ROLE (uuid, name)
values (8, '销售主管');
insert into ROLE (uuid, name)
values (9, '销售专员');
insert into ROLE (uuid, name)
values (10, '库管主管');
insert into ROLE (uuid, name)
values (3, '超级管理员');
commit;
prompt 8 records loaded
prompt Loading ROLE_MENU...
insert into ROLE_MENU (menuuuid, roleuuid)
values ('401', 8);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('403', 8);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('404', 8);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('405', 8);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('406', 8);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('407', 8);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('408', 8);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('409', 8);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('101', 4);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('102', 4);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('200', 4);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('201', 4);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('202', 4);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('501', 4);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('502', 4);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('503', 4);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('105', 10);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('202', 10);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('301', 10);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('401', 10);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('500', 10);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('501', 10);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('502', 10);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('503', 10);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('504', 10);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('505', 10);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('506', 10);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('202', 7);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('301', 7);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('302', 7);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('305', 7);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('100', 3);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('101', 3);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('102', 3);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('103', 3);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('104', 3);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('105', 3);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('200', 3);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('201', 3);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('202', 3);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('300', 3);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('301', 3);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('302', 3);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('303', 3);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('304', 3);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('305', 3);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('306', 3);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('307', 3);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('308', 3);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('309', 3);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('400', 3);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('401', 3);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('402', 3);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('403', 3);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('404', 3);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('405', 3);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('406', 3);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('407', 3);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('408', 3);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('409', 3);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('500', 3);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('501', 3);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('502', 3);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('503', 3);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('504', 3);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('505', 3);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('506', 3);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('600', 3);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('601', 3);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('602', 3);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('603', 3);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('604', 3);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('402', 9);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('101', 6);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('102', 6);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('105', 6);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('301', 6);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('303', 6);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('305', 6);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('306', 6);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('307', 6);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('308', 6);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('309', 6);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('401', 9);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('100', 5);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('101', 5);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('102', 5);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('103', 5);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('104', 5);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('105', 5);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('200', 5);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('201', 5);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('202', 5);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('301', 5);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('401', 5);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('404', 5);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('405', 5);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('504', 5);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('505', 5);
insert into ROLE_MENU (menuuuid, roleuuid)
values ('506', 5);
commit;
prompt 100 records loaded
prompt Loading STORE...
insert into STORE (uuid, name, empuuid)
values (6, '3号仓库', 15);
insert into STORE (uuid, name, empuuid)
values (4, '1号仓库', 13);
insert into STORE (uuid, name, empuuid)
values (5, '2号仓库', 13);
commit;
prompt 3 records loaded
prompt Loading STOREDETAIL...
insert into STOREDETAIL (uuid, storeuuid, goodsuuid, num)
values (8, 4, 18, 3200);
insert into STOREDETAIL (uuid, storeuuid, goodsuuid, num)
values (10, 4, 14, 5800);
insert into STOREDETAIL (uuid, storeuuid, goodsuuid, num)
values (11, 4, 17, 1000);
insert into STOREDETAIL (uuid, storeuuid, goodsuuid, num)
values (1, 5, 14, 312);
insert into STOREDETAIL (uuid, storeuuid, goodsuuid, num)
values (2, 5, 15, 950);
insert into STOREDETAIL (uuid, storeuuid, goodsuuid, num)
values (3, 4, 19, 1015);
insert into STOREDETAIL (uuid, storeuuid, goodsuuid, num)
values (4, 5, 22, 0);
insert into STOREDETAIL (uuid, storeuuid, goodsuuid, num)
values (5, 4, 14, 1000);
insert into STOREDETAIL (uuid, storeuuid, goodsuuid, num)
values (6, 4, 13, 2400);
insert into STOREDETAIL (uuid, storeuuid, goodsuuid, num)
values (14, 5, 25, 700);
insert into STOREDETAIL (uuid, storeuuid, goodsuuid, num)
values (15, 5, 26, 8);
insert into STOREDETAIL (uuid, storeuuid, goodsuuid, num)
values (7, 5, 15, 2900);
insert into STOREDETAIL (uuid, storeuuid, goodsuuid, num)
values (9, 4, 14, 560);
insert into STOREDETAIL (uuid, storeuuid, goodsuuid, num)
values (12, 5, 13, 600);
insert into STOREDETAIL (uuid, storeuuid, goodsuuid, num)
values (13, 5, 16, 600);
commit;
prompt 15 records loaded
prompt Loading STOREOPER...
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (11, 13, to_date('24-12-2018 17:34:09', 'dd-mm-yyyy hh24:mi:ss'), 4, 18, 200, '1');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (20, 13, to_date('01-11-2018 18:56:09', 'dd-mm-yyyy hh24:mi:ss'), 5, 13, 100, '2');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (25, 13, to_date('01-10-2018 10:51:02', 'dd-mm-yyyy hh24:mi:ss'), 5, 16, 200, '2');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (14, 13, to_date('01-11-2018 16:37:32', 'dd-mm-yyyy hh24:mi:ss'), 4, 14, 2000, '1');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (15, 13, to_date('01-07-2018 17:27:39', 'dd-mm-yyyy hh24:mi:ss'), 4, 15, 200, '2');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (16, 13, to_date('01-10-2018 17:33:49', 'dd-mm-yyyy hh24:mi:ss'), 5, 17, 300, '1');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (17, 13, to_date('26-12-2018 17:34:04', 'dd-mm-yyyy hh24:mi:ss'), 4, 17, 300, '2');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (36, 13, to_date('28-12-2018 11:14:33', 'dd-mm-yyyy hh24:mi:ss'), 4, 13, 200, '2');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (38, 13, to_date('28-12-2018 11:18:20', 'dd-mm-yyyy hh24:mi:ss'), 4, 13, 100, '2');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (39, 13, to_date('28-12-2018 11:18:23', 'dd-mm-yyyy hh24:mi:ss'), 5, 25, 100, '2');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (47, 13, to_date('28-12-2018 12:18:32', 'dd-mm-yyyy hh24:mi:ss'), 5, 13, 100, '1');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (1, 13, to_date('01-08-2018 14:52:59', 'dd-mm-yyyy hh24:mi:ss'), 4, 14, 2, '1');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (2, 13, to_date('22-12-2018 15:51:22', 'dd-mm-yyyy hh24:mi:ss'), 5, 15, 10, '1');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (3, 13, to_date('22-12-2018 15:51:28', 'dd-mm-yyyy hh24:mi:ss'), 5, 17, 50, '1');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (4, 13, to_date('23-12-2018 16:11:55', 'dd-mm-yyyy hh24:mi:ss'), 4, 19, 100, '1');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (5, 13, to_date('01-07-2018 16:12:01', 'dd-mm-yyyy hh24:mi:ss'), 5, 22, 100, '1');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (6, 13, to_date('23-12-2018 16:12:06', 'dd-mm-yyyy hh24:mi:ss'), 4, 14, 1000, '1');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (24, 13, to_date('01-06-2018 10:50:57', 'dd-mm-yyyy hh24:mi:ss'), 4, 19, 100, '2');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (34, 13, to_date('28-12-2018 11:12:03', 'dd-mm-yyyy hh24:mi:ss'), 5, 22, 100, '2');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (35, 13, to_date('28-12-2018 11:12:10', 'dd-mm-yyyy hh24:mi:ss'), 5, 16, 100, '2');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (41, 13, to_date('28-12-2018 11:20:02', 'dd-mm-yyyy hh24:mi:ss'), 5, 15, 1000, '1');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (48, 13, to_date('28-12-2018 12:45:12', 'dd-mm-yyyy hh24:mi:ss'), 5, 26, 1, '2');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (53, 13, to_date('12-01-2019 19:13:25', 'dd-mm-yyyy hh24:mi:ss'), 5, 13, 1000, '2');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (7, 13, to_date('23-12-2018 16:24:25', 'dd-mm-yyyy hh24:mi:ss'), 5, 19, 15, '1');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (8, 13, to_date('23-12-2018 16:24:39', 'dd-mm-yyyy hh24:mi:ss'), 5, 19, 1000, '1');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (9, 13, to_date('23-12-2018 16:24:48', 'dd-mm-yyyy hh24:mi:ss'), 5, 13, 1000, '1');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (21, 13, to_date('27-12-2018 16:11:07', 'dd-mm-yyyy hh24:mi:ss'), 4, 13, 500, '1');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (26, 13, to_date('28-12-2018 10:58:11', 'dd-mm-yyyy hh24:mi:ss'), 5, 25, 1000, '1');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (27, 13, to_date('28-12-2018 10:58:14', 'dd-mm-yyyy hh24:mi:ss'), 4, 14, 2000, '1');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (28, 13, to_date('28-12-2018 10:58:54', 'dd-mm-yyyy hh24:mi:ss'), 5, 25, 200, '2');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (29, 13, to_date('28-12-2018 10:58:58', 'dd-mm-yyyy hh24:mi:ss'), 5, 13, 100, '2');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (30, 13, to_date('28-12-2018 11:02:33', 'dd-mm-yyyy hh24:mi:ss'), 4, 13, 2000, '1');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (31, 13, to_date('28-12-2018 11:02:41', 'dd-mm-yyyy hh24:mi:ss'), 5, 26, 10, '1');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (32, 13, to_date('28-12-2018 11:03:16', 'dd-mm-yyyy hh24:mi:ss'), 5, 26, 1, '2');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (33, 13, to_date('28-12-2018 11:03:20', 'dd-mm-yyyy hh24:mi:ss'), 4, 13, 100, '2');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (37, 13, to_date('28-12-2018 11:14:39', 'dd-mm-yyyy hh24:mi:ss'), 4, 17, 200, '2');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (10, 13, to_date('24-12-2018 17:33:56', 'dd-mm-yyyy hh24:mi:ss'), 4, 15, 100, '1');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (12, 13, to_date('25-12-2018 14:54:04', 'dd-mm-yyyy hh24:mi:ss'), 4, 14, 560, '1');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (13, 13, to_date('25-12-2018 16:36:34', 'dd-mm-yyyy hh24:mi:ss'), 5, 15, 3000, '1');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (18, 13, to_date('26-12-2018 18:54:39', 'dd-mm-yyyy hh24:mi:ss'), 4, 14, 100, '2');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (19, 13, to_date('26-12-2018 18:56:05', 'dd-mm-yyyy hh24:mi:ss'), 4, 13, 200, '1');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (22, 13, to_date('27-12-2018 17:42:05', 'dd-mm-yyyy hh24:mi:ss'), 5, 18, 3000, '1');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (23, 13, to_date('27-12-2018 17:42:10', 'dd-mm-yyyy hh24:mi:ss'), 5, 16, 1000, '1');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (40, 13, to_date('28-12-2018 11:19:03', 'dd-mm-yyyy hh24:mi:ss'), 4, 14, 100, '2');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (42, 13, to_date('28-12-2018 11:20:06', 'dd-mm-yyyy hh24:mi:ss'), 5, 14, 300, '1');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (43, 13, to_date('28-12-2018 11:20:09', 'dd-mm-yyyy hh24:mi:ss'), 4, 17, 1000, '1');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (44, 13, to_date('28-12-2018 11:20:20', 'dd-mm-yyyy hh24:mi:ss'), 5, 15, 100, '2');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (45, 13, to_date('28-12-2018 11:20:44', 'dd-mm-yyyy hh24:mi:ss'), 5, 16, 100, '2');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (46, 13, to_date('28-12-2018 11:20:47', 'dd-mm-yyyy hh24:mi:ss'), 4, 13, 200, '2');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (49, 13, to_date('29-12-2018 14:36:28', 'dd-mm-yyyy hh24:mi:ss'), 5, 13, 1000, '1');
insert into STOREOPER (uuid, empuuid, opertime, storeuuid, goodsuuid, num, type)
values (50, 13, to_date('29-12-2018 14:36:32', 'dd-mm-yyyy hh24:mi:ss'), 4, 14, 2000, '1');
commit;
prompt 51 records loaded
prompt Loading SUPPLIER...
insert into SUPPLIER (uuid, name, address, contact, tele, email, type)
values (8, '小米', '北京', '雷军', '15037584366', '15037584366@163.com', '2');
insert into SUPPLIER (uuid, name, address, contact, tele, email, type)
values (11, '饿了么', '北京市', '张旭豪', '17703771999', '17703771999@163.com', '2');
insert into SUPPLIER (uuid, name, address, contact, tele, email, type)
values (3, '喜乐融', '河南', '石某', '13883757655', '13883757655@qq.com', '1');
insert into SUPPLIER (uuid, name, address, contact, tele, email, type)
values (10, '华为', '深圳', '任正非', '15037584595', 'rzf@qq.com', '1');
insert into SUPPLIER (uuid, name, address, contact, tele, email, type)
values (5, '阿里巴巴', '浙江杭州', '马云', '15037584395', 'jackma@163.com', '1');
insert into SUPPLIER (uuid, name, address, contact, tele, email, type)
values (6, '腾讯', '深圳', '马化腾', '13883757655', 'mahuateng@163.com', '1');
insert into SUPPLIER (uuid, name, address, contact, tele, email, type)
values (7, '美团', '北京市朝阳区望京东路6号', '王兴', '15037454890', '15037454890@163.com', '2');
commit;
prompt 7 records loaded
set feedback on
set define on
prompt Done.
