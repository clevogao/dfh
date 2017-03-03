package com.dfh.service;

import com.jfinal.plugin.activerecord.Record;

import java.util.List;

/**
 * ^_^
 * Description: 查询电影
 * Author: gaojiawei
 * Date: 2017/2/21
 */
public interface MovieService {
	/**
	 *
	 * @return 热播电影
	 */
	public List<Record> getHotMovie();

	/**
	 * @param typeId 电影typeid
	 * @param index limit
	 *@param last limit
	 *  @return
	 */
	public List<Record> getMoviesByType (int typeId, int index, int last);

	/**
	 * @return 获取详情页面
	 * @param id
	 */
	public Record getDetails(Integer id);

	default public List<Record> getMoviesByWhere () {
		return null;
	}

	public Record getUrl(String type,String md5,String id);
}