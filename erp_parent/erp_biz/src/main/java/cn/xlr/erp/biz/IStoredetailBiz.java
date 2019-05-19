package cn.xlr.erp.biz;

import java.util.List;

import javax.mail.MessagingException;

import cn.xlr.erp.entity.Storealert;
import cn.xlr.erp.entity.Storedetail;

/**
 * 仓库库存业务逻辑层接口
 * 
 * @author Administrator
 *
 */
public interface IStoredetailBiz extends IBaseBiz<Storedetail> {
	/**
	 * 获取库存列表
	 * 
	 * @return
	 */
	public List<Storealert> getStorealertList();

	/**
	 * 发送库存预警邮件
	 */
	public void sendStorealertMail() throws MessagingException;
	
	/**
	 * 发送预警邮件
	 * @param cnt
	 * @throws MessagingException
	 */
	public void sendMail(int cnt) throws MessagingException;
}
