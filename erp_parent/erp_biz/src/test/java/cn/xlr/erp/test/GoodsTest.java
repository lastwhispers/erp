package cn.xlr.erp.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import cn.xlr.erp.biz.impl.GoodsBiz;
import cn.xlr.erp.entity.Goods;
import cn.xlr.erp.entity.Goodstype;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath*:applicationContext_*.xml"})
public class GoodsTest {
	
	private GoodsBiz goodsBiz;
	
	public void setGoodsBiz(GoodsBiz goodsBiz) {
		this.goodsBiz = goodsBiz;
	}

	@Test
	public void testLogic(){
		Goods goods = new Goods();
		goods.setName("苹果");
		goods.setOrigin("河南平顶山");
		goods.setProducer("喜乐融");
		goods.setUnit("个");
		goods.setInprice(1.00);
		goods.setOutprice(2.00);
		Goodstype goodstype = new Goodstype();
		goodstype.setName("水果");
		goodstype.setUuid(7L);
		goods.setGoodstype(goodstype);
		goodsBiz.add(goods);
	}

}
