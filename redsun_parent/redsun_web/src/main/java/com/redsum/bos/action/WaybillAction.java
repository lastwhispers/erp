package com.redsum.bos.action;
import com.redsum.bos.biz.IWaybillBiz;
import com.redsum.bos.entity.Waybill;

/**
 * Action 
 * @author Administrator
 *
 */
public class WaybillAction extends BaseAction<Waybill> {

	private IWaybillBiz waybillBiz;

	public void setWaybillBiz(IWaybillBiz waybillBiz) {
		this.waybillBiz = waybillBiz;
		super.setBaseBiz(this.waybillBiz);
	}

}
