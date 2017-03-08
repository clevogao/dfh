/**
 * IndexController.java
 * Created at 2015年9月6日
 * Created by gaojiawei
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.dfh.controller;

import com.jfinal.core.Controller;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * ClassName: IndexController
 * Description: TODO
 * Author: gaojiawei
 * Date: 2015年9月6日
 */
//@Before(LoginInterceptor.class)
public class IndexController extends Controller{
	
	Logger logger = LoggerFactory.getLogger (IndexController.class);
	public void index(){ 
//		redirect("/redirect.jsp");
	}
	

}
