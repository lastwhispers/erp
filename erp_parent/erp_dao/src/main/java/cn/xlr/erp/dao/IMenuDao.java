package cn.xlr.erp.dao;


import java.util.List;

import cn.xlr.erp.entity.Menu;
/**
 * 菜单数据访问接口
 * @author Administrator
 *
 */
public interface IMenuDao extends IBaseDao<Menu>{
	/**
	 * 根据员工编号获取菜单
	 * @param uuid
	 * @return
	 */
	List<Menu> getMenusByEmpuuid(Long uuid);
}
