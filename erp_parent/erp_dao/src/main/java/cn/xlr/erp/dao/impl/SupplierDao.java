package cn.xlr.erp.dao.impl;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;

import cn.xlr.erp.dao.ISupplierDao;
import cn.xlr.erp.entity.Supplier;
/**
 * 供应商数据访问类
 * @author Administrator
 *
 */
public class SupplierDao extends BaseDao<Supplier> implements ISupplierDao {

	/**
	 * 构建查询条件
	 * @param dep1
	 * @param dep2
	 * @param param
	 * @return
	 */
	public DetachedCriteria getDetachedCriteria(Supplier supplier1,Supplier supplier2,Object param){
		DetachedCriteria dc=DetachedCriteria.forClass(Supplier.class);
		if(supplier1!=null){
			if(null != supplier1.getName() && supplier1.getName().trim().length()>0){
				dc.add(Restrictions.like("name", supplier1.getName(), MatchMode.ANYWHERE));
			}
			if(null != supplier1.getAddress() && supplier1.getAddress().trim().length()>0){
				dc.add(Restrictions.like("address", supplier1.getAddress(), MatchMode.ANYWHERE));
			}
			if(null != supplier1.getContact() && supplier1.getContact().trim().length()>0){
				dc.add(Restrictions.like("contact", supplier1.getContact(), MatchMode.ANYWHERE));
			}
			if(null != supplier1.getTele() && supplier1.getTele().trim().length()>0){
				dc.add(Restrictions.like("tele", supplier1.getTele(), MatchMode.ANYWHERE));
			}
			if(null != supplier1.getEmail() && supplier1.getEmail().trim().length()>0){
				dc.add(Restrictions.like("email", supplier1.getEmail(), MatchMode.ANYWHERE));
			}
			//根据类型查询
			if(null != supplier1.getType() && supplier1.getType().trim().length()>0){
				dc.add(Restrictions.eq("type", supplier1.getType()));
			}
		}
		if(null != supplier2) {
			//根据名称精确查询
			if(supplier2.getName()!=null && supplier2.getName().trim().length()>0) {
				dc.add(Restrictions.eq("name", supplier2.getName()));
			}
		}
		return dc;
	}

}
