package cn.xlr.erp.action;
import java.util.List;

import com.alibaba.fastjson.JSON;

import cn.xlr.erp.biz.IEmpBiz;
import cn.xlr.erp.entity.Emp;
import cn.xlr.erp.entity.Tree;

/**
 * 员工Action 
 * @author Administrator
 *
 */
public class EmpAction extends BaseAction<Emp> {

	private IEmpBiz empBiz;

	public void setEmpBiz(IEmpBiz empBiz) {
		this.empBiz = empBiz;
		super.setBaseBiz(this.empBiz);
	}
	
	private String oldPwd;//旧密码
	private String newPwd;//新密码

	public String getOldPwd() {
		return oldPwd;
	}

	public void setOldPwd(String oldPwd) {
		this.oldPwd = oldPwd;
	}

	public String getNewPwd() {
		return newPwd;
	}

	public void setNewPwd(String newPwd) {
		this.newPwd = newPwd;
	}

	/**
	 * 修改密码调用的方法
	 */
	public void updatePwd(){
		Emp loginUser = getLoginUser();
		//session是否会超时，用户是否登陆过了
		if(null == loginUser){
			ajaxReturn(false, "亲，您还没有登陆");
			return;
		}
		try {
			empBiz.updatePwd(loginUser.getUuid(), oldPwd, newPwd);
			ajaxReturn(true, "修改密码成功");
		} catch (Exception e) {
			e.printStackTrace();
			ajaxReturn(false, "修改密码失败");
		}
	}
	
	/**
	 * 重置密码调用的方法
	 */
	public void updatePwd_reset(){
		
		try {
			empBiz.updatePwd_reset(getId(), newPwd);
			ajaxReturn(true, "重置密码成功");
		} catch (Exception e) {
			e.printStackTrace();
			ajaxReturn(false, "重置密码失败");
		}
	}
	/**
	 * 读取用户角色
	 * @param uuid
	 * @return
	 */
	public void readEmpRoles() {
		List<Tree> list = empBiz.readEmpRoles(getId());
		write(JSON.toJSONString(list));
	}
	
	private String checkedIds;
	public void setCheckedIds(String checkedIds) {
		this.checkedIds = checkedIds;
	}

	/**
	 * 更新用户角色
	 * @param uuid 用户id
	 * @param checkedIds 角色ids
	 */
	public void updateEmpRoles() {
		try {
			empBiz.updateEmpRoles(getId(), checkedIds);
			ajaxReturn(true, "用户角色设置成功！");
		} catch (Exception e) {
			ajaxReturn(false, "用户角色失败");
			e.printStackTrace();
		}
	}
	
}
