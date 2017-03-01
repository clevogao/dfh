package com.dfh.service.impl;

import com.dfh.service.TypeService;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

import java.util.List;

/**
 * ^_^
 * Description: TODO
 * Author: gaojiawei
 * Date: 2017/2/28
 */
public class TypeServiceImpl implements TypeService {

	public List<Record> getClassByTypeId (int id, int index, int last) {
		return Db.find ("select * from mac_vod_class where c_pid=?  order by c_sort  limit ? , ?",id,index,last);
	}

	public List<Record> getTypes () {
		return Db.find ("select * from mac_vod_type");
	}

	@Override
	public List<Record> getTypesByPid (int id) {
			return Db.find ("select * from mac_vod_type where t_pid =? order by t_sort",id);
	}

}