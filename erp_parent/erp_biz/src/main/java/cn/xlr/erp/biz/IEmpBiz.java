package cn.xlr.erp.biz;

import java.util.List;

import cn.xlr.erp.entity.Emp;
import cn.xlr.erp.entity.Tree;
/**
 * 员工业务逻辑层接口
 * @author Administrator
 *
 */
public interface IEmpBiz extends IBaseBiz<Emp>{

	/**
	 * 用户登陆
	 * @param username
	 * @param pwd
	 * @return
	 */
	Emp findByUsernameAndPwd(String username, String pwd);
	
	/**
	 * 修改密码
	 */
	void updatePwd(Long uuid, String oldPwd, String newPwd);
	
	/**
	 * 重置密码
	 */
	void updatePwd_reset(Long uuid, String newPwd);
	/**
	 * 读取用户角色
	 * @param uuid
	 * @return
	 */
	List<Tree> readEmpRoles(Long uuid);
	/**
	 * 更新用户角色
	 * @param uuid 用户id
	 * @param checkedIds 角色ids
	 */
	void updateEmpRoles(Long uuid,String checkedIds);
	

}

