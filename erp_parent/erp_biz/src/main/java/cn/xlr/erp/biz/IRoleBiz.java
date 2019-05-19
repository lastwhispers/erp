package cn.xlr.erp.biz;
import java.util.List;

import cn.xlr.erp.entity.Role;
import cn.xlr.erp.entity.Tree;
/**
 * 角色业务逻辑层接口
 * @author Administrator
 *
 */
public interface IRoleBiz extends IBaseBiz<Role>{
	/**
	 * 读取角色菜单
	 * @return
	 */
	List<Tree> readRoleMenus(Long uuid);
	/**
	 * 更新角色权限设置
	 * @param uuid 角色id
	 * @param checkedIds 勾选的菜单id，逗号分隔
	 */
	void updateRoleMenus(Long uuid,String checkedIds);
}

