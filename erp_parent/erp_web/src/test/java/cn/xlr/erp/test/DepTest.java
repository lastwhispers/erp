package cn.xlr.erp.test;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext_test.xml"})
public class DepTest {
	
	
	@Test
	public void testLogic(){
		SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd hh:ss:mm");
		try {
			Date d=sf.parse("2018-12-03 23:59:59");
			System.out.println(d);
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}
	

}
