package cn.xlr.erp.biz;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 报表业务逻辑接口
 * @author Administrator
 *
 */
public interface IReportBiz {
	/**
	 * 销售报表统计
	 * @param startDate
	 * @param endDates
	 * @return
	 */
	public List<Map<String,Object>> ordersReport(Date startDate, Date endDate);
	/**
	 * 销售趋势
	 * @param year
	 * @return
	 */
	public List<Map<String, Object>> trendReport(int year);
}

