package cn.xlr.erp.action;
import java.util.List;

import javax.mail.MessagingException;

import com.alibaba.fastjson.JSON;

import cn.xlr.erp.biz.IStoredetailBiz;
import cn.xlr.erp.entity.Storealert;
import cn.xlr.erp.entity.Storedetail;
import cn.xlr.erp.exception.ErpException;
import cn.xlr.erp.util.ResponseJson;

/**
 * 仓库库存Action 
 * @author Administrator
 *
 */
public class StoredetailAction extends BaseAction<Storedetail> {

	private IStoredetailBiz storedetailBiz;

	public void setStoredetailBiz(IStoredetailBiz storedetailBiz) {
		this.storedetailBiz = storedetailBiz;
		super.setBaseBiz(this.storedetailBiz);
	}
	/**
	 * 库存与订单代发货数量，获取库存预警列表
	 */
	public void getStorealertList() {
		List<Storealert> storealertList = storedetailBiz.getStorealertList();
		ResponseJson.write(JSON.toJSONString(storealertList));
	}
	
	public void sendStorealertMail() {
		try {
			storedetailBiz.sendStorealertMail();
			ajaxReturn(true, "库存预警邮件发送成功！");
		} catch (MessagingException e) {
			ajaxReturn(false, "构建预警邮件失败！");
			e.printStackTrace();
		} catch (ErpException e) {
			ajaxReturn(false, e.getMessage());
			e.printStackTrace();
		} catch (Exception e) {
			ajaxReturn(false, "邮件发送失败！");
			e.printStackTrace();
		}
	}

}
