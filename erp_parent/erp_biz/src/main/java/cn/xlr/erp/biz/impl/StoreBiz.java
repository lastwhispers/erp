package cn.xlr.erp.biz.impl;
import cn.xlr.erp.biz.IStoreBiz;
import cn.xlr.erp.dao.IStoreDao;
import cn.xlr.erp.entity.Store;
/**
 * 仓库业务逻辑类
 * @author Administrator
 *
 */
public class StoreBiz extends BaseBiz<Store> implements IStoreBiz {

	private IStoreDao storeDao;
	
	public void setStoreDao(IStoreDao storeDao) {
		this.storeDao = storeDao;
		super.setBaseDao(this.storeDao);
	}
	
}
