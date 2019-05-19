package cn.xlr.erp.biz.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;

import cn.xlr.erp.biz.IStoredetailBiz;
import cn.xlr.erp.dao.IGoodsDao;
import cn.xlr.erp.dao.IStoreDao;
import cn.xlr.erp.dao.IStoredetailDao;
import cn.xlr.erp.entity.Storealert;
import cn.xlr.erp.entity.Storedetail;
import cn.xlr.erp.exception.ErpException;
import cn.xlr.erp.util.MailUtil;

/**
 * 仓库库存业务逻辑类
 * 
 * @author Administrator
 *
 */
public class StoredetailBiz extends BaseBiz<Storedetail> implements IStoredetailBiz {

	private IStoredetailDao storedetailDao;
	private IGoodsDao goodsDao;
	private IStoreDao storeDao;

	private MailUtil mailUtil;
	/** 邮件接收地址 */
	private String to;
	/** 邮件主题 */
	private String subject;
	/** 邮件正文 */
	private String text;

	public void setGoodsDao(IGoodsDao goodsDao) {
		this.goodsDao = goodsDao;
	}

	public void setStoreDao(IStoreDao storeDao) {
		this.storeDao = storeDao;
	}

	public void setStoredetailDao(IStoredetailDao storedetailDao) {
		this.storedetailDao = storedetailDao;
		super.setBaseDao(this.storedetailDao);
	}

	public void setMailUtil(MailUtil mailUtil) {
		this.mailUtil = mailUtil;
	}

	public void setTo(String to) {
		this.to = to;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public void setText(String text) {
		this.text = text;
	}

	/**
	 * 分页查询
	 */
	public List<Storedetail> getListByPage(Storedetail t1, Storedetail t2, Object param, int firstResult,
			int maxResults) {
		List<Storedetail> list = super.getListByPage(t1, t2, param, firstResult, maxResults);
		Map<Long, String> goodsNameMap = new HashMap<Long, String>();
		Map<Long, String> storeNameMap = new HashMap<Long, String>();
		for (Storedetail sd : list) {
			sd.setGoodsName(getGoodsName(sd.getGoodsuuid(), goodsNameMap));
			sd.setStoreName(getStoreName(sd.getStoreuuid(), storeNameMap));
		}
		return list;
	}

	private String getGoodsName(Long uuid, Map<Long, String> goodsNameMap) {
		if (null == uuid) {
			return null;
		}
		String goodsName = goodsNameMap.get(uuid);
		if (null == goodsName) {
			goodsName = goodsDao.get(uuid).getName();
			goodsNameMap.put(uuid, goodsName);
		}
		return goodsName;
	}

	private String getStoreName(Long uuid, Map<Long, String> storeNameMap) {
		if (null == uuid) {
			return null;
		}
		String storeName = storeNameMap.get(uuid);
		if (null == storeName) {
			storeName = storeDao.get(uuid).getName();
			storeNameMap.put(uuid, storeName);
		}
		return storeName;
	}

	/**
	 * 获取库存与代发货发货列表
	 */
	@Override
	public List<Storealert> getStorealertList() {
		return storedetailDao.getStorealertList();
	}

	/**
	 * 发送库存预警邮件
	 * 
	 * @throws MessagingException
	 */
	@Override
	public void sendStorealertMail() throws MessagingException {
		// 1. 查看是否有存在需要预警的商品
		List<Storealert> storealertList = storedetailDao.getStorealertList();
		int cnt = storealertList == null ? 0 : storealertList.size();
		if (cnt > 0) {
			sendMail(cnt);
		} else {
			throw new ErpException("没有需要预警的商品");
		}
	}
	/**
	 * 发送预警邮件
	 * @param cnt
	 * @throws MessagingException
	 */
	public void sendMail(int cnt) throws MessagingException {
		// 1. 查看是否有存在需要预警的商品
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		mailUtil.sendMail(to, subject.replace("[time]", sdf.format(new Date())),
				text.replace("[count]", String.valueOf(cnt)));
	}

}
