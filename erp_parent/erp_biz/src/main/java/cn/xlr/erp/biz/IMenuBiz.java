package cn.xlr.erp.biz;

import java.util.List;

import cn.xlr.erp.entity.Menu;
/**
 * 菜单业务逻辑层接口
 * @author Administrator
 *
 */
public interface IMenuBiz extends IBaseBiz<Menu>{
	/**
	 * 根据员工编号获取菜单
	 * @param uuid
	 * @return
	 */
	Menu getMenusByEmpuuid(Long uuid);
	/**
	 * 根据员工编号获取菜单
	 * @param uuid
	 * @return
	 */
	List<Menu> getMenuListByEmpuuid(Long uuid);
}

