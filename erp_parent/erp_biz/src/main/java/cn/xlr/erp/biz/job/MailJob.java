package cn.xlr.erp.biz.job;

import java.util.List;

import javax.mail.MessagingException;

import cn.xlr.erp.biz.IStoredetailBiz;
import cn.xlr.erp.entity.Storealert;

public class MailJob {
	
	private IStoredetailBiz storedetailBiz;

	public void setStoredetailBiz(IStoredetailBiz storedetailBiz) {
		this.storedetailBiz = storedetailBiz;
	}
	/**
	 * 检查库存是否充足
	 */
	public void checkStore() {
		List<Storealert> storealertList = storedetailBiz.getStorealertList();
		int count = storealertList.size();
		//库存不足
		if(count>0) {
			try {
				storedetailBiz.sendMail(count);
			} catch (MessagingException e) {
				e.printStackTrace();
			}
		}
	}
	
}

