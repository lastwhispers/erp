package cn.xlr.erp.biz;
import java.io.OutputStream;

import cn.xlr.erp.entity.Orders;
/**
 * 订单业务逻辑层接口
 * @author Administrator
 *
 */
public interface IOrdersBiz extends IBaseBiz<Orders>{

	/**
	 * 审核
	 * @param uuid 订单编号
	 * @param empUuid 审核员
	 */
	void doCheck(Long uuid, Long empUuid);
	
	/**
	 * 确认
	 * @param uuid 订单编号
	 * @param empUuid 采购员
	 */
	void doStart(Long uuid, Long empUuid);
	/**
	 * 生成订单execl
	 * @param os
	 * @param uuid
	 */
	public void export(OutputStream os, Long uuid);
}

