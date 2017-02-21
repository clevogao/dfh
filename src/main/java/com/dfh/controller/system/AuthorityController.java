/**
 * AuthorityController.java
 * Created at 2015年11月28日
 * Created by gaojiawei
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.dfh.controller.system;
import com.alibaba.fastjson.JSON;
import com.dfh.Manager.sys.CacheManager;
import com.dfh.common.code.DbCode;
import com.dfh.controller.BaseController;
import com.dfh.interceptors.LoginInterceptor;
import com.dfh.main.DBbatch;
import com.dfh.main.RouteBind;
import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

import java.util.ArrayList;
import java.util.List;

/**
 * ClassName: AuthorityController
 * Author: gaojiawei
 * Date: 2015年11月28日
 */
@RouteBind(path = "auth")
@Before(LoginInterceptor.class)
public class AuthorityController extends BaseController {
	/**
	 * Description: 获取所有菜单tree
	 * Created by gaojiawei 2015年11月27日
	 */
	public void getmenu() {
		renderJson(Db.find("select id,text as name,url,pid,del from report.sys_menu"));
	}

	/**
	 * Description: 添加菜单
	 * Created by gaojiawei 2015年12月2日
	 */
	public void addmenu() {
		try {
			Db.save(DbCode.REPORT_SYS_MENU,getRecord().remove("id"));
			renderJson(1);
		} catch (Exception e) {
			renderJson(0);
			e.printStackTrace();
		}
		//MenuManager.initMenu();//刷新菜单
	}

	/**
	 * Description: 编辑菜单
	 * Created by gaojiawei 2015年12月2日
	 */
	public void editmenu() {
		try {
			Db.update(DbCode.REPORT_SYS_MENU,getRecord());
			renderJson(1);
		} catch (Exception e) {
			renderJson(0);
		}
		//MenuManager.initMenu();//刷新菜单
	}

	/**
	 * Description: 获取所有菜单视图
	 * Created by gaojiawei 2015年11月28日
	 */
	public void getallmenu() {
		//System.out.println(Redis.use().get(RedisCode.menuList));
		//renderJson(Redis.use().get(RedisCode.menuList));
		
//		String menuSql = "select * from report.sys_menu where pid=0 and del=0 order by order_ ";
//		List<Record> menuList = Db.find(menuSql);
//		for (Record r : menuList) {
//			r.set("nodes", Db.find("select * from report.sys_menu where pid=? and del=0 order by order_", r.get("id")));
//		}
		
		System.out.println(JSON.toJSONString(CacheManager.sysMenus));
		renderJson(CacheManager.sysMenus.get(getUserid()));
	}

	/**
	 * Description: 获取所有组织结构
	 * Created by gaojiawei 2015年11月27日
	 */
	public void getOrg() {
		//renderJson(Redis.use().get(RedisCode.SYS_ORGANIZATION));
		renderJson(Db.find("select _id as id,departmentmark as name ,supdepid as pid from master_hrmdepartment "
				+ " where _id not in  (select regexp_split_to_table((select _value from Master_SystemParameters where _id='Department.Cancel'),','))"
				+ "UNION all "
				+ "select _id,name,departmentid from employeeuser where isenabled =1 and  departmentid >0"
				));
	}

	/**
	 * Description: 编辑权限
	 * Created by gaojiawei 2015年11月28日
	 */
	public void editMenuAuth() {
		try {
			//	renderJson(Redis.use().set(getPara("url"), getRecord()));
			Db.update("delete from " + DbCode.REPORT_SYS_MENU_EMPLOYEEUSER + " where menu_id= ?",
					getParaToInt("menu_id"));
			List<Record> ls = new ArrayList<Record>();
			for (String id : getPara("ids").split(",")) {
				ls.add(new Record().set("menu_id", getParaToInt("menu_id")).set("employeeuser_id", id));
			}
			DBbatch.saveBatch(DbCode.REPORT_SYS_MENU_EMPLOYEEUSER, ls, 200);
			renderJson(1);
		} catch (Exception e) {
			logger.error("编辑权限出错", e);
			renderJson(0);
		}
	}

	/**
	 * Description: 获取权限
	 * Created by gaojiawei 2015年11月28日
	 */
	public void getMenuAuth() {
		//renderJson(Redis.use().get(getPara("id"))!=null?Redis.use().get(getPara("id")):"");
		renderJson(Db.find("select employeeuser_id as id from " + DbCode.REPORT_SYS_MENU_EMPLOYEEUSER
				+ " where menu_id =?", getParaToInt("id")));
	}
	
	
}
