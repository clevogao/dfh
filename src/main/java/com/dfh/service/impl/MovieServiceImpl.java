package com.dfh.service.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.dfh.Manager.move.MoveConvertManager;
import com.dfh.service.MovieService;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
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
	private static final String base_mac_void_sql = "select d_id,d_name,d_content,d_pic,d_playfrom,d_playurl from mac_vod  ";
	//	private static final String base_mac_void_sql = "select * from mac_vod  ";
	private static final String simel_mac_void_sql = "select d_id,d_name,d_pic from mac_vod  ";

	private static HttpClient httpClient;//http


	private HttpClient GetInstance () {
		PropKit.use ("config.properties");
		if (null == httpClient) {
			httpClient = new HttpClient (PropKit.get ("phpurl.url"));
		}
		return httpClient;
	}

	public List<Record> getHotMovie () {
		return getMovesByWhere (" where d_level in (4,5) order by d_hits desc");
	}

	private List<Record> getMovesByWhere (String where) {
		return Db.find (simel_mac_void_sql + where);
	}

	public List<Record> getMoviesByType (int typeId, int index, int last) {
		String queryByTagSql = simel_mac_void_sql + "  d LEFT JOIN mac_vod_type p on d.d_class like CONCAT(\"%\",p.t_id,\"%\") where p.t_id=? order by d_time limit ? ,? ";
		return Db.find (queryByTagSql, typeId, index, last);
	}

	/**
	 * @param id
	 * @return 获取详情页面
	 */
	public Record getDetails (Integer id) {
		return MoveConvertManager.GetInstance ().covertPhp (Db.findFirst (base_mac_void_sql + " where d_id =?", id));
	}

	@Override
	public List<Record> getMoviesByWhere (String where, int index, int last) {
		return Db.find (simel_mac_void_sql+" where d_name like '%"+where+"%' ");
	}

	@Override
	public Record getUrl (String type, String id) {
		Record record = new Record ();
		try {
			String ext = "";
			String url = "";
			if(type.equals ("m3u81")){
				ext="link";
				url = "http://3.fuhao56.com/share/"+id;
			}else {
				String json=GetInstance().send (String.format ("/mdparse/url.php?id=?&type=?",id,type)).body ().getBodyString ();
				if(!json.equals ("403")){
					JSONObject jsonObject=JSON.parseObject (json);
					ext=jsonObject.getString ("ext");
					url=jsonObject.getString ("url");
				}
				record.set ("error","解析错误");
			}
			record.set ("ext",ext);
			record.set ("uel",url);
		} catch (SendMessageException e) {
			e.printStackTrace ();
			record.set ("error","解析错误");
		} catch (ReadMessageException e) {
			e.printStackTrace ();
			record.set ("error","解析错误");
		}
		return record;
	}

}