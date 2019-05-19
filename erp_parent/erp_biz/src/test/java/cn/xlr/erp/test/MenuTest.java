package cn.xlr.erp.test;


import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.alibaba.fastjson.JSON;

import cn.xlr.erp.dao.IMenuDao;
import cn.xlr.erp.entity.Menu;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath*:applicationContext*.xml"})
public class MenuTest {
	@Autowired
	private IMenuDao menuDao;
	

	@Test
	public void testLogic(){
		Menu menu = menuDao.get("0");
		System.out.println(JSON.toJSONString(menu));
	}

}
