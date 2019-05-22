--表空间

CREATE TABLESPACE ERP_TS
DATAFILE 'c:\\oraclefile\\erp.dbf'
SIZE 100m
AUTOEXTEND ON
NEXT 10m;

--创建用户
create user root--用户
identified by root--密码
default tablespace ERP_TS;
--授权
grant dba to root;
