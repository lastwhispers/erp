package cn.xlr.erp.util;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 进程内缓存，替代原来的 Redis(Jedis)。
 * 只用 get/set/del 三个方法，缓存员工菜单列表；单机部署下与 Redis 等价，
 * 区别是重启即失效，且没有 TTL——原实现同样没有。
 */
public class LocalCache {

	private final Map<String, String> store = new ConcurrentHashMap<String, String>();

	public String get(String key) {
		return store.get(key);
	}

	public String set(String key, String value) {
		store.put(key, value);
		return value;
	}

	public void del(String key) {
		store.remove(key);
	}
}
