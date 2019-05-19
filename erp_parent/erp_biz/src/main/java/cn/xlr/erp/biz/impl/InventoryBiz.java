package cn.xlr.erp.biz.impl;
import cn.xlr.erp.biz.IInventoryBiz;
import cn.xlr.erp.dao.IInventoryDao;
import cn.xlr.erp.entity.Inventory;
/**
 * 盘盈盘亏业务逻辑类
 * @author Administrator
 *
 */
public class InventoryBiz extends BaseBiz<Inventory> implements IInventoryBiz {

	private IInventoryDao inventoryDao;
	
	public void setInventoryDao(IInventoryDao inventoryDao) {
		this.inventoryDao = inventoryDao;
		super.setBaseDao(this.inventoryDao);
	}
	
}
