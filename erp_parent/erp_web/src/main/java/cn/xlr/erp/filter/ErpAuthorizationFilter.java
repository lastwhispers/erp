package cn.xlr.erp.filter;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authz.AuthorizationFilter;
/**
 * 自定义授权过滤器
 * @author Administrator
 *
 */
public class ErpAuthorizationFilter extends AuthorizationFilter {

	@Override
	protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue)
			throws Exception {
		// 获取主题
		Subject subject = getSubject(request, response);
		// 得到配置文件的权限列表(菜单列表名)
		String[] perms = (String[])mappedValue;
		//如果为空或长度为0，则放行
		if(perms == null || perms.length ==0) {
			return true;
		}
		//权限检查
		for (String perm : perms) {
			if(subject.isPermitted(perm)) {
				return true;
			}
		}
		return false;
	}

}

