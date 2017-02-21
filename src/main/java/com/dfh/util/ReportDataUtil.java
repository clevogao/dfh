/**
 * ReportDataUtil.java
 * Created at 2015年10月16日
 * Created by gaojiawei
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.dfh.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.alibaba.fastjson.JSON;
import com.jfinal.plugin.activerecord.Record;


/**
 * ClassName: ReportDataUtil
 * Description: TODO
 * Author: gaojiawei
 * Date: 2015年12月28日
 */
public class ReportDataUtil {
	/**
	 * Description: 获取字段的list
	 * @param parms （"字段1属性","字段1名称"，"字段2属性","字段2名称"）
	 * @return
	 * Created by gaojiawei 2015年12月28日
	 */
	public List<Map<String, String>> getFileds(String ... parms){
		List<Map<String, String>> ls=new ArrayList<Map<String, String>>();
		for(int i=0;i<parms.length;i++){
			Map<String, String> m=new HashMap<String, String>();
			m.put("filed", parms[i]);
			m.put("title", parms[++i]);
			ls.add(m);
		}
		return ls;
	}
	/**
	 * Description: 获取字段的list
	 * @param parms （"字段1属性","字段1名称"，"字段2属性","字段2名称"）
	 * @return
	 * Created by gaojiawei 2015年12月28日
	 */
	public List<Record> getFiledsForRecord(String ... parms){
		List<Record> ls=new ArrayList<Record>();
		for(int i=0;i<parms.length;i++){
			ls.add(new Record().set("filed", parms[i]).set("title", parms[++i]));
		}
		return ls;
	}
	
	public static void main(String[] args) {
		ReportDataUtil r=new ReportDataUtil();
		String a[]=new String[]{"a","b","c","d"};
		System.out.println(JSON.toJSONString(r.getFileds(a)));
		
	}
}
