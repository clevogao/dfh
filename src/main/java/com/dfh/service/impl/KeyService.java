package com.dfh.service.impl;

import com.jfinal.plugin.activerecord.Db;

/**
 * ^_^
 * Description: TODO
 * Author: gaojiawei
 * Date: 2017/3/9
 */
public class KeyService {
		public String getKey(){
			return Db.findFirst ("select app_config.key from app_config where name='yunma'").getStr ("key");
		}
}