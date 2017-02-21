/**
 * UserController.java
 * Created at 2015年12月18日
 * Created by gaojiawei
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.dfh.controller.system;

import com.dfh.controller.BaseController;

/**
 * ClassName: UserController
 * Description: 用户管理
 * Author: gaojiawei
 * Date: 2015年12月18日
 */
public class UserController extends BaseController{
	public void index(){
		render(path+"UserManager.jsp");
	}
	

}
