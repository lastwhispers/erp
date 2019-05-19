package cn.xlr.erp.biz.impl;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.CellType;

import cn.xlr.erp.biz.ISupplierBiz;
import cn.xlr.erp.dao.ISupplierDao;
import cn.xlr.erp.entity.Supplier;
import cn.xlr.erp.exception.ErpException;

/**
 * 供应商业务逻辑类
 * 
 * @author Administrator
 *
 */
public class SupplierBiz extends BaseBiz<Supplier> implements ISupplierBiz {

	private ISupplierDao supplierDao;

	public void setSupplierDao(ISupplierDao supplierDao) {
		this.supplierDao = supplierDao;
		super.setBaseDao(this.supplierDao);
	}

	/**
	 * 导出excel文件
	 */
	@Override
	public void export(OutputStream os, Supplier t1) {
		// 获取所有供应商信息
		List<Supplier> supplierList = supplierDao.getList(t1, null, null);
		// 1.创建excel工作薄
		HSSFWorkbook wk = new HSSFWorkbook();
		// 2.创建一个工作表
		HSSFSheet sheet = null;
		if ("1".equals(t1.getType())) {
			sheet = wk.createSheet("供应商");
		}
		if ("2".equals(t1.getType())) {
			sheet = wk.createSheet("客户");
		}
		// 3.写入表头
		HSSFRow row = sheet.createRow(0);
		// 表头
		String[] headerName = { "名称", "地址", "联系人", "电话", "Email" };
		// 列宽
		int[] columnWidths = { 4000, 8000, 2000, 3000, 8000 };
		HSSFCell cell = null;
		for (int i = 0; i < headerName.length; i++) {
			// 创建表头单元格
			cell = row.createCell(i);
			// 向表头单元格写值
			cell.setCellValue(headerName[i]);
			sheet.setColumnWidth(i, columnWidths[i]);
		}
		// 4.向内容单元格写值
		int i = 1;
		for (Supplier supplier : supplierList) {
			row = sheet.createRow(i);
			row.createCell(0).setCellValue(supplier.getName());// 名称
			row.createCell(1).setCellValue(supplier.getAddress());// 地址
			row.createCell(2).setCellValue(supplier.getContact());// 联系人
			row.createCell(3).setCellValue(supplier.getTele());// 联系电话
			row.createCell(4).setCellValue(supplier.getEmail());// 邮件地址
			i++;
		}
		try {
			// 写入到输出流中
			wk.write(os);
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				// 关闭工作簿
				wk.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

	}
	/**
	 * 数据导入
	 */
	@Override
	public void doImport(InputStream is) throws IOException {
		HSSFWorkbook wb = null;
		try {
			wb = new HSSFWorkbook(is);
			HSSFSheet sheet = wb.getSheetAt(0);
			String type = "";
			if ("供应商".equals(sheet.getSheetName())) {
				type = Supplier.TYPE_SUPPLIER;
			} else if ("客户".equals(sheet.getSheetName())) {
				type = Supplier.TYPE_CUSTOMER;
			} else {
				throw new ErpException("工作表名称不正确");
			}
			// 读取数据
			// 最后一行的行号
			int lastRow = sheet.getLastRowNum();
			Supplier supplier = null;
			for (int i = 1; i <= lastRow; i++) {
				supplier = new Supplier();
				supplier.setName(sheet.getRow(i).getCell(0).getStringCellValue());// 供应商名称
				// 判断是否已经存在，通过名称来判断
				List<Supplier> list = supplierDao.getList(null, supplier, null);
				if (list.size() > 0) {
					// 说明存在该供应商或者客户，需要更新
					supplier = list.get(0);
				}
				HSSFCell cell =null;
				
				cell = sheet.getRow(i).getCell(1);
				cell.setCellType(CellType.STRING);
				supplier.setAddress(cell.getStringCellValue());// 地址
				
				cell = sheet.getRow(i).getCell(2);
				cell.setCellType(CellType.STRING);
				supplier.setContact(sheet.getRow(i).getCell(2).getStringCellValue());// 联系人
				
				cell = sheet.getRow(i).getCell(3);
				cell.setCellType(CellType.STRING);
				supplier.setTele(sheet.getRow(i).getCell(3).getStringCellValue());// 电话
				
				cell = sheet.getRow(i).getCell(4);
				cell.setCellType(CellType.STRING);
				supplier.setEmail(sheet.getRow(i).getCell(4).getStringCellValue());// Email
				if (list.size() == 0) {
					// 说明不存在该供应商或者客户，需要新增
					supplier.setType(type);
					supplierDao.add(supplier);
				}
			}
		} finally {
			if (null != wb) {
				try {
					wb.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}

}
