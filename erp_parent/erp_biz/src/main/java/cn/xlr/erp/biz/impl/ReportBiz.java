package cn.xlr.erp.biz.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.xlr.erp.biz.IReportBiz;
import cn.xlr.erp.dao.IReportDao;
/**
 * 报表业务逻辑实现
 * @author Administrator
 *
 */
public class ReportBiz implements IReportBiz {
	private IReportDao reportDao;
	
	/**
	 * 销售表报统计
	 */
	@Override
	public List<Map<String,Object>> ordersReport(Date startDate, Date endDate) {
		return reportDao.ordersReport(startDate, endDate);
	}
	/**
	 * 销售趋势
	 */
	@Override
	public List<Map<String, Object>> trendReport(int year) {
		//1.根据条件查询某年12月的销售额
		//		[
		//		  {
		//		    "name": 12,
		//		    "y": 10638.5
		//		  }
		//		]
		List<Map<String, Object>> sumMoney = reportDao.getSumMoney(year);
		//2.已有月份缓存区
		Map<String,Map<String, Object>>  map = new HashMap<String,Map<String, Object>>();
		for (Map<String, Object> sum : sumMoney) {
			map.put(sum.get("month")+"", sum);
		}
		//3.返回的List<Map<String, Object>>
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>(12);
		//4.暂存一个月的数据
		Map<String, Object> data = null;
		for (int i=1;i<=12;i++) {
			//5.从已有已有月份缓存区中取出。
			data = map.get(i+"");
			//6.如果等于null，封装当前月份与销售额
			if(data == null) {
				data = new HashMap<String, Object>();
				data.put("month", i+"月");
				data.put("y", 0);
			}
			//7.如果不等于null，修改月份
			if(data!=null) {
				data.put("month", i+"月");
			}
			result.add(data);
		}
		
		return result;
	}
	
	public void setReportDao(IReportDao reportDao) {
		this.reportDao = reportDao;
	}
}
