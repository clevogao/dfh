/**
 * ExportExcelUtil.java
 * Created at 2015年9月18日
 * Created by gaojiawei
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.dfh.util;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import com.jfinal.plugin.activerecord.Record;
import com.dfh.controller.BaseController;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * ClassName: ExportExcelUtil
 * Description: 简单方式导出EXCEL支持分页
 * Author: gaojiawei
 * Date: 2015年9月18日
 */
public class ExportExcelUtil {
	private SXSSFWorkbook wb;
	private Sheet sheet;
	private Map<String, CellStyle> styles;
	private int rownum;
	private String[] titleName;
	private String[] titleKey;
	private String dateFormat = "yyyy-MM-dd";
	private Map<String, Map<Object, Object>> keyMapping = new HashMap<String, Map<Object, Object>>();
	DataFormat format;
	public Logger logger=LoggerFactory.getLogger(BaseController.class);
	
	
	public static void main(String[] args) throws FileNotFoundException, IOException {
		String[] a = new String[] { "第一个", "第二个","地上那个"};
		String[] b = new String[] { "a", "b","d"};
		ExportExcelUtil ee = new ExportExcelUtil(a, b);
		Map<Object, Object> parm = new HashMap<Object, Object>();
		parm.put("a", "ddddddddddd");
		parm.put("b", "bbbbbbbbbbbb");
		ArrayList<Map<Object, Object>> us = new ArrayList<Map<Object, Object>>();
		
		us.add(parm);
		ee.setDataListMap(us);
		ee.writeFile("target/export.xlsx");
		ee.dispose();
	}
	
	
	/**
	 * @param titleName 标题名称
	 * @param titlekey 取值名称
	 */
	public ExportExcelUtil(String[] titleName, String[] titlekey) {
		init();
		this.titleKey = titlekey;
		this.titleName = titleName;
		Row titleRow = sheet.createRow(rownum++);
		for (int i = 0; i < titleName.length; i++) {
			Cell cell = titleRow.createCell(i);
			cell.setCellStyle(styles.get("title"));
			cell.setCellValue(titleName[i]);
		}
	}
	/**
	 * @param titleName 标题名称
	 * @param titlekey 取值名称
	 * @param sheetname 表的名称
	 */
	public ExportExcelUtil(String[] titleName, String[] titlekey,String sheetname) {
		init(sheetname);
		this.titleKey = titlekey;
		this.titleName = titleName;
		Row titleRow = sheet.createRow(rownum++);
		for (int i = 0; i < titleName.length; i++) {
			Cell cell = titleRow.createCell(i);
			cell.setCellStyle(styles.get("title"));
			cell.setCellValue(titleName[i]);
		}
	}

	public Row addRow() {
		return sheet.createRow(rownum++);
	}

	public Cell addCell(Row row, int cloumn, Object val) {
		Cell cell = row.createCell(cloumn);
		CellStyle style = styles.get("data");
		try {
			if (val == null) {
				cell.setCellValue("");
			} else if (val instanceof String) {
				cell.setCellValue((String) val);
			} else if (val instanceof Integer) {
				cell.setCellValue((Integer) val);
			} else if (val instanceof Long) {
				cell.setCellValue((Long) val);
			} else if (val instanceof Double) {
				cell.setCellValue((Double) val);
			} else if (val instanceof Float) {
				cell.setCellValue((Float) val);
			} else if (val instanceof Date) {
				style.setDataFormat(format.getFormat("yyyy-MM-dd"));
				cell.setCellValue((Date) val);
			}
		} catch (Exception ex) {
			cell.setCellValue(val.toString());
		}
		cell.setCellStyle(style);
		return cell;
	}

	public void init() {
		this.wb = new SXSSFWorkbook(100);
		this.sheet = wb.createSheet("Export");
		this.styles = createStyles(wb);
		this.format = wb.createDataFormat();
	}
	public void init(String sheetname) {
		this.wb = new SXSSFWorkbook(100);
		this.sheet = wb.createSheet(sheetname);
		this.styles = createStyles(wb);
		this.format = wb.createDataFormat();
	}
	public void createSheet(String sheetname){
		this.sheet = wb.createSheet(sheetname);
		rownum=0;
		Row titleRow = sheet.createRow(rownum++);
		for (int i = 0; i < titleName.length; i++) {
			Cell cell = titleRow.createCell(i);
			cell.setCellStyle(styles.get("title"));
			cell.setCellValue(titleName[i]);
		}
	}
	public <E> ExportExcelUtil setDataList(List<E> list) {
		for (E e : list) {
			int colunm = 0;
			Row row = this.addRow();
			for (String key : titleKey) {
				Object val = null;
				try {
					val = ReflectUtil.getFieldValue(e, key);
					//获取1对多的值
					if (keyMapping.get(key) != null) {
						val = keyMapping.get(key).get(val);
					}
				} catch (Exception ex) {
				}
				this.addCell(row, colunm++, val);
			}
		}
		return this;
	}
	public <E> ExportExcelUtil setDataListRecord(List<Record> list) {
		logger.info("start export data ===========>>>>>"+list.size()+" number");
		for (Record e : list) {
			int colunm = 0;
			Row row = this.addRow();
			for (String key : titleKey) {
				Object val = null;
				try {
					val = e.get(key);
					//获取1对多的值
					if (keyMapping.get(key) != null) {
						val = keyMapping.get(key).get(val);
					}
				} catch (Exception ex) {
				}
				this.addCell(row, colunm++, val);
			}
		}
		return this;
	}
	public <E> ExportExcelUtil setDataListMap(List<Map<Object,Object>> list) {
		for (Map<Object,Object> e : list) {
			int colunm = 0;
			Row row = this.addRow();
			for (String key : titleKey) {
				Object val = null;
				try {
					val = e.get(key);
				} catch (Exception ex) {
				}
				this.addCell(row, colunm++, val);
			}
		}
		return this;
	}


	public ExportExcelUtil write(OutputStream os) throws IOException {
		wb.write(os);
		return this;
	}

	/**
	 * 输出到客户端
	 * @param fileName 输出文件名
	 */
	public ExportExcelUtil write(HttpServletResponse response, String fileName) throws IOException {
		response.reset();
		response.setContentType("application/octet-stream; charset=utf-8");
		response.setHeader("Content-Disposition", "attachment; filename=" + URLDecoder.decode(fileName, "UTF-8"));
		write(response.getOutputStream());
		return this;
	}

	/**
	 * 输出到文件
	 * @param fileName 输出文件名
	 */
	public ExportExcelUtil writeFile(String name) throws FileNotFoundException, IOException {
		FileOutputStream os = new FileOutputStream(name);
		this.write(os);
		return this;
	}

	/**
	 * 清理临时文件
	 */
	public ExportExcelUtil dispose() {
		wb.dispose();
		return this;
	}


	/**
	 * 创建表格样式
	 * @param wb 工作薄对象
	 * @return 样式列表
	 */
	private Map<String, CellStyle> createStyles(Workbook wb) {
		Map<String, CellStyle> styles = new HashMap<String, CellStyle>();
		CellStyle style  = wb.createCellStyle();
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		style.setBorderRight(CellStyle.BORDER_THIN);
		style.setRightBorderColor(IndexedColors.GREY_50_PERCENT.getIndex());
		style.setBorderLeft(CellStyle.BORDER_THIN);
		style.setLeftBorderColor(IndexedColors.GREY_50_PERCENT.getIndex());
		style.setBorderTop(CellStyle.BORDER_THIN);
		style.setTopBorderColor(IndexedColors.GREY_50_PERCENT.getIndex());
		style.setBorderBottom(CellStyle.BORDER_THIN);
		style.setBottomBorderColor(IndexedColors.GREY_50_PERCENT.getIndex());
		Font dataFont = wb.createFont();
		dataFont.setFontName("Arial");
		dataFont.setFontHeightInPoints((short) 10);
		style.setFont(dataFont);
		styles.put("data", style);
		style = wb.createCellStyle();
		style.cloneStyleFrom(styles.get("data"));
		//		style.setWrapText(true);
		style.setAlignment(CellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.GREY_50_PERCENT.getIndex());
		style.setFillPattern(CellStyle.SOLID_FOREGROUND);
		Font headerFont = wb.createFont();
		headerFont.setFontName("Arial");
		headerFont.setFontHeightInPoints((short) 10);
		headerFont.setBoldweight(Font.BOLDWEIGHT_BOLD);
		headerFont.setColor(IndexedColors.WHITE.getIndex());
		style.setFont(headerFont);
		styles.put("title", style);
		return styles;
	}

	public void addMapper(String key, Map<Object, Object> value) {
		keyMapping.put(key, value);
	}
	
	public void addSheet(int page){
		this.sheet=wb.createSheet();
	}
	
	public String getDateFormat() {
		return dateFormat;
	}

	public void setDateFormat(String dateFormat) {
		this.dateFormat = dateFormat;
	}

	public int getRownum() {
		return rownum;
	}

	public void setRownum(int rownum) {
		this.rownum = rownum;
	}


	public String[] getTitleName() {
		return titleName;
	}


	public void setTitleName(String[] titleName) {
		this.titleName = titleName;
	}


	public String[] getTitleKey() {
		return titleKey;
	}


	public void setTitleKey(String[] titleKey) {
		this.titleKey = titleKey;
	}
}
