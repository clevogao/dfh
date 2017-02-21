package com.dfh.controller.movie;

import com.dfh.controller.BaseController;
import com.jfinal.plugin.activerecord.Db;

/**
 * ^_^
 * Description: TODO
 * Author: gaojiawei
 * Date: 2017/2/21
 */
public class dfh extends BaseController{
	public void index(){
		renderJson (Db.find ("select * from mac_vod"));
	}

}