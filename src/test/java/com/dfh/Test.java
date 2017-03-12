/**
 * test.java
 * Created at 2015年9月10日
 * Created by gaojiawei
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.dfh;
import com.alibaba.druid.filter.stat.StatFilter;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.activerecord.dialect.MysqlDialect;
import com.jfinal.plugin.druid.DruidPlugin;
import org.voovan.db.JdbcOperate;

import java.sql.SQLException;

/**
 * ClassName: test
 * Description: TODO
 * Author: gaojiawei
 * Date: 2015年9月10日
 */
public class Test {
	public Test() {
		PropKit.use("config.properties"); // 加载少量必要配置，随后可用PropKit.get(...)获取值
		DruidPlugin druidPlugin = new DruidPlugin(PropKit.get("jdbc.url"), PropKit.get("jdbc.user"),
				PropKit.get("jdbc.password"), PropKit.get("jdbc.driver"));
		druidPlugin.addFilter(new StatFilter ());
		druidPlugin.setTestWhileIdle(true);
		druidPlugin.setTestOnBorrow(true);
		druidPlugin.setTestOnReturn(true);
		druidPlugin.setFilters("stat");
		druidPlugin.start ();

		// 配置ActiveRecord插件
		ActiveRecordPlugin arp = new ActiveRecordPlugin(druidPlugin);
		arp.setShowSql(true);
		//		arp.setDialect(new MyPostgreSqlDialect());
		arp.setDialect (new MysqlDialect ());
		arp.setDevMode (PropKit.getBoolean("jdbc.devMode", false));
		arp.start ();
//		DruidPlugin druidPluginReport = new DruidPlugin(PropKit.get("report.url"), PropKit.get("report.user"),
//		PropKit.get("report.password"), PropKit.get("driver"));
//		ActiveRecordPlugin arpReport = new ActiveRecordPlugin(PropKit.get("report.name"),druidPluginReport);
//		arpReport.start();
//		RedisPlugin redisPlugin=new RedisPlugin(PropKit.get("redis.name"),PropKit.get("redis.host"));
//		redisPlugin.start();
		//		MongodbPlugin mPlugin=new MongodbPlugin(PropKit.get("mongo.host"),PropKit.getInt("mogno.port"),PropKit.get("mongo.database"));
		//		mPlugin.start();
	}

	public static void main (String[] args) throws SQLException {
		PropKit.use("config.properties"); // 加载少量必要配置，随后可用PropKit.get(...)获取值
		DruidPlugin druidPlugin = new DruidPlugin(PropKit.get("jdbc.url"), PropKit.get("jdbc.user"),
				PropKit.get("jdbc.password"), PropKit.get("jdbc.driver"));
		druidPlugin.addFilter(new StatFilter ());
		druidPlugin.setTestWhileIdle(true);
		druidPlugin.setTestOnBorrow(true);
		druidPlugin.setTestOnReturn(true);
		druidPlugin.setFilters("stat");
		druidPlugin.start ();
		JdbcOperate jdbcOperate = new JdbcOperate (druidPlugin.getDataSource ());
		System.out.println (jdbcOperate.queryMap ("select * from mac_vod limit 1"));
	}
}

