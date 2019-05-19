package com.redsum.bos.entity;
/**
 * 实体类
 * @author Administrator *
 */
public class Waybilldetail {	
	private Long id;//ID
	private Long sn;//运单号
	private String exedate;//执行日期
	private String exetime;//执行时间
	private String info;//执行信息

	public Long getId() {		
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Long getSn() {		
		return sn;
	}
	public void setSn(Long sn) {
		this.sn = sn;
	}
	public String getExedate() {		
		return exedate;
	}
	public void setExedate(String exedate) {
		this.exedate = exedate;
	}
	public String getExetime() {		
		return exetime;
	}
	public void setExetime(String exetime) {
		this.exetime = exetime;
	}
	public String getInfo() {		
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}

}
