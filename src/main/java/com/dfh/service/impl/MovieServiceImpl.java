package com.dfh.service.impl;

import com.dfh.Manager.move.MoveConvertManager;
import com.dfh.service.MovieService;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.redis.Redis;
import org.voovan.http.client.HttpClient;
import org.voovan.network.exception.ReadMessageException;
import org.voovan.network.exception.SendMessageException;

import java.util.List;

/**
 * ^_^
 * Description: TODO
 * Author: gaojiawei
 * Date: 2017/2/28
 */
public class MovieServiceImpl implements MovieService {
	private static HttpClient  httpClient = new HttpClient (PropKit.get ("phpurl.url"));//http
	private static final String base_mac_void_sql = "select d_id,d_name,d_content,d_pic,d_playfrom,d_playurl from mac_vod where 1=1 ";
	private static final String simel_mac_void_sql = "select d_id,d_name,d_pic from mac_vod  ";

	public List<Record> getHotMovie () {
		return getMovesByWhere (" where d_level in (4,5) order by d_hits desc");
	}

	private List<Record> getMovesByWhere (String where) {
		return Db.find (simel_mac_void_sql + where);
	}

	public List<Record> getMoviesByType (int typeId, int index, int last) {
		String queryByTagSql =simel_mac_void_sql+ "  d LEFT JOIN mac_vod_type p on d.d_class like CONCAT(\"%\",p.t_id,\"%\") where p.t_id=? order by d_time limit ? ,? ";
		return Db.find (queryByTagSql, typeId,index,last);
	}

	/**
	 * @return 获取详情页面
	 * @param id
	 */
	public Record getDetails (Integer id) {
		return MoveConvertManager.GetInstance ().covertPhp (Db.findFirst (simel_mac_void_sql + " and id =?", id));
	}

	@Override
	public Record getUrl (String type, String md5, String id) {
		HttpClient httpClient = new HttpClient (PropKit.get ("phpurl.url"));//http
		return null;
	}

	public static void main (String[] args) throws SendMessageException, ReadMessageException {
		PropKit.use("config.properties");
		HttpClient httpClient = new HttpClient (PropKit.get ("phpurl.url"));//http
		System.out.println ("MovieServiceImpl.main()-------------->>>>>" + httpClient.send ("/mdparse/url.php?md5=111").body ().getBodyString ());
	}

}