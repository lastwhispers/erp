package cn.xlr.erp.biz.impl;
import java.util.ArrayList;
import java.util.List;

import org.apache.shiro.crypto.hash.Md5Hash;

import cn.xlr.erp.biz.IEmpBiz;
import cn.xlr.erp.dao.IEmpDao;
import cn.xlr.erp.dao.IMenuDao;
import cn.xlr.erp.dao.IRoleDao;
import cn.xlr.erp.entity.Emp;
import cn.xlr.erp.entity.Role;
import cn.xlr.erp.entity.Tree;
import cn.xlr.erp.exception.ErpException;
import redis.clients.jedis.Jedis;
/**
 * 员工业务逻辑类
 * @author Administrator
 *
 */
public class EmpBiz extends BaseBiz<Emp> implements IEmpBiz {

	private int hashIterations = 2;
	
	private IEmpDao empDao;
	private IRoleDao roleDao;
	private Jedis jedis;
	
	public void setJedis(Jedis jedis) {
		this.jedis = jedis;
	}
	public void setEmpDao(IEmpDao empDao) {
		this.empDao = empDao;
		super.setBaseDao(this.empDao);
	}
	public void setRoleDao(IRoleDao roleDao) {
		this.roleDao = roleDao;
	}

	/**
	 * 用户登陆
	 * @param username
	 * @param pwd
	 * @return
	 */
	public Emp findByUsernameAndPwd(String username, String pwd){
		//查询前先加密
		pwd = encrypt(pwd, username);
		System.out.println(pwd);
		return empDao.findByUsernameAndPwd(username, pwd);
	}

	/**
	 * 修改密码
	 */
	public void updatePwd(Long uuid, String oldPwd, String newPwd) {
		//取出员工信息
		Emp emp = empDao.get(uuid);
		//加密旧密码
		String encrypted = encrypt(oldPwd, emp.getUsername());
		//旧密码是否正确的匹配
		if(!encrypted.equals(emp.getPwd())){
			//抛出 自定义异常
			throw new ErpException("旧密码不正确");
		}		
		empDao.updatePwd(uuid, encrypt(newPwd,emp.getUsername()));
	}
	
	/**
	 * 新增员工
	 */
	public void add(Emp emp){
		//String pwd = emp.getPwd();
		// source: 原密码
		// salt:   盐 =》扰乱码
		// hashIterations: 散列次数，加密次数
		//Md5Hash md5 = new Md5Hash(pwd, emp.getUsername(), hashIterations);
		//取出加密后的密码
		//设置初始密码
		String newPwd = encrypt(emp.getUsername(), emp.getUsername());
		//System.out.println(newPwd);
		//设置成加密后的密码
		emp.setPwd(newPwd);
		//保存到数据库中
		super.add(emp);
	}
	
	/**
	 * 重置密码
	 */
	public void updatePwd_reset(Long uuid, String newPwd){
		//取出员工信息
		Emp emp = empDao.get(uuid);
		empDao.updatePwd(uuid, encrypt(newPwd,emp.getUsername()));
	}
	
	
	/**
	 * 加密
	 * @param source
	 * @param salt
	 * @return
	 */
	private String encrypt(String source, String salt){
		Md5Hash md5 = new Md5Hash(source, salt, hashIterations);
		return md5.toString();
	}
	/**
	 * 读取用户角色
	 * @param uuid
	 * @return
	 */
	@Override
	public List<Tree> readEmpRoles(Long uuid) {
		//返回值
		List<Tree> treeList = new ArrayList<Tree>();
		//获取用户对应的角色
		Emp emp = empDao.get(uuid);
		List<Role> roles = emp.getRoles();
		//获取所有角色
		List<Role> roleList = roleDao.getList(null, null, null);
		Tree t1 = null;
		//封装返回值将用户对应的角色设置为true
		for (Role role : roleList) {
			t1 = new Tree();
			t1.setId(String.valueOf(role.getUuid()));
			t1.setText(role.getName());
			if(roles.contains(role)) {
				t1.setChecked(true);
			}
			treeList.add(t1);
		}
		return treeList;
	}
	/**
	 * 更新用户角色
	 * @param uuid 用户id
	 * @param checkedIds 角色ids
	 */
	@Override
	public void updateEmpRoles(Long uuid, String checkedIds) {
		Emp emp = empDao.get(uuid);
		//清空用户下的所有角色
		emp.setRoles(new ArrayList<Role>());
		//勾选菜单数组
		String[] ids = checkedIds.split(",");
		Role role = null;
		for (String id : ids) {
			role = roleDao.get(Long.valueOf(id));
			//设置用户的角色
			emp.getRoles().add(role);
		}
		try {
			//更新某用户的角色时，清空缓存
			jedis.del("menuList_"+uuid);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
