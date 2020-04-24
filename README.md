>该项目文档、源码地址：https://github.com/lastwhispers/erp
该系统的权限部分已单独提取出来 https://www.jianshu.com/p/43b007b2973e

# 1. 项目简介

针对于中小型商贸企业的资源管理系统，是企业内部使用的综合信息管理服务平台。企业数据以WEB形式采集录入系统，经过收集汇总后，为各级终端用户提供日常业务信息管理、业务流程执行等日常办公服务辅助平台，辅助本职能部门出具预案决策，提高整体企业内部业务工作效率。

建立企业的管理信息系统，支持大量原始数据的查询、汇总。

借助计算机的运算能力及系统对客户订单、在库物料、产品构成的管理能力，实现依据客户订单，按照产品结构清单展开并计算物料需求计划，实现减少库存，优化库存的管理目标。

在企业中形成以计算机为核心的闭环管理系统，使企业的人、财、物、供、产、销全面结合、全面受控、实时反馈、动态协调、以销定产、以产求供，降低成本。

......

其余的都在文档上。

![ERP简介](https://upload-images.jianshu.io/upload_images/5336514-e43bb7330404c9fb.gif?imageMogr2/auto-orient/strip)

# 2. 技术框架

- 三大框架：SSH2（struts2、hibernate5、spring4）
- 日志框架：log4j
- 权限框架：shiro
- 定时任务：quartz
- Excel导入导出：poi
- UI框架：Easyui
- JS框架：Jquery 
- 饼状图折线图：highcharts等

# 3. 开发环境

建议开发者使用以下环境，可以避免版本带来的问题

- IDE：Eclipse（Idea等）
- JDK：JDK1.8
- Maven：Maven3.2.+
- DB：oracle10g、Mysql5.7、Redis

>oracle10g、PLSQL Developer安装教程：https://www.cnblogs.com/gj-blog/p/9388999.html
>SqlDeveloper下载地址：https://dl.pconline.com.cn/download/1030266.html


# 4. 项目功能展示

## 4.1 基础数据

![基础数据](https://upload-images.jianshu.io/upload_images/5336514-7ccea9a5285b6836.gif?imageMogr2/auto-orient/strip)

![基础数据2](https://upload-images.jianshu.io/upload_images/5336514-79c72407a173a5cb.gif?imageMogr2/auto-orient/strip)

## 4.2 人事管理

![人事管理](https://upload-images.jianshu.io/upload_images/5336514-2545e17f92e99107.gif?imageMogr2/auto-orient/strip)

## 4.3 采购管理

采购订单查询支持Excel导出

![采购订单查询](https://upload-images.jianshu.io/upload_images/5336514-da16798aff54d617.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![采购订单审核](https://upload-images.jianshu.io/upload_images/5336514-f6062f0ab08ffa81.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![采购订单确认](https://upload-images.jianshu.io/upload_images/5336514-a705d46e7e5036e4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![采购订单入库](https://upload-images.jianshu.io/upload_images/5336514-4214712a330d4810.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![我的采购订单](https://upload-images.jianshu.io/upload_images/5336514-6dcfc9884525b4a3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![采购申请](https://upload-images.jianshu.io/upload_images/5336514-07943d9b1149616b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![采购申请成功](https://upload-images.jianshu.io/upload_images/5336514-d22b4664d22a7bc7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

......

## 4.4 销售管理

销售订单查询支持运单号查询

![销售订单查询](https://upload-images.jianshu.io/upload_images/5336514-96db4e61d757d79c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![销售订单录入](https://upload-images.jianshu.io/upload_images/5336514-8c2b274bcb5b3533.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![销售订单出库](https://upload-images.jianshu.io/upload_images/5336514-76f0de541bcb03d0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![销售统计报表](https://upload-images.jianshu.io/upload_images/5336514-76b966b6abd28952.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![销售趋势报表](https://upload-images.jianshu.io/upload_images/5336514-184cf2fce4dbe0ad.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

......

## 4.5 库存管理

![库存查询](https://upload-images.jianshu.io/upload_images/5336514-45b41d919697c706.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![库存变动记录](https://upload-images.jianshu.io/upload_images/5336514-3e17d0bcf3eee1cd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![库存预警](https://upload-images.jianshu.io/upload_images/5336514-f98791325c02d516.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![库存预警邮件](https://upload-images.jianshu.io/upload_images/5336514-dee7ac420b436374.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

......

## 4.6 权限管理

![重置密码](https://upload-images.jianshu.io/upload_images/5336514-a3a7c879e34a1313.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![角色设置](https://upload-images.jianshu.io/upload_images/5336514-168e4bf171e8217f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![角色权限设置](https://upload-images.jianshu.io/upload_images/5336514-c783f81db35f0016.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![用户角色设置](https://upload-images.jianshu.io/upload_images/5336514-3fe5c94962031df6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 4.7 更多详情

更多项目详情请参照项目文档和源码

![更多详情](https://upload-images.jianshu.io/upload_images/5336514-08edb2a59d419368.gif?imageMogr2/auto-orient/strip)


# 5. 如何安装运行


在 https://github.com/ggb2312/Erp 上有两个项目erp与redsun

![erp与redsun](https://upload-images.jianshu.io/upload_images/5336514-74a405c7fd27d3ca.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

erp项目是企业资源计划管理系统；redsun项目是一个物流系统（该系统只做了一点）。所以erp项目是最主要的项目，redsun项目只是为erp项目的销售订单模块提供运单查询功能而已，redsun项目甚至可以不使用，这里只是提供上供大家选择。

![运单查询](https://upload-images.jianshu.io/upload_images/5336514-c1ca9da9d0449f78.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

**第一步：导入项目**

先导入Erp项目，配置好Maven。

**第二步：启动Oracle并导入sql**

在erpsql目录下，有erp项目sql安装步骤。

![sql导入步骤](https://upload-images.jianshu.io/upload_images/5336514-c95521aea1f6b1b8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

将Sql导入Oracle中，修改erp_dao中的applicationContext_datasource.xml里面数据库账号密码。

**第三步：启动Redis**

解压 redis2.8win32.zip运行redis-server.exe即可。

**第四步：配置邮箱（可选）**

在erp系统中使用了邮件发送库存不足的预警信息，所以需要配置邮箱。

>网易邮箱配置教程    https://blog.csdn.net/pdsu161530247/article/details/82015557 
