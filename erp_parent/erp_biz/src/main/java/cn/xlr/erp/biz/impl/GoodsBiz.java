package cn.xlr.erp.biz.impl;
import cn.xlr.erp.biz.IGoodsBiz;
import cn.xlr.erp.dao.IGoodsDao;
import cn.xlr.erp.entity.Goods;
/**
 * 商品业务逻辑类
 * @author Administrator
 *
 */
public class GoodsBiz extends BaseBiz<Goods> implements IGoodsBiz {

	private IGoodsDao goodsDao;
	
	public void setGoodsDao(IGoodsDao goodsDao) {
		this.goodsDao = goodsDao;
		super.setBaseDao(this.goodsDao);
	}
	
}
