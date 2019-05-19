package cn.xlr.erp.biz.impl;
import cn.xlr.erp.biz.IDepBiz;
import cn.xlr.erp.dao.IDepDao;
import cn.xlr.erp.entity.Dep;
/**
 * 部门业务逻辑类
 * @author Administrator
 *
 */
public class DepBiz extends BaseBiz<Dep> implements IDepBiz {

	private IDepDao depDao;
	
	public void setDepDao(IDepDao depDao) {
		this.depDao = depDao;
		super.setBaseDao(this.depDao);
	}
	
}
