package cn.xlr.erp.biz.impl;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSON;

import cn.xlr.erp.biz.IMenuBiz;
import cn.xlr.erp.dao.IMenuDao;
import cn.xlr.erp.entity.Menu;
import cn.xlr.erp.exception.ErpException;
import cn.xlr.erp.util.LocalCache;
/**
 * 菜单业务逻辑类
 * @author Administrator
 *
 */
public class MenuBiz extends BaseBiz<Menu> implements IMenuBiz {

	private IMenuDao menuDao;
	private LocalCache menuCache;
	
	public void setMenuDao(IMenuDao menuDao) {
		this.menuDao = menuDao;
		super.setBaseDao(this.menuDao);
	}
	
	public void setMenuCache(LocalCache menuCache) {
		this.menuCache = menuCache;
	}

	/**
	 * 新增菜单。menuid 原方案依赖一个脚本里从未创建的 menu_seq，改为由操作者按编号规则填写
	 */
	@Override
	public void add(Menu menu) {
		validate(menu, true);
		super.add(menu);
	}

	/**
	 * 修改菜单
	 */
	@Override
	public void update(Menu menu) {
		validate(menu, false);
		super.update(menu);
		// menuname 同时是 Shiro 的权限串，改名后所有已缓存的菜单列表都会对不上
		menuCache.clear();
	}

	/**
	 * 删除菜单。没有外键约束，父节点被删掉后子节点会在菜单树里整枝消失，所以先拦住
	 */
	@Override
	public void delete(String uuid) {
		Menu menu = menuDao.get(uuid);
		if (menu == null) {
			throw new ErpException("菜单不存在：" + uuid);
		}
		if (!menu.getMenus().isEmpty()) {
			throw new ErpException("该菜单下还有子菜单，请先删除子菜单：" + menu.getMenuname());
		}
		menuDao.delete(uuid);
		menuCache.clear();
	}

	private void validate(Menu menu, boolean isNew) {
		String menuid = trimToNull(menu.getMenuid());
		if (menuid == null) {
			throw new ErpException("菜单ID不能为空，请按现有编号规则填写，如 100、101");
		}
		menu.setMenuid(menuid);
		boolean exists = menuDao.idExists(menuid);
		if (isNew && exists) {
			throw new ErpException("菜单ID已存在：" + menuid);
		}
		if (!isNew && !exists) {
			throw new ErpException("菜单ID不存在：" + menuid + "，菜单ID不能作为修改项变更");
		}
		if (trimToNull(menu.getMenuname()) == null) {
			throw new ErpException("菜单名称不能为空，它同时是权限标识");
		}
		String sameNameId = menuDao.idByMenuname(menu.getMenuname());
		if (sameNameId != null && !sameNameId.equals(menuid)) {
			throw new ErpException("菜单名称已存在：" + menu.getMenuname() + "，它是权限标识，不能重复");
		}
		String pid = trimToNull(menu.getPid());
		if (pid == null) {
			throw new ErpException("上级菜单ID不能为空，顶级菜单请填 0");
		}
		if (!menuDao.idExists(pid)) {
			throw new ErpException("上级菜单ID不存在：" + pid);
		}
		menu.setPid(pid);
	}

	private String trimToNull(String s) {
		return s == null || s.trim().length() == 0 ? null : s.trim();
	}


	/**
	 * 根据员工编号获取菜单（list格式）
	 */
	@Override
	public List<Menu> getMenuListByEmpuuid(Long uuid) {
		String menuListJson = menuCache.get("menuList_"+uuid);
		List<Menu> menuList = null;
		if(menuListJson == null) {
			//从数据库中查出来，放入缓存中
			menuList = menuDao.getMenusByEmpuuid(uuid);
			menuCache.set("menuList_"+uuid, JSON.toJSONString(menuList));
			System.out.println("从数据库中查询menuList");
		}else {
			//直接从缓存中拿
			menuList = JSON.parseArray(menuListJson,Menu.class);
			System.out.println("从缓存中查询menuList");
		}
		return menuList;
	}
	
	/**
	 * 根据员工编号获取菜单（封装成esayui需要的格式）
	 * @param uuid
	 * @return
	 */
	@Override
	public Menu getMenusByEmpuuid(Long uuid) {
		//获取所有的菜单
		Menu root = menuDao.get("0");
		//用户下的菜单集合
		List<Menu> empMenus = menuDao.getMenusByEmpuuid(uuid);
		//根菜单
		Menu menu = cloneMenu(root);
		//循环匹配
		//一级菜单
		Menu _m1 = null;
		Menu _m2 = null;
		for(Menu m1 : root.getMenus()){
			_m1 = cloneMenu(m1);
			//二级菜单循环
			for(Menu m2 : m1.getMenus()){
				//用户包含有这个菜单
				if(empMenus.contains(m2)){
					//复制菜单
					_m2 = cloneMenu(m2);
					//加入到上级菜单下
					_m1.getMenus().add(_m2);
				}
			}
			//有二级菜单我们才加进来
			if(_m1.getMenus().size() > 0){
				//把一级菜单加入到根菜单下
				menu.getMenus().add(_m1);
			}
		}
		return menu;
	}
	
	/**
	 * 复制menu
	 * @param src
	 * @return
	 */
	private Menu cloneMenu(Menu src){
		Menu menu = new Menu();
		menu.setIcon(src.getIcon());
		menu.setMenuid(src.getMenuid());
		menu.setMenuname(src.getMenuname());
		menu.setUrl(src.getUrl());
		menu.setMenus(new ArrayList<Menu>());
		return menu;
	}
	
}
