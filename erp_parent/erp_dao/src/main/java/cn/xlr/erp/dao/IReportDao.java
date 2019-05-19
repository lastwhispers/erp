package cn.xlr.erp.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 报表数据接口
 * @author Administrator
 *
 */
public interface IReportDao {
	/**
	 * 销售报表
	 * @param startDate
	 * @param endDates
	 * @return
	 */
	public List<Map<String, Object>> ordersReport(Date startDate,Date endDates);
	/**
	 * 某年12月销售额
	 * @param year
	 * @return
	 */
	public List<Map<String, Object>> getSumMoney(int year);
}
