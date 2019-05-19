package cn.xlr.erp.biz.impl;
import cn.xlr.erp.biz.IReturnorderdetailBiz;
import cn.xlr.erp.dao.IReturnorderdetailDao;
import cn.xlr.erp.entity.Returnorderdetail;
/**
 * 退货订单明细业务逻辑类
 * @author Administrator
 *
 */
public class ReturnorderdetailBiz extends BaseBiz<Returnorderdetail> implements IReturnorderdetailBiz {

	private IReturnorderdetailDao returnorderdetailDao;
	
	public void setReturnorderdetailDao(IReturnorderdetailDao returnorderdetailDao) {
		this.returnorderdetailDao = returnorderdetailDao;
		super.setBaseDao(this.returnorderdetailDao);
	}
	
}
