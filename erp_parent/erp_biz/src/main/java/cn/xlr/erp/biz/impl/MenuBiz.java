package cn.xlr.erp.biz.impl;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSON;

import cn.xlr.erp.biz.IMenuBiz;
import cn.xlr.erp.dao.IMenuDao;
import cn.xlr.erp.entity.Menu;
import redis.clients.jedis.Jedis;
/**
 * 菜单业务逻辑类
 * @author Administrator
 *
 */
public class MenuBiz extends BaseBiz<Menu> implements IMenuBiz {

	private IMenuDao menuDao;
	private Jedis jedis;
	
	public void setMenuDao(IMenuDao menuDao) {
		this.menuDao = menuDao;
		super.setBaseDao(this.menuDao);
	}
	
	public void setJedis(Jedis jedis) {
		this.jedis = jedis;
	}


	/**
	 * 根据员工编号获取菜单（list格式）
	 */
	@Override
	public List<Menu> getMenuListByEmpuuid(Long uuid) {
		String menuListJson = jedis.get("menuList_"+uuid);
		List<Menu> menuList = null;
		if(menuListJson == null) {
			//从数据库中查出来，放入缓存中
			menuList = menuDao.getMenusByEmpuuid(uuid);
			jedis.set("menuList_"+uuid, JSON.toJSONString(menuList));
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
