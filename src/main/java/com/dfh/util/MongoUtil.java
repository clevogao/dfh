/**
 * MongoUtil.java
 * Created at 2015年9月22日
 * Created by gaojiawei
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.dfh.util;
import com.jfinal.ext.plugin.monogodb.MongoKit;
import com.jfinal.plugin.activerecord.Record;
import com.mongodb.BasicDBObject;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * ClassName: MongoUtil
 * Description: 操作mongo工具类
 * Author: gaojiawei
 * Date: 2015年9月22日
 */
public class MongoUtil extends MongoKit {
	/**
	 * 
	 /**
	 * @param collection 表名称
	 * @param filed 查询条件
	 * @param keys 查询字段
	 * @return 查询集合
	 * Created by gaojiawei 2015年10月9日
	 */
	public static List<Record> find(String collection,Map<String, Object> filed,Map<String,String> keys){
		DBCollection coll = getCollection(collection);
		DBCursor dbCursor = coll.find(new BasicDBObject(filed),new BasicDBObject(keys));
		List<Record> records = new ArrayList<Record>();
		while (dbCursor.hasNext()) {
			records.add(toRecord(dbCursor.next()));
		}
		return records;
	}
	
	/**
	 * @param collection 表名称
	 * @param filed 查询条件
	 * @return 查询集合
	 * Created by gaojiawei 2015年10月9日
	 */
	public static List<Record> find(String collection,Map<String, Object> filed){
		DBCollection coll = getCollection(collection);
		DBCursor dbCursor = coll.find(new BasicDBObject(filed));
		List<Record> records = new ArrayList<Record>();
		while (dbCursor.hasNext()) {
			records.add(toRecord(dbCursor.next()));
		}
		return records;
	}
	
	@SuppressWarnings("unchecked")
	public static Map<String, Object> getParm(String file, String parm, Object value) {
		return ObjectUtil.newMap(file, ObjectUtil.newMap(parm, value));
	}
	public static void main(String[] args) {
		Map<String, Object> parm = new HashMap<String, Object>();
		System.out.println(parm.get("ddd")==null);
		System.out.println(String.valueOf(parm.get("user")));
	}
}
