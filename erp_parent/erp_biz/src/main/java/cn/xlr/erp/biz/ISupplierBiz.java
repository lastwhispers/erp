package cn.xlr.erp.biz;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import cn.xlr.erp.entity.Supplier;

/**
 * 供应商业务逻辑层接口
 * 
 * @author Administrator
 *
 */
public interface ISupplierBiz extends IBaseBiz<Supplier> {
	/**
	 * 导出excel文件
	 * @param os
	 * @param t1
	 */
	public void export(OutputStream os, Supplier t1);
	/**
	 *  数据导入
	 * @param is
	 * @throws IOException
	 */
	public void doImport(InputStream is) throws IOException;
}
