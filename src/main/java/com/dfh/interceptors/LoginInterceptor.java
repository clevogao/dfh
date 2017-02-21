/**
 * ReportValidator.java
 * Created at 2015年10月29日
 * Created by gaojiawei
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.dfh.interceptors;

import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import com.jfinal.core.Controller;

/**
 * ClassName: ReportValidator
 * Description: 登陆的校验
 * Author: gaojiawei
 * Date: 2015年10月29日
 */
public class LoginInterceptor implements Interceptor{
	
	public void intercept(Invocation ai) {
		Controller controller=ai.getController();
		
		if(controller.getSessionAttr("user")==null){
			//controller.setSessionAttr("nologin", 1);
			controller.redirect("/redirect.jsp");
		}else{
			ai.invoke();
		}
	}
	
}
