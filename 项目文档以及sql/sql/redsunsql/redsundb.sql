CREATE DATABASE redsun DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

use redsun;

CREATE TABLE `waybill` (
  `sn` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '运单号',
  `userid` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `toaddress` varchar(100) DEFAULT NULL COMMENT '收货地址',
  `addressee` varchar(100) DEFAULT NULL COMMENT '收货人',
  `tele` varchar(100) DEFAULT NULL COMMENT '收件人电话',
  `info` varchar(2000) DEFAULT NULL COMMENT '运单详情',
  `state` varchar(1) DEFAULT NULL COMMENT '运单状态',
  PRIMARY KEY (`sn`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

CREATE TABLE `waybilldetail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `sn` bigint(20) DEFAULT NULL COMMENT '运单号',
  `exedate` varchar(10) DEFAULT NULL COMMENT '执行日期',
  `exetime` varchar(10) DEFAULT NULL COMMENT '执行时间',
  `info` varchar(100) DEFAULT NULL COMMENT '执行信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
