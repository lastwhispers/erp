CREATE TABLE `dep`
(
  uuid bigint not null,
  name varchar(30),
  tele varchar(30)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `dep` MODIFY COLUMN `uuid` bigint NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`uuid`);

CREATE TABLE `emp`
(
  uuid     bigint not null,
  username varchar(15),
  pwd      varchar(32),
  name     varchar(28),
  gender   bigint,
  email    varchar(255),
  tele     varchar(30),
  address  varchar(255),
  birthday datetime,
  depuuid  bigint
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `emp` MODIFY COLUMN `uuid` bigint NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`uuid`);

CREATE TABLE `emp_role`
(
  empuuid  bigint,
  roleuuid bigint
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `goods`
(
  uuid          bigint not null,
  name          varchar(30),
  origin        varchar(30),
  producer      varchar(30),
  unit          varchar(30),
  inprice       decimal(8,2),
  outprice      decimal(8,2),
  goodstypeuuid bigint
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `goods` MODIFY COLUMN `uuid` bigint NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`uuid`);

CREATE TABLE `goodstype`
(
  uuid bigint not null,
  name varchar(30)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `goodstype` MODIFY COLUMN `uuid` bigint NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`uuid`);

CREATE TABLE `inventory`
(
  uuid       bigint not null,
  goodsuuid  bigint,
  storeuuid  bigint,
  num        bigint,
  type       varchar(1),
  createtime datetime,
  checktime  datetime,
  creater    bigint,
  checker    bigint,
  state      varchar(1),
  remark     varchar(200)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `inventory` MODIFY COLUMN `uuid` bigint NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`uuid`);

CREATE TABLE `menu`
(
  menuid   varchar(20) not null,
  menuname varchar(30),
  icon     varchar(20),
  url      varchar(255),
  pid      varchar(20)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `menu` ADD PRIMARY KEY (`menuid`);

CREATE TABLE `orderdetail`
(
  uuid       bigint not null,
  goodsuuid  bigint,
  goodsname  varchar(50),
  price      decimal(10,2),
  num        bigint,
  money      decimal(10,2),
  endtime    datetime,
  ender      bigint,
  storeuuid  bigint,
  state      varchar(1),
  ordersuuid bigint
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `orderdetail` MODIFY COLUMN `uuid` bigint NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`uuid`);

CREATE TABLE `orders`
(
  uuid         bigint not null,
  createtime   datetime,
  checktime    datetime,
  starttime    datetime,
  endtime      datetime,
  type         varchar(1),
  creater      bigint,
  checker      bigint,
  starter      bigint,
  ender        bigint,
  supplieruuid bigint,
  totalmoney   decimal(10,2),
  state        varchar(1),
  waybillsn    bigint
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `orders` MODIFY COLUMN `uuid` bigint NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`uuid`);

CREATE TABLE `returnorderdetail`
(
  uuid       bigint not null,
  goodsuuid  bigint,
  goodsname  varchar(50),
  price      decimal(10,2),
  num        bigint,
  money      decimal(10,2),
  endtime    datetime,
  ender      bigint,
  storeuuid  bigint,
  state      varchar(1),
  ordersuuid bigint
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `returnorderdetail` MODIFY COLUMN `uuid` bigint NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`uuid`);

CREATE TABLE `returnorders`
(
  uuid         bigint not null,
  createtime   datetime,
  checktime    datetime,
  endtime      datetime,
  type         varchar(1),
  creater      bigint,
  checker      bigint,
  ender        bigint,
  supplieruuid bigint,
  totalmoney   decimal(10,2),
  state        varchar(1),
  waybillsn    bigint,
  ordersuuid   bigint
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `returnorders` MODIFY COLUMN `uuid` bigint NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`uuid`);

CREATE TABLE `role`
(
  uuid bigint not null,
  name varchar(30)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `role` MODIFY COLUMN `uuid` bigint NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`uuid`);

CREATE TABLE `role_menu`
(
  menuuuid varchar(10),
  roleuuid bigint
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `store`
(
  uuid    bigint not null,
  name    varchar(30),
  empuuid bigint
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `store` MODIFY COLUMN `uuid` bigint NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`uuid`);

CREATE TABLE `storedetail`
(
  uuid      bigint not null,
  storeuuid bigint,
  goodsuuid bigint,
  num       bigint
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `storedetail` MODIFY COLUMN `uuid` bigint NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`uuid`);

CREATE TABLE `storeoper`
(
  uuid      bigint not null,
  empuuid   bigint,
  opertime  datetime,
  storeuuid bigint,
  goodsuuid bigint,
  num       bigint,
  type      varchar(1)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `storeoper` MODIFY COLUMN `uuid` bigint NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`uuid`);

CREATE TABLE `supplier`
(
  uuid    bigint not null,
  name    varchar(30),
  address varchar(100),
  contact varchar(30),
  tele    varchar(30),
  email   varchar(100),
  type    varchar(1)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `supplier` MODIFY COLUMN `uuid` bigint NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`uuid`);
