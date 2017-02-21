/**
 * MenuTest.java
 * Created at 2015年12月2日
 * Created by gaojiawei
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.dfh.system;

import com.alibaba.fastjson.JSON;
import com.dfh.BaseTest;
import com.dfh.Manager.sys.MenuManager;
import com.dfh.Manager.sys.TreeModel;
import com.dfh.common.code.RedisCode;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.redis.Redis;
import org.junit.Test;

import java.util.ArrayList;
import java.util.List;

/**
 * ClassName: MenuTest
 * Description: TODO
 * Author: gaojiawei
 * Date: 2015年12月2日
 */
public class MenuTest extends BaseTest {
	@Test
	public void menuinit(){
		MenuManager.initMenu();
		MenuManager.intiAllMenu();
		System.out.println(JSON.toJSONString(Redis.use().get(RedisCode.menuList).toString()));
	}
	public static void main(String[] args) {
		new com.dfh.Test ();
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
		
		System.out.println(JSON.toJSONString(Redis.use().get(RedisCode.menuList)));
	}
}
