package com.dfh.Manager.move;

import com.dfh.common.SysConfig;
import com.jfinal.plugin.activerecord.Record;

import java.util.ArrayList;
import java.util.List;

/**
 * ^_^
 * Description: PHP电影数据转换管理
 * Author: gaojiawei
 * Date: 2017/2/28
 */
public class MoveConvertManager {
	private static MoveConvertManager moveConvertManager;

	public static MoveConvertManager GetInstance(){
		if(moveConvertManager!=null){
			moveConvertManager=new MoveConvertManager ();
		}
		return moveConvertManager;
	}

	/**
	 *d_playurl:[{}]
	 *
	 * @param pr php单条电影数据
	 * @return 转换后的电影详情页数据
	 */
	public Record covertPhp(Record pr){
		Record record = new Record ();
		record.setColumns (pr);
		record.keep ("d_playfrom");//剔除无需要字段
		convertImg (record);        //图片转换
		//得到播放类型
		return null;
	}


	/**
	 *
	 * @param r 分割d_playurl
	 * @return 单个电影的所有播放地址下的所有电影
	 */
	private List<Record> convert$$$(Record r){
		List<Record> records = new ArrayList<> ();
		String[] playurl = r.getStr ("d_playurl").split ("\\$\\$\\$");
		for (int i = 0; i < playurl.length; i++) {
			Record record = new Record ();
			record.set ("d_playfrom",r.getStr ("d_playfrom").split ("\\$\\$\\$")[i]);
			records.add (record);
		}
		return records;
	}


	/**
	 * @param playurl $$$分割后再次转换的数据
	 * @return 单个电影播放地址数据
	 */
	private List<Record> convert$ (String playurl) {
		String [] sp=playurl.split ("#");
		List<Record> records = new ArrayList<> ();
		for (int i = 0; i <sp.length ; i++) {
			try {
				String[] spp=sp[i].split ("\\$");
				records.add(new Record ().set ("num",spp[0]).set ("playurl",spp[1]));
			} catch (Exception e) {
			}
		}
		return records;
	}


	/**
	 *转换图片地址
	 * @param r r.d_pic 电影数据
	 */
	private void convertImg(Record r){
		String img = r.get ("d_pic");
		if(!img.contains ("http")) r.set ("d_pic", "" + SysConfig.dfh_http_url+img);
	}

	public static void main (String[] args) {
		String ss = "第1集$http://www.acfun.cn/v/ac3441798#第2集$http://www.acfun.cn/v/ac3444021#第3集$http://www.acfun.cn/v/ac3447227#第4集$http://www.acfun.cn/v/ac3449943#第5集$http://www.acfun.cn/v/ac3452410#第6集$http://www.acfun.cn/v/ac3458701#第7集$http://www.acfun.cn/v/ac3460318#第8集$http://www.acfun.cn/v/ac3463854#第9集$http://www.acfun.cn/v/ac3465191#第10集$http://www.acfun.cn/v/ac3470505$acfun$$$第01集$CMTA5ODQ4Mjg=#第02集$CMTEwMzAwOTI=#第03集$CMTEwNDM4OTY=#第04集$CMTEwODg3MDA=#第05集$CMTExMjQxNzY=#第06集$CMTEyMTYzMDg=#第07集$CMTEyOTIxODQ=#第08集$CMTEyOTIxOTI=#第09集$CMTEzMjk4NTY=#第10集$CMTE0MDM0ODQ=$$$http://3.fuhao56.com/1.mp4";
		String [] sp=ss.split ("$$$");

		List<Record> records = new ArrayList<> ();
		for (int i = 0; i <sp.length ; i++) {
			try {
				String[] spp=sp[i].split ("\\$");
				records.add(new Record ().set ("num",spp[0]).set ("playurl",spp[1]));
			} catch (Exception e) {
			}
		}
		System.out.println ("MovieService.main()-------------->>>>>" + records);
	}
}