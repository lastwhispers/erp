package cn.xlr.erp.action;

import com.alibaba.fastjson.JSON;

import cn.xlr.erp.biz.IMenuBiz;
import cn.xlr.erp.entity.Emp;
import cn.xlr.erp.entity.Menu;

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
	
}
