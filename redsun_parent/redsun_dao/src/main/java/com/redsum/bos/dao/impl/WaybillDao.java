package com.redsum.bos.dao.impl;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import com.redsum.bos.dao.IWaybillDao;
import com.redsum.bos.entity.Waybill;
/**
 * 数据访问类
 * @author Administrator
 *
 */
public class WaybillDao extends BaseDao<Waybill> implements IWaybillDao {

	/**
	 * 构建查询条件
	 * @param dep1
	 * @param dep2
	 * @param param
	 * @return
	 */
	public DetachedCriteria getDetachedCriteria(Waybill waybill1,Waybill waybill2,Object param){
		DetachedCriteria dc=DetachedCriteria.forClass(Waybill.class);
		if(waybill1!=null){
			if(null != waybill1.getToaddress() && waybill1.getToaddress().trim().length()>0){
				dc.add(Restrictions.like("toaddress", waybill1.getToaddress(), MatchMode.ANYWHERE));
			}
			if(null != waybill1.getAddressee() && waybill1.getAddressee().trim().length()>0){
				dc.add(Restrictions.like("addressee", waybill1.getAddressee(), MatchMode.ANYWHERE));
			}
			if(null != waybill1.getTele() && waybill1.getTele().trim().length()>0){
				dc.add(Restrictions.like("tele", waybill1.getTele(), MatchMode.ANYWHERE));
			}
			if(null != waybill1.getInfo() && waybill1.getInfo().trim().length()>0){
				dc.add(Restrictions.like("info", waybill1.getInfo(), MatchMode.ANYWHERE));
			}
			if(null != waybill1.getState() && waybill1.getState().trim().length()>0){
				dc.add(Restrictions.like("state", waybill1.getState(), MatchMode.ANYWHERE));
			}

		}
		return dc;
	}

}
