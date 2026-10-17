package cn.xlr.erp.action;

import org.apache.struts2.ServletActionContext;

import com.alibaba.fastjson.JSON;

import cn.xlr.erp.biz.IMenuBiz;
import cn.xlr.erp.entity.Emp;
import cn.xlr.erp.entity.Menu;
import cn.xlr.erp.exception.ErpException;

/**
 * 菜单Action 
 * @author Administrator
 *
 */
public class MenuAction extends BaseAction<Menu> {

	private IMenuBiz menuBiz;

	public void setMenuBiz(IMenuBiz menuBiz) {
		this.menuBiz = menuBiz;
		super.setBaseBiz(this.menuBiz);
	}
	
	/**
	 * 获取菜单数据
	 */
	public void getMenuTree(){
		//通过获取主菜单，自关联就会带其下所有的菜单
//		Menu menu = menuBiz.get("0");
//		write(JSON.toJSONString(menu));
		Emp loginUser = getLoginUser();
		Menu menu = menuBiz.getMenusByEmpuuid(loginUser.getUuid());
		write(JSON.toJSONString(menu));
	}

	/**
	 * 基类按 long 取主键，而 menu.menuid 是字符串，会抛 TypeMismatchException，这里按字符串走
	 */
	@Override
	public void get(){
		Menu menu = menuBiz.get(requestId());
		write(mapData(JSON.toJSONStringWithDateFormat(menu, "yyyy-MM-dd"), "t"));
	}

	@Override
	public void delete(){
		try {
			menuBiz.delete(requestId());
			ajaxReturn(true, "删除成功");
		} catch (ErpException e) {
			ajaxReturn(false, e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			ajaxReturn(false, "删除失败");
		}
	}

	private String requestId() {
		return ServletActionContext.getRequest().getParameter("id");
	}

}
