package cn.xlr.erp.action;
import java.util.List;

import com.alibaba.fastjson.JSON;

import cn.xlr.erp.biz.IRoleBiz;
import cn.xlr.erp.entity.Role;
import cn.xlr.erp.entity.Tree;

/**
 * 角色Action 
 * @author Administrator
 *
 */
public class RoleAction extends BaseAction<Role> {

	private IRoleBiz roleBiz;

	public void setRoleBiz(IRoleBiz roleBiz) {
		this.roleBiz = roleBiz;
		super.setBaseBiz(this.roleBiz);
	}
	/**
	 * 加载权限菜单
	 */
	public void readRoleMenus() {
		List<Tree> readRoleMenus = roleBiz.readRoleMenus(getId());
		write(JSON.toJSONString(readRoleMenus));
	}
	
	private String checkedIds;
	public void setCheckedIds(String checkedIds) {
		this.checkedIds = checkedIds;
	}
	
	/**
	 * 更新角色权限设置
	 * @param uuid 角色id
	 * @param checkedIds 勾选的菜单id，逗号分隔
	 */
	public void updateRoleMenus() {
		try {
			roleBiz.updateRoleMenus(getId(), checkedIds);
			ajaxReturn(true, "权限设置成功！");
		} catch (Exception e) {
			ajaxReturn(false, "权限设置失败,请检查网络！");
			e.printStackTrace();
		}
	}
}
