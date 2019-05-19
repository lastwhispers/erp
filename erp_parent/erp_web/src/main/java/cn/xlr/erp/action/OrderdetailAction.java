package cn.xlr.erp.action;
import org.apache.shiro.authz.UnauthenticatedException;

import cn.xlr.erp.biz.IOrderdetailBiz;
import cn.xlr.erp.entity.Emp;
import cn.xlr.erp.entity.Orderdetail;
import cn.xlr.erp.exception.ErpException;

/**
 * 订单明细Action 
 * @author Administrator
 *
 */
public class OrderdetailAction extends BaseAction<Orderdetail> {

	private IOrderdetailBiz orderdetailBiz;

	public void setOrderdetailBiz(IOrderdetailBiz orderdetailBiz) {
		this.orderdetailBiz = orderdetailBiz;
		super.setBaseBiz(this.orderdetailBiz);
	}
	
	private Long storeuuid;
	
	public Long getStoreuuid() {
		return storeuuid;
	}

	public void setStoreuuid(Long storeuuid) {
		this.storeuuid = storeuuid;
	}

	/**
	 * 入库
	 */
	public void doInStore(){
		Emp loginUser = getLoginUser();
		if(null == loginUser){
			//用户没有登陆，session已失效
			ajaxReturn(false, "亲！您还没有登陆");
			return;
		}
		try {
			//调用明细入库业务
			orderdetailBiz.doInStore(getId(), storeuuid, loginUser.getUuid());
			ajaxReturn(true, "入库成功");
		} catch (ErpException e){
			ajaxReturn(false, e.getMessage());
		} catch (UnauthenticatedException e) {
			ajaxReturn(false, "权限不足");
		} catch (Exception e) {
			ajaxReturn(false, "入库失败");
			e.printStackTrace();
		}
	}
	
	/**
	 * 入库
	 */
	public void doOutStore(){
		Emp loginUser = getLoginUser();
		if(null == loginUser){
			//用户没有登陆，session已失效
			ajaxReturn(false, "亲！您还没有登陆");
			return;
		}
		try {
			//调用明细出库业务
			orderdetailBiz.doOutStore(getId(), storeuuid, loginUser.getUuid());
			ajaxReturn(true, "出库成功");
		} catch (ErpException e){
			ajaxReturn(false, e.getMessage());
		} catch (UnauthenticatedException e) {
			ajaxReturn(false, "权限不足");
		} catch (Exception e) {
			ajaxReturn(false, "出库失败");
			e.printStackTrace();
		}
	}

}
