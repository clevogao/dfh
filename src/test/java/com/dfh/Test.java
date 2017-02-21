/**
 * test.java
 * Created at 2015年9月10日
 * Created by gaojiawei
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.dfh;
import com.dfh.main.MyPostgreSqlDialect;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.druid.DruidPlugin;
import com.jfinal.plugin.redis.RedisPlugin;

/**
 * ClassName: test
 * Description: TODO
 * Author: gaojiawei
 * Date: 2015年9月10日
 */
public class Test {
	public Test() {
		PropKit.use("config.properties");
		DruidPlugin druidPlugin = new DruidPlugin(PropKit.get("pgread.url"), PropKit.get("pgread.user"),
				PropKit.get("pgread.password"), PropKit.get("pgread.driver"));
		druidPlugin.setFilters("stat");

		druidPlugin.setFilters("stat");
		druidPlugin.start();
//		druidPluginReport.start();
		// 配置ActiveRecord插件
		ActiveRecordPlugin arp = new ActiveRecordPlugin("main",druidPlugin);
		arp.setDialect(new MyPostgreSqlDialect ());
		arp.setShowSql(true);
		arp.start();
//		DruidPlugin druidPluginReport = new DruidPlugin(PropKit.get("report.url"), PropKit.get("report.user"),
//		PropKit.get("report.password"), PropKit.get("driver"));
//		ActiveRecordPlugin arpReport = new ActiveRecordPlugin(PropKit.get("report.name"),druidPluginReport);
//		arpReport.start();
		RedisPlugin redisPlugin=new RedisPlugin(PropKit.get("redis.name"),PropKit.get("redis.host"));
		redisPlugin.start();
		//		MongodbPlugin mPlugin=new MongodbPlugin(PropKit.get("mongo.host"),PropKit.getInt("mogno.port"),PropKit.get("mongo.database"));
		//		mPlugin.start();
	}


}

