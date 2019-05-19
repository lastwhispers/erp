package com.redsum.bos.biz.impl;
import com.redsum.bos.biz.IWaybilldetailBiz;
import com.redsum.bos.dao.IWaybilldetailDao;
import com.redsum.bos.entity.Waybilldetail;
/**
 * 业务逻辑类
 * @author Administrator
 *
 */
public class WaybilldetailBiz extends BaseBiz<Waybilldetail> implements IWaybilldetailBiz {

	private IWaybilldetailDao waybilldetailDao;
	
	public void setWaybilldetailDao(IWaybilldetailDao waybilldetailDao) {
		this.waybilldetailDao = waybilldetailDao;
		super.setBaseDao(this.waybilldetailDao);
	}
	
}
