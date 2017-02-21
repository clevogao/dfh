/**
 * TestExcel.java
 * Created at 2015年11月16日
 * Created by gaojiawei
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.dfh;

import com.dfh.util.ExportExcelUtil;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;

/**
 * ClassName: TestExcel
 * Author: gaojiawei
 * Date: 2015年11月16日
 */
public class TestExcel {
	public static void main(String[] args) throws FileNotFoundException, IOException {
		new Test();
		
		String sql="select relname,relfilenode from pg_class A where 	a.relkind = 'r'\n" +
				"AND a.relname NOT LIKE 'pg_%'\n" +
				"AND a.relname NOT LIKE 'sql_%'";
		List<Record> find = Db.find(sql);
		
		String[] a = new String[] {"attname","typname","attlen","attnotnull"};
		String[] b = new String[] {"attname","typname","attlen","attnotnull"};
		ExportExcelUtil ee = new ExportExcelUtil(a, b);
		
		for (Record r : find) {
			String str = r.getStr("relname");
			System.out.println(r.getStr("relname"));
			try {
				ee.createSheet(str);
				ee.setDataListRecord(getRecord(r.get("relfilenode").toString()));
			} catch (Exception e) {
			}
			
		}
		ee.writeFile("target/export.xlsx");
		ee.dispose();
		
	}
	
	public static List<Record> getRecord(String attrelid){
		return Db.find("SELECT\n" +
				"		a.attname,a.attlen,t.typname,a.attnotnull,t.typlen\n" +
				"	FROM\n" +
				"		pg_attribute A,\n" +
				"		pg_type T\n" +
				"	WHERE\n" +
				"		a.atttypid = T.oid " +
				"	AND attnum > 0\n" +
				"	AND attisdropped = 'f' and attrelid="+attrelid);
	}
}
