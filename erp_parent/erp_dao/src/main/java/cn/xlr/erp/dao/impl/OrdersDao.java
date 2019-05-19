package cn.xlr.erp.dao.impl;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import cn.xlr.erp.dao.IOrdersDao;
import cn.xlr.erp.entity.Orders;
/**
 * 订单数据访问类
 * @author Administrator
 *
 */
public class OrdersDao extends BaseDao<Orders> implements IOrdersDao {

	/**
	 * 构建查询条件
	 * @param dep1
	 * @param dep2
	 * @param param
	 * @return
	 */
	public DetachedCriteria getDetachedCriteria(Orders orders1,Orders orders2,Object param){
		DetachedCriteria dc=DetachedCriteria.forClass(Orders.class);
		if(orders1!=null){
			//根据订单类型查询
			if(null != orders1.getType() && orders1.getType().trim().length()>0){
				dc.add(Restrictions.eq("type", orders1.getType()));
			}
			//根据订单状态查询
			if(null != orders1.getState() && orders1.getState().trim().length()>0){
				dc.add(Restrictions.eq("state", orders1.getState()));
			}
			//根据订单的创建者查询
			if(null != orders1.getCreater()){
				dc.add(Restrictions.eq("creater", orders1.getCreater()));
			}

		}
		return dc;
	}

}
