/**
 * DBbatch.java
 * Created at 2015年10月22日
 * Created by gaojiawei
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.dfh.main;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import com.alibaba.druid.sql.visitor.functions.Insert;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.DbKit;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;

/**
 * ClassName: DBbatch 
 * Description: 自定义批量操作
 * Author: gaojiawei
 * Date: 2015年10月22日
 */
public class DBbatch {
	
	/**
	 * Description: 只支持string
	 * @param tablename
	 * @param r
	 * @return
	 * Created by gaojiawei 2015年12月15日
	 */
	public static int Insert(String tablename,Record r ){
		StringBuilder sql=new StringBuilder();

		sql.append("insert into ");
		sql.append(tablename).append(" (");
		StringBuilder temp = new StringBuilder();
		temp.append(") values(");
		int index=0;
		for (Entry<String, Object> e: r.getColumns().entrySet()) {
			if(index>0){
				sql.append(",");
				temp.append(",");
			}
			sql.append("").append(e.getKey()).append("");
			temp.append("'"+e.getValue()+"'");
			index++;
		}
		sql.append(temp.toString()).append(")");
		return Db.update(sql.toString());
	}
	
	
	public static int[] saveBatch(String dbname,String tablename, List<Record> list, int batchSize) {
		Connection conn = null;
		int[] result = null;
		PreparedStatement pst = null;
		Boolean autoCommit = null;
		try {
			conn = DbKit.getConfig(dbname).getConnection();
			autoCommit = Boolean.valueOf(conn.getAutoCommit());
			conn.setAutoCommit(false);
			if ((list == null) || (list.size() == 0))
				return new int[0];
			Record record = list.get(0);
			if (batchSize < 1)
				throw new IllegalArgumentException("批量提交次数必须大于0");
			String[] columnArray = new String[record.getColumns().entrySet().size()];
			StringBuilder sql = new StringBuilder();
			sql.append("insert into ");
			sql.append(tablename).append("(");
			StringBuilder temp = new StringBuilder();
			temp.append(") values(");
			int index = 0;
			for (Map.Entry<String, Object> e : record.getColumns().entrySet()) {
				if (index > 0) {
					sql.append(", ");
					temp.append(", ");
				}
				sql.append("").append((String) e.getKey()).append("");
				temp.append("?");
				columnArray[index] = e.getKey();
				index++;
			}
			sql.append(temp.toString()).append(")");
			int counter = 0;
			int pointer = 0;
			int size = list.size();
			result = new int[size];
			pst = conn.prepareStatement(sql.toString());
			for (int i = 0; i < size; ++i) {
				Map<String, Object> map = list.get(i).getColumns();
				for (int j = 0; j < columnArray.length; ++j) {
					Object value = map.get(columnArray[j]);
					pst.setObject(j + 1, value);
				}
				pst.addBatch();
				if (++counter >= batchSize) {
					counter = 0;
					int[] r = pst.executeBatch();
					conn.commit();
					for (int k = 0; k < r.length; ++k)
						result[(pointer++)] = r[k];
				}
			}
			int[] r = pst.executeBatch();
			conn.commit();
			for (int k = 0; k < r.length; ++k)
				result[(pointer++)] = r[k];
		} catch (Exception e) {
			throw new RuntimeException(e);
		} finally {
			try {
				pst.close();
				conn.close();
				conn.setAutoCommit(autoCommit);
			} catch (Exception e2) {
			}
		}
		return result;
	}
	
	/**
	 * 
	 * Description: 批量保存
	 * @param tablename 表名称
	 * @param list 批量数据
	 * @param batchSize 批量次数 最佳为1000
	 * @return
	 * Created by gaojiawei 2015年12月15日
	 */
	public static int[] saveBatch(String tablename, List<Record> list, int batchSize) {
		Connection conn = null;
		int[] result = null;
		PreparedStatement pst = null;
		Boolean autoCommit = null;
		try {
			conn = DbKit.getConfig().getConnection();
			autoCommit = Boolean.valueOf(conn.getAutoCommit());
			conn.setAutoCommit(false);
			if ((list == null) || (list.size() == 0))
				return new int[0];
			Record record = list.get(0);
			if (batchSize < 1)
				throw new IllegalArgumentException("批量提交次数必须大于0");
			String[] columnArray = new String[record.getColumns().entrySet().size()];
			StringBuilder sql = new StringBuilder();
			sql.append("insert into ");
			sql.append(tablename).append("(");
			StringBuilder temp = new StringBuilder();
			temp.append(") values(");
			int index = 0;
			for (Map.Entry<String, Object> e : record.getColumns().entrySet()) {
				if (index > 0) {
					sql.append(", ");
					temp.append(", ");
				}
				sql.append("").append((String) e.getKey()).append("");
				temp.append("?");
				columnArray[index] = e.getKey();
				index++;
			}
			sql.append(temp.toString()).append(")");
			int counter = 0;
			int pointer = 0;
			int size = list.size();
			result = new int[size];
			pst = conn.prepareStatement(sql.toString());
			for (int i = 0; i < size; ++i) {
				Map<String, Object> map = list.get(i).getColumns();
				for (int j = 0; j < columnArray.length; ++j) {
					Object value = map.get(columnArray[j]);
					pst.setObject(j + 1, value);
				}
				pst.addBatch();
				if (++counter >= batchSize) {
					counter = 0;
					int[] r = pst.executeBatch();
					conn.commit();
					for (int k = 0; k < r.length; ++k)
						result[(pointer++)] = r[k];
				}
			}
			int[] r = pst.executeBatch();
			conn.commit();
			for (int k = 0; k < r.length; ++k)
				result[(pointer++)] = r[k];
		} catch (Exception e) {
			throw new RuntimeException(e);
		} finally {
			try {
				pst.close();
				conn.close();
				conn.setAutoCommit(autoCommit);
			} catch (Exception e2) {
			}
		}
		return result;
	}
}
