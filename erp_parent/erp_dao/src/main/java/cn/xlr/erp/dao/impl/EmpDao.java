package cn.xlr.erp.dao.impl;
import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;

import cn.xlr.erp.dao.IEmpDao;
import cn.xlr.erp.entity.Emp;
/**
 * 员工数据访问类
 * @author Administrator
 *
 */
public class EmpDao extends BaseDao<Emp> implements IEmpDao {
	
	
	
	/**
	 * 用户登陆
	 * @param username
	 * @param pwd
	 * @return
	 */
	public Emp findByUsernameAndPwd(String username, String pwd){
		String hql = "from Emp where username=? and pwd=?";		
		List<Emp> list = (List<Emp>) this.getHibernateTemplate().find(hql, username, pwd);
		//能够匹配上，则返回第一个元素
		if(list.size() > 0){
			return list.get(0);
		}
		//如果登陆名或密码不正确
		return null;
	}

	/**
	 * 构建查询条件
	 * @param dep1
	 * @param dep2
	 * @param param
	 * @return
	 */
	public DetachedCriteria getDetachedCriteria(Emp emp1,Emp emp2,Object param){
		DetachedCriteria dc=DetachedCriteria.forClass(Emp.class);
		if(emp1!=null){
			if(null != emp1.getUsername() && emp1.getUsername().trim().length()>0){
				dc.add(Restrictions.like("username", emp1.getUsername(), MatchMode.ANYWHERE));
			}
			if(null != emp1.getPwd() && emp1.getPwd().trim().length()>0){
				dc.add(Restrictions.like("pwd", emp1.getPwd(), MatchMode.ANYWHERE));
			}
			if(null != emp1.getName() && emp1.getName().trim().length()>0){
				dc.add(Restrictions.like("name", emp1.getName(), MatchMode.ANYWHERE));
			}
			if(null != emp1.getEmail() && emp1.getEmail().trim().length()>0){
				dc.add(Restrictions.like("email", emp1.getEmail(), MatchMode.ANYWHERE));
			}
			if(null != emp1.getTele() && emp1.getTele().trim().length()>0){
				dc.add(Restrictions.like("tele", emp1.getTele(), MatchMode.ANYWHERE));
			}
			if(null != emp1.getAddress() && emp1.getAddress().trim().length()>0){
				dc.add(Restrictions.like("address", emp1.getAddress(), MatchMode.ANYWHERE));
			}
			//根据部门查询
			if(null != emp1.getDep() && null != emp1.getDep().getUuid()){
				dc.add(Restrictions.eq("dep", emp1.getDep()));
			}
			//出生年月日查询 起始日期
			if(null != emp1.getBirthday()){
				dc.add(Restrictions.ge("birthday", emp1.getBirthday()));
			}

		}
		if(null != emp2){
			//出生年月日查询 结束日期
			if(null != emp2.getBirthday()){
				dc.add(Restrictions.le("birthday", emp2.getBirthday()));
			}
		}
		
		return dc;
	}
	
	
	/**
	 * 修改密码
	 */
	public void updatePwd(Long uuid, String newPwd) {
		String hql = "update Emp set pwd=? where uuid=?";
		this.getHibernateTemplate().bulkUpdate(hql, newPwd, uuid);
	}
	
	
}
