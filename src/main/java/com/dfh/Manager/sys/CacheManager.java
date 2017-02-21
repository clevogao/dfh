/**
 * Cache.java
 * Created at 2015年12月19日
 * Created by gaojiawei
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.dfh.Manager.sys;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * ClassName: Cache
 * Description: TODO
 * Author: gaojiawei
 * Date: 2015年12月19日
 */
public class CacheManager {

	/**
	 * key:用户id
	 * value:可显示的菜单
	 */
	public static Map<String, List<Record>> sysMenus = new HashMap<String, List<Record>>();
	/**
	 * key:以sys_field_开头,以employeeuser表的_id结尾
	 * value:可查看的字段 : ('姓名','手机号')
	 */
	public static Map<String, String> sysFields = new HashMap<String, String>();

	public static void initMenu(String id) {
		String s = getIntids(
				Db.find("select menu_id id from report.sys_menu_employeeuser where employeeuser_id =?", id), "id");
		String menuSql = "select * from report.sys_menu where  id in " + s + " and pid=0 and del=0  order by order_ ";
		List<Record> menuList = Db.find(menuSql);
		for (Record r : menuList) {
			r.set("nodes", Db.find("select * from report.sys_menu where id in " + s
					+ " and pid=? and del=0 order by order_", r.get("id")));
		}
		sysMenus.put(id, menuList);
	}

	public static void initField(String id) {
		String sql = "select * from sys_field sf left join sys_field_employeeuser se on sf.id= se.fieldid "
				+ "where employeeuser_id='"+id+"' and pid !=0";
	}
	
	public static void initOrg(String id) {
		
	}

	
	public static String getStringFields(List<Record> rs, String key) {
		StringBuilder s = new StringBuilder();
		for (Record r : rs) {
			s.append("," + r.getStr(key) + "");
		}
		return s.toString().substring(1);
	}

	
	public static String getStringids(List<Record> rs, String key) {
		StringBuilder s = new StringBuilder();
		for (Record r : rs) {
			s.append(",'" + r.getStr(key) + "'");
		}
		return "(" + s.toString().substring(1) + ")";
	}

	public static String getIntids(List<Record> rs, String key) {
		StringBuilder s = new StringBuilder();
		for (Record r : rs) {
			s.append("," + r.getInt(key));
		}
		return "(" + s.toString().substring(1) + ")";
	}
}
