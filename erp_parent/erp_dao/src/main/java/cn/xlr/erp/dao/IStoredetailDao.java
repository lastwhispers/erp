package cn.xlr.erp.dao;

import java.util.List;

import cn.xlr.erp.entity.Storealert;
import cn.xlr.erp.entity.Storedetail;
/**
 * 仓库库存数据访问接口
 * @author Administrator
 *
 */
public interface IStoredetailDao extends IBaseDao<Storedetail>{
	/**
	 * 获取库存预警列表
	 * @return
	 */
	public List<Storealert> getStorealertList();
}
