package cn.xlr.erp.action;
import cn.xlr.erp.biz.IStoreoperBiz;
import cn.xlr.erp.entity.Storeoper;

/**
 * 仓库操作记录Action 
 * @author Administrator
 *
 */
public class StoreoperAction extends BaseAction<Storeoper> {

	private IStoreoperBiz storeoperBiz;

	public void setStoreoperBiz(IStoreoperBiz storeoperBiz) {
		this.storeoperBiz = storeoperBiz;
		super.setBaseBiz(this.storeoperBiz);
	}

}
