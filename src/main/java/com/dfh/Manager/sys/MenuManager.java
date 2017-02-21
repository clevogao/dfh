/**
 * MenuManager.java
 * Created at 2015年11月27日
 * Created by gaojiawei
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.dfh.Manager.sys;

import com.dfh.common.code.RedisCode;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.redis.Redis;

import java.util.List;

/**
 * ClassName: MenuManager
 * Description: 菜单管理
 * Author: gaojiawei
 * Date: 2015年11月27日
 */
public class MenuManager {
	/**
	 * Description: 左侧初始化菜单
	 * Created by gaojiawei 2015年11月27日
	 */
	public static void initMenu(){
		String menuSql="select * from report.sys_menu where pid=0";
		List<Record> menuList=Db.find(menuSql);
		for(Record r:menuList){
			r.set("nodes", Db.find("select * from report.sys_menu where pid=?",r.get("id")));
		}
		Redis.use().set(RedisCode.menuList, menuList);
	}
	
	/*public static void initMenu() {
		List<TreeModel> treeList = new ArrayList<TreeModel>();;
		String sql="select  id,icon,text,url from report.sys_menu where pid=0 and del=0 order by order_";
		List<Record> menuList=Db.find(sql);
		for(Record r:menuList){
			List<TreeModel> treeLists = new ArrayList<TreeModel>();
			TreeModel tree=new TreeModel(r.getStr("text"),1,r.getInt("id"),r.get("url"));
			r.set("nodes", Db.find("select id,icon,text,url from report.sys_menu where pid=?",r.get("id")));
			sql = "select * from report.sys_menu where pid="
					+ tree.getId();
			for(Record rs:Db.find(sql)){
				TreeModel trees=new TreeModel(rs.getStr("text"),2,rs.getInt("id"),rs.get("url"));
				treeLists.add(trees);
			}
			tree.setNodes(treeLists);
			treeList.add(tree);
		}
		
		Redis.use().set(RedisCode.menuList, treeList);
	}*/
	/**
	 * Description: 所有菜单
	 * Created by gaojiawei 2015年12月2日
	 */
	public static void intiAllMenu(){
		Redis.use().set(RedisCode.SYS_ALL_MENU, Db.find("select id,text as name,url,pid from report.sys_menu where del=0 order by order_"));
	}
}
