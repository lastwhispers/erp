package com.redsum.bos.biz.impl;
import com.redsum.bos.biz.IWaybillBiz;
import com.redsum.bos.dao.IWaybillDao;
import com.redsum.bos.entity.Waybill;
/**
 * 业务逻辑类
 * @author Administrator
 *
 */
public class WaybillBiz extends BaseBiz<Waybill> implements IWaybillBiz {

	private IWaybillDao waybillDao;
	
	public void setWaybillDao(IWaybillDao waybillDao) {
		this.waybillDao = waybillDao;
		super.setBaseDao(this.waybillDao);
	}
	
}
