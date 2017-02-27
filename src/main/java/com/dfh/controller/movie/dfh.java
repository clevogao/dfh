package com.dfh.controller.movie;

import com.dfh.controller.BaseController;
import com.dfh.service.MoveService;

/**
 * ^_^
 * Description: TODO
 * Author: gaojiawei
 * Date: 2017/2/21
 */
public class dfh extends BaseController{
	public void index(){
		renderJson (new MoveService ().getMoves ());
	}

}