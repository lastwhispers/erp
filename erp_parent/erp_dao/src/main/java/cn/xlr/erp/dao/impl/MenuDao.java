package cn.xlr.erp.dao.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;

import cn.xlr.erp.dao.IMenuDao;
import cn.xlr.erp.entity.Menu;
/**
 * 菜单数据访问类
 * @author Administrator
 *
 */
public class MenuDao extends BaseDao<Menu> implements IMenuDao {

	/**
	 * 构建查询条件
	 * @param dep1
	 * @param dep2
	 * @param param
	 * @return
	 */
	public DetachedCriteria getDetachedCriteria(Menu menu1,Menu menu2,Object param){
		DetachedCriteria dc=DetachedCriteria.forClass(Menu.class);
		//原先这里什么都不加，菜单页的查询框传了条件也被丢弃
		if(menu1!=null){
			if(null != menu1.getMenuname() && menu1.getMenuname().trim().length()>0){
				dc.add(Restrictions.like("menuname", menu1.getMenuname(), MatchMode.ANYWHERE));
			}
			if(null != menu1.getIcon() && menu1.getIcon().trim().length()>0){
				dc.add(Restrictions.like("icon", menu1.getIcon(), MatchMode.ANYWHERE));
			}
			if(null != menu1.getUrl() && menu1.getUrl().trim().length()>0){
				dc.add(Restrictions.like("url", menu1.getUrl(), MatchMode.ANYWHERE));
			}
			if(null != menu1.getPid() && menu1.getPid().trim().length()>0){
				dc.add(Restrictions.eq("pid", menu1.getPid()));
			}
		}
		return dc;
	}
	/**
	 * 根据员工编号获取菜单
	 * @param uuid
	 * @return
	 */
	@Override
	public List<Menu> getMenusByEmpuuid(Long uuid) {
		String hql = "select m from Emp e join e.roles r join r.menus m where e.uuid=?";
		return (List<Menu>) this.getHibernateTemplate().find(hql, uuid);
	}

	/**
	 * 按菜单名称查其 ID。只回标量，不能回实体——校验时若把同 ID 的实体装进 session，
	 * 随后 update() 会抛 NonUniqueObjectException
	 */
	@Override
	public String idByMenuname(String menuname) {
		List<String> list = (List<String>) this.getHibernateTemplate().find(
				"select m.menuid from Menu m where m.menuname=?", menuname);
		return list.isEmpty() ? null : list.get(0);
	}

	/**
	 * 主键是否存在，同样只回标量
	 */
	@Override
	public boolean idExists(String menuid) {
		List<Long> list = (List<Long>) this.getHibernateTemplate().find(
				"select count(m.menuid) from Menu m where m.menuid=?", menuid);
		return !list.isEmpty() && list.get(0).longValue() > 0;
	}

}
