/**
 * SqlController.java
 * Created at 2016年1月14日
 * Created by gaojiawei
 * Copyright (C) 2016 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.dfh.controller.system;
import com.dfh.interceptors.LoginInterceptor;
import com.jfinal.aop.Before;
import com.jfinal.kit.JsonKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.dfh.controller.BaseController;

/**
 * ClassName: SqlController
 * Description: TODO
 * Author: gaojiawei
 * Date: 2016年1月14日
 */
@Before(LoginInterceptor.class)
public class SqlController extends BaseController {
	public void index() {
		render("/jsp/sys/sql.jsp");
	}

	public void select() {
		try {
			if (!validitySql(getPara("sql"))) {
				renderJson(new Record().set("value", "非法操作"));
			} else {
				renderJson(new Record().set("value", JsonKit.toJson(Db.find(getPara("sql")))));
			}
		} catch (Exception e) {
			e.printStackTrace();
			renderJson(new Record().set("value", e.toString()));
		}
	}

	public void excute() {
		try {
			if (!validitySql(getPara("sql"))) {
				renderJson(new Record().set("value", "非法操作"));
			} else {
				renderJson(new Record().set("value", "一共有" + Db.update(getPara("sql")) + "条结果收到影响"));
			}
		} catch (Exception e) {
			e.printStackTrace();
			renderJson(new Record().set("value", e.getMessage()));
		}
	}

	public boolean validitySql(String sql) {
		if (sql.contains("delete") && !sql.contains("where") || sql.contains("1=1"))
			return false;
		else if (sql.contains("update") && !sql.contains("where") || sql.contains("1=1"))
			return false;
		else if (sql.contains("truncate"))return false;
		return true;
	}
}
