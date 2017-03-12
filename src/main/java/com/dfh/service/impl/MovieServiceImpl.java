package com.dfh.service.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.dfh.Manager.move.MoviePlayType;
import com.dfh.service.MovieService;
import com.jfinal.kit.HttpKit;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

import java.util.List;

import static com.dfh.Manager.move.MoveConvertManager.GetInstance;

/**
 * ^_^
 * Description: TODO
 * Author: gaojiawei
 * Date: 2017/2/28
 */
public class MovieServiceImpl implements MovieService {
	private static final String base_mac_void_sql = "select d_id,d_name,d_content,d_pic,d_playfrom,d_playurl,d_starring,d_type t_id from mac_vod  ";
	//	private static final String base_mac_void_sql = "select * from mac_vod  ";
	private static final String simel_mac_void_sql = "select d_id,d_name,d_pic,d_starring,d_type t_id from mac_vod  ";
	private KeyService keyService=new KeyService ();
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
		return GetInstance ().covertPhp (Db.findFirst (base_mac_void_sql + " where d_id =?", id));
	}

	@Override
	public List<Record> getMoviesByWhere (String where, int index, int last) {
		return Db.find (simel_mac_void_sql+" where d_name like '%"+where+"%' ");
	}

	@Override
	public Record getUrl (String type, String id, String ip) {
		Record record = new Record ();

			String ext = "";
			String url = "";
			if(type.equals (MoviePlayType.m3u81)){
//				ext="vip";
//				url = "http://3.fuhao56.com/share/"+id;
				ext="vip";
				url=id+"?"+getVip2Url(keyService.getKey (),ip);
			}
			else if (type.equals (MoviePlayType.vip2)){
				ext="vip";
				url=id+"?"+getVip2Url(keyService.getKey (),ip);
			}
			else {
				String json= getM3u81Url (id,type);
				if(!json.equals ("403")){
					JSONObject jsonObject=JSON.parseObject (json);
					ext=jsonObject.getString ("ext");
					url=jsonObject.getString ("url");
				}
			}
			record.set ("ext",ext);
			record.set ("uel",url);

		return record;
	}

	/**
	 * 获取php的url
	 * @param id
	 * @param type
	 * @return
	 */
	private String getM3u81Url(String id, String type) {
		String md5 = HttpKit.get (PropKit.get ("phpurl.url") + "/mdparse/md5.php?md5=" + id);
		String data=String.format ("id=%s&type=%s&md5=%s",id,type,md5);
//		Map<String, String> map = new HashMap<String, String> ();
//		map.put ("id",id);
//		map.put ("type",type);
//		map.put ("md5",md5);
		String json=HttpKit.post (PropKit.get ("phpurl.url")+"/mdparse/url.php",null,data);
		return json;
	}


	private String getVip2Url (String key,String ip) {
		String json = HttpKit.get (PropKit.get ("phpurl.url") + "/mdparse/vip2sign.php?ip=" + ip+"&key="+key);
		return json.replaceAll (" ","").replaceAll ("\r|\n","");
	}

	public static void main (String[] args) {
		String json = HttpKit.get ("http://localhost" + "/mdparse/vip2sign.php?ip=" + "127.0.0.1"+"&key="+"fdsafasdfsad");

		System.out.println (json);
	}
}