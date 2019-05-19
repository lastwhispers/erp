package com.redsum.bos.action;
import com.redsum.bos.biz.IWaybilldetailBiz;
import com.redsum.bos.entity.Waybilldetail;

/**
 * Action 
 * @author Administrator
 *
 */
public class WaybilldetailAction extends BaseAction<Waybilldetail> {

	private IWaybilldetailBiz waybilldetailBiz;

	public void setWaybilldetailBiz(IWaybilldetailBiz waybilldetailBiz) {
		this.waybilldetailBiz = waybilldetailBiz;
		super.setBaseBiz(this.waybilldetailBiz);
	}

}
