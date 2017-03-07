/**
 * BaseController.java
 * Created at 2015年10月20日
 * Created by zhangjianfeng
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.dfh.controller;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Record;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;

/**
 * ClassName: BaseController
 * Description: 默认继承类
 * Author: zhangjianfeng
 * Date: 2015年10月20日
 */
public class BaseController extends Controller {
	protected String path="";
	protected String method_name = "";
	public Logger logger=LoggerFactory.getLogger(BaseController.class);
	public BaseController() {
		 this.path=this.getClass().getResource("").toString();
		 this.path="/jsp"+path.substring(path.indexOf("controller/")+10);
	}

	
	public String getUserid(){
		return ((Record)getSessionAttr("user")).getStr("_id");
	}
	
	/**
	 * Description: 将传入参数转换为record
	 * Created by gaojiawei 2015年10月20日
	 */
	protected Record getRecord() {
		Map<String, Object> map = new HashMap<String, Object>();
		for (Entry<String, String[]> set : getParaMap().entrySet()) {
			try {
				map.put(set.getKey(), Integer.parseInt(set.getValue()[0]));
			} catch (Exception e) {
				map.put(set.getKey(), set.getValue()[0]);
			}
		}
		//map=JSON.parseObject(JSON.toJSONString(getParaMap()));
		return new Record().setColumns(map);
	}



	protected int getIndex(){

		return getParaToInt ("index")==null?0:getParaToInt ("index");
	}
	protected int getLast(){
		return getParaToInt ("last")==null?5:getParaToInt ("last");
	}
}
