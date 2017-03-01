package com.dfh.service;

import com.jfinal.plugin.activerecord.Record;

import java.util.List;

/**
 * ^_^
 * Description: 分类管理
 * Author: gaojiawei
 * Date: 2017/2/28
 */
public interface TypeService {
	/**
	 *
	 * @param id type类型的id
	 * @param index limit 值
	 * @param limit limit多少
	 * @return
	 */
	public List<Record> getClassByTypeId (int id, int index, int limit);

	public List<Record> getTypes();

	public List<Record> getTypesByPid(int id);
}