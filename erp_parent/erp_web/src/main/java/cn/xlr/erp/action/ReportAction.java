package cn.xlr.erp.action;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSON;

import cn.xlr.erp.biz.IReportBiz;
import cn.xlr.erp.util.ResponseJson;

/**
 * 统计报表控制器
 * @author Administrator
 *
 */
public class ReportAction {
	
	private Date startDate;
	
	private Date endDate;
	
	private int year;
	
	private IReportBiz reportBiz;
	/**
	 * 销售数据接口
	 */
	public void ordersReport() {
		List<Map<String,Object>> listOrdersReport = reportBiz.ordersReport(startDate, endDate);
		ResponseJson.write(JSON.toJSONString(listOrdersReport));
	}
	/**
	 * 销售趋势接口
	 */
	public void trendReport() {
		List<Map<String,Object>> list = reportBiz.trendReport(year);
		ResponseJson.write(JSON.toJSONString(list));
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	
	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}

	public IReportBiz getReportBiz() {
		return reportBiz;
	}

	public void setReportBiz(IReportBiz reportBiz) {
		this.reportBiz = reportBiz;
	}

}

