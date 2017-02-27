/**
 * IndexsController.java
 * Created at 2015年11月25日
 * Created by gaojiawei
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.dfh.controller.system;
import com.dfh.main.Result;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

/**
 * ClassName: IndexsController
 * Description: 
 * Author: gaojiawei
 * Date: 2015年11月25日
 */
public class IndexsController extends Controller {
	public static boolean canlogin=true;
	public void loginout() {
		getSession().removeAttribute("user");
		getSession().invalidate();
		redirect("/login.jsp");
	}
	public void changeLogin(){
		canlogin=!canlogin;
	}
	
	public void login() {
		if(canlogin){
			Record user = (Record)Db.findFirst("select * from employeeuser where phonenumber =?",getPara("loginname"));
			if (user==null) {
				renderJson(new Result (1, "用户名不存在"));
			} else if (!user.get("workecode").equals(getPara("password"))) {
				renderJson(new Result(2, "用户密码不正确"));
			}
			else if(Db.queryLong("select count(1) from report.sys_menu_employeeuser where employeeuser_id=?",user.getStr("_id"))<1){
				renderJson(new Result(3, "没有登陆权限"));
			}
			else {
				setSessionAttr("user", user);
				renderJson(0);
			}
		}else{
			getSession().invalidate();
		}
		
	}

}
