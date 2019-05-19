package cn.xlr.erp.biz.impl;
import cn.xlr.erp.biz.IReturnordersBiz;
import cn.xlr.erp.dao.IReturnordersDao;
import cn.xlr.erp.entity.Returnorders;
/**
 * 退货订单业务逻辑类
 * @author Administrator
 *
 */
public class ReturnordersBiz extends BaseBiz<Returnorders> implements IReturnordersBiz {

	private IReturnordersDao returnordersDao;
	
	public void setReturnordersDao(IReturnordersDao returnordersDao) {
		this.returnordersDao = returnordersDao;
		super.setBaseDao(this.returnordersDao);
	}
	
}
