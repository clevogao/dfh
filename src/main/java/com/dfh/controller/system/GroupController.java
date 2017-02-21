/**
 * GroupController.java
 * Created at 2015年12月18日
 * Created by gaojiawei
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.dfh.controller.system;

import com.dfh.controller.BaseController;
import com.jfinal.plugin.activerecord.Db;

/**
 * ClassName: GroupController
 * Description: TODO
 * Author: gaojiawei
 * Date: 2015年12月18日
 */
public class GroupController extends BaseController{
	public void index(){
		render("/jsp/sys/GroupManager.jsp");
	}
	

	/**
	 * Description: 获取所有层级
	 * Created by gaojiawei 2015年12月18日
	 */
	public void getOrg(){
		renderJson(Db.find("select * from report.sys_organize where del =0 "));
	}
	/**
	 * Description: 获取对应层级
	 * Created by gaojiawei 2015年12月18日
	 */
	public void getGroupOrg(){
		renderJson(Db.find("select orgid as id,groupid as pid from report.sys_group_organize where groupid=?",getPara("groupid")));
	}
	
	public void getMenu(){
		renderJson(Db.find("select id,text as name,pid,del from report.sys_menu "));
	}
	

}
