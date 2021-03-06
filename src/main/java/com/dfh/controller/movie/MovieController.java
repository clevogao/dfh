package com.dfh.controller.movie;

import com.dfh.controller.BaseController;
import com.dfh.service.MovieService;
import com.dfh.service.TypeService;
import com.dfh.service.impl.MovieServiceImpl;
import com.dfh.service.impl.TypeServiceImpl;
import com.google.common.collect.Lists;
import com.jfinal.plugin.activerecord.Record;

import java.util.ArrayList;
import java.util.List;

import static com.dfh.util.IpAddrUtil.getIpAddr;

/**
 * ^_^
 * Description: 电影
 * Author: gaojiawei
 * Date: 2017/2/21
 */
public class MovieController extends BaseController {
	private MovieService movieService = new MovieServiceImpl ();
	private TypeService typeService = new TypeServiceImpl ();

	/**
	 * 首页电影信息
	 */
	public void index () {
		List<Record> records = new ArrayList<> ();
		Record hot = new Record ();
		hot.set ("t_name", "连续热播");//热播
		hot.set ("moves", movieService.getHotMovie ());
		hot.set ("class", null);
		hot.set ("t_id", 0);
		records.add (hot);
		typeService.getTypesByPid (0).forEach (record -> {
			records.add (new Record ().set ("t_name", record.get ("t_name"))
					.set ("moves", movieService.getMoviesByType (record.get ("t_id"), 0, 7))
					.set ("t_id", record.get ("t_id")));
			//								.set ("class",typeService.getClassByTypeId (record.get ("t_id"),0,7)))

		});
		renderJson (records);
	}

	/**
	 * 获取电影详情页
	 * 传入参数 : d_id
	 */
	public void details () {
		Integer tId=getParaToInt ("t_id");
		List<Record> hots= Lists.newArrayList ();
		if(tId!=null){
			 hots=movieService.getMoviesByType (getParaToInt ("t_id"),0,5);
		}
		renderJson (movieService.getDetails (getParaToInt ("d_id")).set ("hot",hots));
	}

	/**
	 * d_playfrom: 播放类型
	 * playid:播放id
	 */
	public void playUrl () {
		String ip = getIpAddr (getRequest ());
		logger.info ("ip:"+ip);
		renderJson (movieService.getUrl (getPara ("d_playfrom"), getPara ("playid"),ip));
	}

	public void queryType () {
		renderJson (movieService.getMoviesByType (getParaToInt ("id"), getIndex (), getLast ()));
	}

	public void query () {
		renderJson (movieService.getMoviesByWhere (getPara ("name"), getIndex (), getLast ()));
	}
}