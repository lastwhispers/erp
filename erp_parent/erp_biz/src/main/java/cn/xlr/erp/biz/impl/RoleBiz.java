package cn.xlr.erp.biz.impl;
import java.util.ArrayList;
import java.util.List;

import cn.xlr.erp.biz.IRoleBiz;
import cn.xlr.erp.dao.IMenuDao;
import cn.xlr.erp.dao.IRoleDao;
import cn.xlr.erp.entity.Emp;
import cn.xlr.erp.entity.Menu;
import cn.xlr.erp.entity.Role;
import cn.xlr.erp.entity.Tree;
import redis.clients.jedis.Jedis;
/**
 * 角色业务逻辑类
 * @author Administrator
 *
 */
public class RoleBiz extends BaseBiz<Role> implements IRoleBiz {

	private IRoleDao roleDao;
	private IMenuDao menuDao;
	private Jedis jedis;
	
	public void setRoleDao(IRoleDao roleDao) {
		this.roleDao = roleDao;
		super.setBaseDao(this.roleDao);
	}
	
	public void setMenuDao(IMenuDao menuDao) {
		this.menuDao = menuDao;
	}

	public void setJedis(Jedis jedis) {
		this.jedis = jedis;
	}

	/**
	 * 获取角色菜单权限
	 * @param uuid 角色编号
	 */
	public List<Tree> readRoleMenus(Long uuid){
		List<Tree> treeList = new ArrayList<Tree>();
		//获取角色信息
		Role role = roleDao.get(uuid);
		//获取角色菜单
		List<Menu> roleMenus = role.getMenus();
		//根菜单
		Menu root = menuDao.get("0");
		Tree t1 = null;
		Tree t2 = null;
		//一级菜单
		for(Menu m : root.getMenus()){
			t1 = new Tree();
			t1.setId(m.getMenuid());
			t1.setText(m.getMenuname());
			//二级菜单
			for(Menu m2 : m.getMenus()){
				t2 = new Tree();
				t2.setId(m2.getMenuid());
				t2.setText(m2.getMenuname());
				//如果角色下包含有这个权限菜单，让它勾选上
				if(roleMenus.contains(m2)){
					t2.setChecked(true);
				}
				t1.getChildren().add(t2);
			}
			treeList.add(t1);
		}
		return treeList;
	}
	/**
	 * 更新角色权限设置
	 * @param uuid 角色id
	 * @param checkedIds 勾选的菜单id，逗号分隔
	 */
	@Override
	public void updateRoleMenus(Long uuid, String checkedIds) {
		Role role = roleDao.get(uuid);
		//清空角色下的权限菜单
		role.setMenus(new ArrayList<Menu>());
		//勾选菜单数组
		String[] ids = checkedIds.split(",");
		Menu menu = null;
		for (String id : ids) {
			menu = menuDao.get(id);
			role.getMenus().add(menu);//向中间表添加角色id对应的权限菜单id
		}
		try {
			//更新角色权限菜单后，清空该角色下的用户缓存
			System.out.println("清空该角色下的用户缓存");
			for (Emp emp : role.getEmps()) {
				jedis.del("menuList_"+emp.getUuid());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
