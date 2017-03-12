package com.dfh.movie;

import com.dfh.BaseTest;
import com.dfh.service.impl.MovieServiceImpl;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import org.junit.Test;

/**
 * ^_^
 * Description: TODO
 * Author: gaojiawei
 * Date: 2017/2/28
 */
public class MovieTest extends BaseTest{
	private static final String base_mac_void_sql="select d_id,d_name,d_content,d_pic,d_playfrom,d_playurl from mac_vod where 1=1 ";

	@Test
	public void getMovesIndex () {
		Record indexRecord = new Record ();
		System.out.println ("MovieTest.getMovesIndex()-------------->>>>>" + Db.find (base_mac_void_sql+" and  d_type =1 order by d_time desc"));;
	}
	@Test
	public void clent(){
		String from = "tudouyun";
		String id = "265319287";
		System.out.println ("MovieTest.clent()-------------->>>>>" + new MovieServiceImpl ().getUrl (from,id, "127.0.0.1"));;
	}


}