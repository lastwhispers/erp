package cn.xlr.erp.entity;

import com.alibaba.fastjson.annotation.JSONField;

/**
 * 订单明细实体类
 * @author Administrator *
 */
public class Orderdetail {	
	
	/**未入库 */
	public static final String STATE_NOT_IN = "0";
	/**已入库*/
	public static final String STATE_IN = "1";
	
	/**未出库 */
	public static final String STATE_NOT_OUT = "0";
	/**已出库*/
	public static final String STATE_OUT = "1";
	
	private Long uuid;//编号
	private Long goodsuuid;//商品编号
	private String goodsname;//商品名称
	private Double price;//价格
	private Long num;//数量
	private Double money;//金额
	private java.util.Date endtime;//结束日期
	private Long ender;//库管员
	private Long storeuuid;//仓库编号
	private String state;//采购：0=未入库，1=已入库  销售：0=未出库，1=已出库
	/** 导到死循环 */
	@JSONField(serialize=false)
	private Orders orders;//订单

	public Orders getOrders() {
		return orders;
	}
	public void setOrders(Orders orders) {
		this.orders = orders;
	}
	public Long getUuid() {		
		return uuid;
	}
	public void setUuid(Long uuid) {
		this.uuid = uuid;
	}
	public Long getGoodsuuid() {		
		return goodsuuid;
	}
	public void setGoodsuuid(Long goodsuuid) {
		this.goodsuuid = goodsuuid;
	}
	public String getGoodsname() {		
		return goodsname;
	}
	public void setGoodsname(String goodsname) {
		this.goodsname = goodsname;
	}
	public Double getPrice() {		
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	public Long getNum() {		
		return num;
	}
	public void setNum(Long num) {
		this.num = num;
	}
	public Double getMoney() {		
		return money;
	}
	public void setMoney(Double money) {
		this.money = money;
	}
	public java.util.Date getEndtime() {		
		return endtime;
	}
	public void setEndtime(java.util.Date endtime) {
		this.endtime = endtime;
	}
	public Long getEnder() {		
		return ender;
	}
	public void setEnder(Long ender) {
		this.ender = ender;
	}
	public Long getStoreuuid() {		
		return storeuuid;
	}
	public void setStoreuuid(Long storeuuid) {
		this.storeuuid = storeuuid;
	}
	public String getState() {		
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}

}
