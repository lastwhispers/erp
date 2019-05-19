package cn.xlr.erp.test;

import javax.mail.MessagingException;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import cn.xlr.erp.util.MailUtil;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext_mail.xml"})
public class MailTest {
	@Autowired
	private MailUtil mailUtil;
	@Test
	public void mailtest(){
		try {
			mailUtil.sendMail("15037584397@163.com", 
//					"111", 
					"库存预警_时间:2018-10-5", 
//					"您好，有3种商品已经预警了，请登陆蓝云ERP3.1系统查看");
					"3");
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}

