package cn.xlr.erp.dao.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.orm.hibernate5.support.HibernateDaoSupport;

import cn.xlr.erp.dao.IReportDao;
/**
 * 报表数据接口
 * @author Administrator
 *
 */
public class ReportDao extends HibernateDaoSupport implements IReportDao {
	
	/**
	 * 根据起始日期和截止日期,生成销售报表
	 */
	@Override
	public List<Map<String,Object>> ordersReport(Date startDate, Date endDate) {
		/**
		 * select gt.name,sum(od.money) from orders o,orderdetail od,goods gs,goodstype gt
			where o.uuid=od.ordersuuid  and od.goodsuuid=gs.uuid and gt.uuid=gs.goodstypeuuid
				and o.type='2' 
				group by gt.name;
		 */
		String hql = "select new Map(gt.name as name,sum(od.money) as y)"
				+ "from Orders o,Orderdetail od,Goods gs,Goodstype gt "  
				+ "where od.orders=o and od.goodsuuid=gs.uuid and gs.goodstype=gt " 
				+ "and o.type='2' ";
		List<Date> dateList = new ArrayList<Date>();
		if(startDate != null) {
			hql += "and o.createtime>=? ";
			dateList.add(startDate);
		}
		if(endDate != null) {
			hql += "and o.createtime<=? ";
			dateList.add(endDate);
		}
		hql += "group by gt.name";
		Date[] param = new Date[0];
		Date[] dates = dateList.toArray(param);
		return (List<Map<String, Object>>) this.getHibernateTemplate().find(hql,dates);
	}
	/**
	 * 统计某年的12个月销售额
	 * @param year
	 * @return
	 */
	public List<Map<String, Object>> getSumMoney(int year) {
		/**
		 * select o.createtime,sum(od.money) from orderdetail od,orders o
			where od.ordersuuid = o.uuid and o.type='2' and o.createtime='2017'
			group by o.createtime	
		 */
//		String hql = "select new Map(month(o.createtime) as month,sum(od.money) as y) from Orderdetail od,Orders o "
//				+ "where od.orders = o and o.type='2' and year(o.createtime)=? "
//				+ "group by (month(o.createtime)";
		String hql = "select new Map(month(o.createtime) as month,sum(ol.money) as y)"
				+ "from Orderdetail ol, Orders o "
				+ "where ol.orders=o "
				+ "and o.type='2' and year(o.createtime)=? "
				+ "group by month(o.createtime)";
		return (List<Map<String, Object>>) this.getHibernateTemplate().find(hql, year);
	}

}
