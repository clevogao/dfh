/**
 * Result.java
 * Created at 2015年10月24日
 * Created by gaojiawei
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.dfh.main;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

/**
 * ClassName: Result
 * Description: 页面同意返回值
 * Author: gaojiawei
 * Date: 2015年10月24日
 */
public class Result implements Serializable{
	private static final long serialVersionUID = 552697004590293172L;
	private Map<String,Object> Data=new HashMap<String, Object>();
	private Integer code;
	private String msg;


	
	public static Map<String,Object> getResultMap(Object datas, Object lately){
		Map<String, Object> Data = new HashMap<String, Object>();
		Map<String, Object> parm = new HashMap<String, Object>();
		parm.put("datas", datas);
		parm.put("lately", lately);
		Data.put("Data", parm);
		Data.put("ErrCode", "");
		Data.put("ErrMsg", "");
		return Data;
	}
	
	public Result(String msg) {
		this.code = 0;
		this.msg = msg;
	}
	public Result(Integer code,String msg) {
		this.code = code;
		this.msg = msg;
	}

	

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Integer getCode() {
		return code;
	}

	public void setCode(Integer code) {
		this.code = code;
	}

	public Map<String, Object> getData() {
		return Data;
	}

	public void setData(Map<String, Object> data) {
		Data = data;
	}


	
}
