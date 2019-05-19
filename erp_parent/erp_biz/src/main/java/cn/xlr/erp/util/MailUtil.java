package cn.xlr.erp.util;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

/**
 * 邮件工具类
 * @author Administrator
 *
 */
public class MailUtil {
	//spring 邮件发送类
	private JavaMailSender javaMailSender;
	//发件人
	private String from;
	/**
	 * 
	 * @param to 接收人，多人时可逗号分隔
	 * @param subject 邮件主题
	 * @param text 邮件正文（内容）
	 * @throws MessagingException 
	 */
	public void sendMail(String to, String subject, String text) throws MessagingException{
		//1. 创建邮件信息
		MimeMessage message = javaMailSender.createMimeMessage();
		//2. 使用spring邮件工具类
		MimeMessageHelper helper = new MimeMessageHelper(message);
		//3.收件人
		helper.setTo(to);
		//4.发件人
		helper.setFrom(from);
		//5.设置邮件的标题
		helper.setSubject(subject);
		//6.邮件的内容
		helper.setText(text);
		
		//7.发送邮件
		javaMailSender.send(message);
	}
	
	public void setJavaMailSender(JavaMailSender javaMailSender) {
		this.javaMailSender = javaMailSender;
	}

	public void setFrom(String from) {
		this.from = from;
	}
}
