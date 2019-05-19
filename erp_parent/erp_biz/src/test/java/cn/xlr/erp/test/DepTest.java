package cn.xlr.erp.test;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:applicationContext_test.xml" })
public class DepTest {

	@Test
	public void testLogic() throws FileNotFoundException, IOException {
		// 工作簿
		HSSFWorkbook book = new HSSFWorkbook();
		// 工作表
		HSSFSheet sheet = book.createSheet("采购订单");
		// 内容样式
		HSSFCellStyle style_content = book.createCellStyle();
		style_content.setBorderBottom(HSSFCellStyle.BORDER_THIN);// 下边框
		style_content.setBorderTop(HSSFCellStyle.BORDER_THIN);// 上边框
		style_content.setBorderLeft(HSSFCellStyle.BORDER_THIN);// 左边框
		style_content.setBorderRight(HSSFCellStyle.BORDER_THIN);// 右边框
		// 根据导出的订单样本创建10行4列
		for (int i = 2; i < 12; i++) {
			HSSFRow row = sheet.createRow(i);// 创建订单内容中的行
			for (int j = 0; j < 4; j++) {
				HSSFCell cell = row.createCell(j);// 创建订单内容中的单元格
				cell.setCellStyle(style_content);// 设置单元格的样式
			}
		}

		// 合并单元格
		sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 3));// 标题
		sheet.addMergedRegion(new CellRangeAddress(2, 2, 1, 3));// 供应商
		sheet.addMergedRegion(new CellRangeAddress(7, 7, 0, 3));// 订单明细

		// ****** 设置固定文本内容 ******//
		// 设置标题内容, 注意：单元格必须创建后才能设置。
		sheet.createRow(0).createCell(0).setCellValue("采购单");// 设置标题内容
		sheet.getRow(2).getCell(0).setCellValue("供应商");// 设置供应商文本
		// 已经创建过的row/cell，则通过sheet.getRow.getCell方式获取
		sheet.getRow(3).getCell(0).setCellValue("下单日期");
		sheet.getRow(3).getCell(2).setCellValue("经办人");
		sheet.getRow(4).getCell(0).setCellValue("审核日期");
		sheet.getRow(4).getCell(2).setCellValue("经办人");
		sheet.getRow(5).getCell(0).setCellValue("采购日期");
		sheet.getRow(5).getCell(2).setCellValue("经办人");
		sheet.getRow(6).getCell(0).setCellValue("入库日期");
		sheet.getRow(6).getCell(2).setCellValue("经办人");
		sheet.getRow(7).getCell(0).setCellValue("订单明细");
		sheet.getRow(8).getCell(0).setCellValue("商品名称");
		sheet.getRow(8).getCell(1).setCellValue("数量");
		sheet.getRow(8).getCell(2).setCellValue("价格");
		sheet.getRow(8).getCell(3).setCellValue("金额");

		// ****** 设置行高和列宽 ******//
		sheet.getRow(0).setHeight((short) 1000);// 设置标题行高
		// 设置内容部分的行高
		for (int i = 2; i < 12; i++) {
			sheet.getRow(i).setHeight((short) 500);
		}
		// 设置列宽
		for (int i = 0; i < 4; i++) {
			sheet.setColumnWidth(i, 5000);
		}

		// ****** 设置对齐方式和字体 ******//
		// 内容部分的对齐设置
		style_content.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 水平居中
		style_content.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 垂直居中
		// 设置内容部分的字体
		HSSFFont font_content = book.createFont();// 创建字体
		font_content.setFontName("宋体");// 设置字体名称
		font_content.setFontHeightInPoints((short) 11);// 设置字体大小
		style_content.setFont(font_content);// 设置样式的字体

		// 标题样式
		HSSFCellStyle style_title = book.createCellStyle();
		style_title.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 水平居中
		style_title.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 垂直居中
		HSSFFont font_title = book.createFont();// 创建字体
		font_title.setFontName("黑体");// 设置字体名称
		font_title.setBold(true);// 加粗
		font_title.setFontHeightInPoints((short) 18);// 设置字体大小
		style_title.setFont(font_title);// 设置样式的字体
		sheet.getRow(0).getCell(0).setCellStyle(style_title);// 设置标题样式

		// ****** 设置日期格式 ******//
		// 日期格式
		HSSFCellStyle style_date = book.createCellStyle();
		style_date.cloneStyleFrom(style_content);// 日期格式基本上跟内容的格式一样，可以clone过来
		HSSFDataFormat dataFormat = book.createDataFormat();
		style_date.setDataFormat(dataFormat.getFormat("yyyy-MM-dd hh:mm"));
		// 设置日期 的日期格式
		for (int i = 3; i < 7; i++) {
			sheet.getRow(i).getCell(1).setCellStyle(style_date);
		}

		// 保存工作簿到本地目录
		book.write(new FileOutputStream("d:\\采购订单.xls"));
		book.close();
	}

}
