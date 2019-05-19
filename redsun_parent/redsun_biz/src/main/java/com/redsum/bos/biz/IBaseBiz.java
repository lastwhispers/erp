package com.redsum.bos.biz;

import java.util.List;

/**
 * 通用业务逻辑接口
 * @author Administrator
 *
 * @param <T>
 */
public interface IBaseBiz<T> {
	
	/**
	 * 条件查询
	 * @param t1
	 * @return
	 */
	List<T> getList(T t1,T t2,Object param);
	
	/**
	 * 分页查询
	 * @param t1
	 * @param t2
	 * @param param
	 * @param firstResult
	 * @param maxResults
	 * @return
	 */
	List<T> getListByPage(T t1,T t2,Object param,int firstResult, int maxResults);
	
	/**
	 * 计算总记录数
	 * @param t1
	 * @param t2
	 * @param param
	 * @return
	 */
	public long getCount(T t1,T t2,Object param);
	
	/**
	 * 新增
	 * @param t
	 */
	void add(T t);
	
	/**
	 * 删除
	 */
	void delete(Long uuid);
	
	/**
	 * 通过编号查询对象
	 * @param uuid
	 * @return
	 */
	T get(Long uuid);
	
	/**
	 * 更新
	 */
	void update(T t);
}
