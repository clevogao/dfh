/**
 * LoggerInteceptor.java
 * Created at 2015年9月6日
 * Created by gaojiawei
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.dfh.interceptors;

import org.apache.log4j.Logger;
import com.alibaba.fastjson.JSON;
import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;

/**
 * ClassName: LoggerInteceptor
 * Description: TODO
 * Author: gaojiawei
 * Date: 2015年9月6日
 */
public class LoggerInteceptor implements Interceptor{
	Logger logger = Logger.getLogger(LoggerInteceptor.class);
	/**
	 * Description: 记录日志
	 * Created by gaojiawei 2015年9月6日
	 */
	public void intercept(Invocation inv) {
		try {
			logger.info("请求url："+inv.getController().getRequest().getRequestURI());
			logger.info("请求参数："+JSON.toJSONString(inv.getController().getRequest().getParameterMap()));
		} catch (Exception e) {
		}
		inv.invoke();
	}
	
	
}
