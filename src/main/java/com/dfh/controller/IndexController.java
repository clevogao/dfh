/**
 * IndexController.java
 * Created at 2015年9月6日
 * Created by gaojiawei
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.dfh.controller;

import com.dfh.interceptors.LoginInterceptor;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.log.Logger;

/**
 * ClassName: IndexController
 * Description: TODO
 * Author: gaojiawei
 * Date: 2015年9月6日
 */
@Before(LoginInterceptor.class)
public class IndexController extends Controller{
	
	Logger logger = Logger.getLogger(IndexController.class);
	public void index(){ 
		redirect("/redirect.jsp");
	}
	

}