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

	/**
	 * 按菜单名称查其 ID（用于校验权限标识唯一，只回标量）
	 */
	String idByMenuname(String menuname);

	/**
	 * 主键是否存在（只回标量，不水合实体）
	 */
	boolean idExists(String menuid);
}
