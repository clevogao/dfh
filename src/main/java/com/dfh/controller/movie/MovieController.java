package com.dfh.controller.movie;

import com.dfh.controller.BaseController;
import com.dfh.service.MovieService;
import com.dfh.service.TypeService;
import com.dfh.service.impl.MovieServiceImpl;
import com.dfh.service.impl.TypeServiceImpl;
import com.jfinal.plugin.activerecord.Record;

import java.util.ArrayList;
import java.util.List;

/**
 * ^_^
 * Description: 电影
 * Author: gaojiawei
 * Date: 2017/2/21
 */
public class MovieController extends BaseController {
	private MovieService movieService =new MovieServiceImpl ();
	private TypeService typeService=new TypeServiceImpl ();

	/**
	 * 首页电影信息
	 */
	public void index () {
		List<Record> records = new ArrayList<> ();
		Record hot = new Record ();
		hot.set ("t_name","连续热播");//热播
		hot.set ("moves", movieService.getHotMovie ());
		records.add (hot);
		typeService.getTypesByPid (0).forEach (record -> {
			records.add (new Record ().set ("t_name",record.get ("t_name"))
								.set ("moves",movieService.getMoviesByType (record.get("t_id"),0,7))
								.set ("class",typeService.getClassByTypeId (record.get ("t_id"),0,7)));
		});
		renderJson (records);
	}

	/**
	 * 获取电影详情页
	 * 传入参数 : d_id
	 */
	public void details(){
		renderJson (movieService.getDetails (getParaToInt("d_id")));
	}


	public void getUrl(){
		renderJson ();
	}

}