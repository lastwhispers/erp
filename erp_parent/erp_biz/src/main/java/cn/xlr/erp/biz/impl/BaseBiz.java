package cn.xlr.erp.biz.impl;

import java.util.List;
import java.util.Map;

import cn.xlr.erp.biz.IBaseBiz;
import cn.xlr.erp.dao.IBaseDao;
import cn.xlr.erp.dao.IEmpDao;
import cn.xlr.erp.dao.IGoodsDao;
import cn.xlr.erp.dao.IStoreDao;
/**
 * 通用业务逻辑实现类
 * @author Administrator
 *
 * @param <T>
 */
public class BaseBiz<T> implements IBaseBiz<T> {

	/** 数据访问注入*/
	private IBaseDao<T> baseDao;

	public void setBaseDao(IBaseDao<T> baseDao) {
		this.baseDao = baseDao;
	}
	
	/**
	 * 条件查询
	 * @param t1
	 * @return
	 */
	public List<T> getList(T t1,T t2,Object param){
		return baseDao.getList(t1,t2,param);
	}
	
	/**
	 * 条件查询
	 * @param t1
	 * @return
	 */
	public List<T> getListByPage(T t1,T t2,Object param,int firstResult, int maxResults){
		return baseDao.getListByPage(t1,t2,param,firstResult, maxResults);
	}

	@Override
	public long getCount(T t1,T t2,Object param) {
		return baseDao.getCount(t1,t2,param);
	}

	@Override
	public void add(T t) {
		baseDao.add(t);
	}

	/**
	 * 删除
	 */
	public void delete(Long uuid){
		baseDao.delete(uuid);
	}
	
	/**
	 * 通过编号查询对象
	 * @param uuid
	 * @return
	 */
	public T get(Long uuid){
		return baseDao.get(uuid);
	}
	
	/**
	 * 通过字符串编号查询对象
	 * @param uuid
	 * @return
	 */
	public T get(String uuid){
		return baseDao.get(uuid);
	}
	
	/**
	 * 更新
	 */
	public void update(T t){
		baseDao.update(t);
	}
	
	public String getGoodsName(Long uuid, Map<Long, String> goodsNameMap, IGoodsDao goodsDao){
		if(null == uuid){
			return null;
		}
		String goodsName = goodsNameMap.get(uuid);
		if(null == goodsName){
			goodsName = goodsDao.get(uuid).getName();
			goodsNameMap.put(uuid, goodsName);
		}
		return goodsName;
	}
	
	public String getStoreName(Long uuid, Map<Long, String> storeNameMap, IStoreDao storeDao){
		if(null == uuid){
			return null;
		}
		String storeName = storeNameMap.get(uuid);
		if(null == storeName){
			storeName = storeDao.get(uuid).getName();
			storeNameMap.put(uuid, storeName);
		}
		return storeName;
	}

	/**
	 * 获取员工名称
	 * @param uuid 员工编号
	 * @param empNameMap 缓存员工编号与员工的名称 
	 * @return 返回员工名称
	 */
	public String getEmpName(Long uuid, Map<Long, String> empNameMap, IEmpDao empDao){
		if(null == uuid){
			return null;
		}
		//从缓存中根据员工编号取出员工名称
		String empName = empNameMap.get(uuid);
		if(null == empName){
			//如果没有找员工的名称，则进行数据库查询
			empName = empDao.get(uuid).getName();
			//存入缓存中
			empNameMap.put(uuid, empName);
		}
		return empName;
	}
}

