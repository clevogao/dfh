package com.dfh.service;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

import java.util.List;

/**
 * ^_^
 * Description: 查询电影
 * Author: gaojiawei
 * Date: 2017/2/21
 */
public class MoveService {

	public List<Record> getMoves(){
		return Db.find ("select * from mac_vod");
	}
}