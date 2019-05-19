package com.redsum.bos.ws.impl;

import java.util.List;

import com.redsum.bos.biz.IWaybillBiz;
import com.redsum.bos.biz.IWaybilldetailBiz;
import com.redsum.bos.entity.Waybill;
import com.redsum.bos.entity.Waybilldetail;
import com.redsum.bos.ws.IWaybillWs;

public class WaybillWs implements IWaybillWs {
	
	private IWaybillBiz waybillBiz;
	private IWaybilldetailBiz waybilldetailBiz;

	public void setWaybillBiz(IWaybillBiz waybillBiz) {
		this.waybillBiz = waybillBiz;
	}

	public void setWaybilldetailBiz(IWaybilldetailBiz waybilldetailBiz) {
		this.waybilldetailBiz = waybilldetailBiz;
	}

	/**
	 * 查询运单详情
	 * @param id
	 * @return
	 */
	public List<Waybilldetail> waybilldetailList(Long sn) {
		//构建查询条件
		Waybilldetail waybilldetail = new Waybilldetail();
		waybilldetail.setSn(sn);
		return waybilldetailBiz.getList(waybilldetail, null, null);
	}

	@Override
	public Long addWaybill(Long id, String toAddress, String addressee, String tele, String info) {
		Waybill waybill = new Waybill();
		// 下单id
		waybill.setUserid(id);
		// 收货地址
		waybill.setToaddress(toAddress);
		// 运单详情
		waybill.setInfo(info);
		// 0：待发 1：在途 2：结束
		waybill.setState("0");
		// 收件人电话
		waybill.setTele(tele);
		// 收货人
		waybill.setAddressee(addressee);
		waybillBiz.add(waybill);
		return waybill.getSn();
	}

}
