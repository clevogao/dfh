/**
 * LoggerInteceptor.java
 * Created at 2015年9月6日
 * Created by gaojiawei
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.dfh.interceptors;

import com.alibaba.fastjson.JSON;
import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import com.jfinal.core.Controller;
import com.jfinal.kit.HttpKit;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**
 * ClassName: LoggerInteceptor
 * Description: TODO
 * Author: gaojiawei
 * Date: 2015年9月6日
 */
public class LoggerInteceptor implements Interceptor{
	private final Logger logger = LoggerFactory.getLogger (LoggerInteceptor.class);

	/**
	 * Description: 记录日志
	 * Created by gaojiawei 2015年9月6日
	 */
	public void intercept(Invocation inv) {
		Controller contro = inv.getController();
		HttpServletRequest request = contro.getRequest();


		if("application/json".equals(request.getContentType())){
			String json= HttpKit.readIncommingRequestData(request);
			Map<String, Object> map = new HashMap<String, Object> ();
			for (Map.Entry<String, Object> set : JSON.parseObject (json).entrySet ()) {
				try {
					map.put(set.getKey(), set.getValue());
				} catch (Exception e) {

				}
			}
		//	inv.getController().getRequest().getParameterMap ().putAll (map);
		}
		try {
			logger.info("请求url："+inv.getController().getRequest().getRequestURI());
			logger.info("请求参数："+ JSON.toJSONString(inv.getController().getRequest().getParameterMap()));
		} catch (Exception e) {
			e.printStackTrace ();
		}
		inv.invoke();
	}
	
	
}
