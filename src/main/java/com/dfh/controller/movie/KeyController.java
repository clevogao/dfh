package com.dfh.controller.movie;

import com.dfh.controller.BaseController;
import com.jfinal.plugin.activerecord.Db;

/**
 * ^_^
 * Description: TODO
 * Author: gaojiawei
 * Date: 2017/3/8
 */
public class KeyController extends BaseController {

	public void index(){
		renderJson (Db.findFirst ("select app_config.key from app_config where name='yunma'"));
	}
}