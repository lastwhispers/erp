package com.redsum.bos.dao.impl;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.springframework.orm.hibernate5.support.HibernateDaoSupport;

import com.redsum.bos.dao.IBaseDao;

/**
 * 通用数据访问层
 * @author Administrator
 *
 * @param <T>
 */
@SuppressWarnings("unchecked")
public class BaseDao<T> extends HibernateDaoSupport implements IBaseDao<T> {
	
	/** 泛型中的初阶类型 */
	private Class<T> entityClass;
	
	public BaseDao(){
		//获取对象对应的父类的类型
		Type baseDaoClass = this.getClass().getGenericSuperclass();
		//转成带参数，即泛型的类型
		ParameterizedType pType = (ParameterizedType)baseDaoClass;
		//获取参数泛型类型数组
		Type[] types = pType.getActualTypeArguments();
		//由于我们的BaseDao<T>的泛型参数里只有一个类型T，因此数组的第一个元素就是类型T的实际上的类型
		entityClass = (Class<T>)types[0];
	}

	/**
	 * 条件查询
	 */
	public List<T> getList(T t1,T t2,Object param) {
		DetachedCriteria dc = getDetachedCriteria(t1,t2,param);
		return (List<T>) this.getHibernateTemplate().findByCriteria(dc);
	}
	
	/**
	 * 分页查询
	 * @param t1
	 * @param t2
	 * @param param
	 * @param firstResult
	 * @param maxResults
	 * @return
	 */
	public List<T> getListByPage(T t1,T t2,Object param,int firstResult, int maxResults) {
		DetachedCriteria dc = getDetachedCriteria(t1,t2,param);
		return (List<T>) this.getHibernateTemplate().findByCriteria(dc,firstResult, maxResults);
	}

	/**
	 * 记录条件查询的总记录数
	 * @param t1
	 * @return
	 */
	public long getCount(T t1,T t2,Object param) {
		DetachedCriteria dc = getDetachedCriteria(t1,t2,param);
		dc.setProjection(Projections.rowCount());
		List<Long> list = (List<Long>)getHibernateTemplate().findByCriteria(dc);
		return list.get(0);
	}
	
	/**
	 * 新增
	 * @param t
	 */
	public void add(T t){
		this.getHibernateTemplate().save(t);
	}
	
	/**
	 * 删除
	 */
	public void delete(Long uuid){
		//让对象进入持久化状态
		T t = this.getHibernateTemplate().get(entityClass, uuid);
		//删除持久化状态
		this.getHibernateTemplate().delete(t);
	}
	
	/**
	 * 通过编号查询对象
	 * @param uuid
	 * @return
	 */
	public T get(Long uuid){
		return getHibernateTemplate().get(entityClass, uuid);
	}
	
	/**
	 * 更新
	 */
	public void update(T t){
		this.getHibernateTemplate().update(t);
	}
	
	/**
	 * 由子类实现
	 * @param t1
	 * @return
	 */
	public DetachedCriteria getDetachedCriteria(T t1, T t2, Object param){
		
		return null;
	}
}
