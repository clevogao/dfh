/**
 * config.java
 * Created at 2015年9月5日
 * Created by gaojiawei
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.dfh.common;

import com.alibaba.druid.filter.stat.StatFilter;
import com.dfh.controller.IndexController;
import com.dfh.interceptors.LoggerInteceptor;
import com.dfh.main.MyRoutesUtil;
import com.dfh.main.QuartzPlugin;
import com.jfinal.config.*;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.activerecord.dialect.MysqlDialect;
import com.jfinal.plugin.druid.DruidPlugin;
import com.jfinal.plugin.redis.RedisPlugin;
import com.jfinal.render.ViewType;

/**
 * ClassName: config
 * Description: 框架配置
 * Author: gaojiawei
 * Date: 2015年9月5日
 */
public class Config extends JFinalConfig {
	QuartzPlugin quartzPlugin=null;
	/**
	 * 配置常量
	 */
	public void configConstant(Constants me) {
		PropKit.use("config.properties"); // 加载少量必要配置，随后可用PropKit.get(...)获取值
		me.setDevMode(PropKit.getBoolean("jdbc.devMode", false));
		me.setViewType(ViewType.JSP); // 设置视图类型为Jsp，否则默认为FreeMarker
		me.setError404View("/common/jsp/error.jsp");
		me.setError500View("/common/jsp/error.jsp");
	}

	/**
	 * 配置路由
	 */
	public void configRoute(Routes me) {
		me.add("/", IndexController.class);
//		me.add("/movie", MovieController.class);
		MyRoutesUtil.add(me);
	}


	/**
	 * 配置插件
	 */
	public void configPlugin(Plugins me) {
		// 配置Druid数据库连接池插件

		DruidPlugin druidPlugin = new DruidPlugin(PropKit.get("jdbc.url"), PropKit.get("jdbc.user"),
				PropKit.get("jdbc.password"), PropKit.get("jdbc.driver"));
		druidPlugin.addFilter(new StatFilter());
		druidPlugin.setTestWhileIdle(true);
		druidPlugin.setTestOnBorrow(true);
		druidPlugin.setTestOnReturn(true);
		druidPlugin.setFilters("stat");
		me.add(druidPlugin);//读取主库数据源

		// 配置ActiveRecord插件
		ActiveRecordPlugin arp = new ActiveRecordPlugin(druidPlugin);
		arp.setShowSql(true);
//		arp.setDialect(new MyPostgreSqlDialect());
		arp.setDialect (new MysqlDialect ());
		arp.setDevMode (PropKit.getBoolean("jdbc.devMode", true));
		me.add(arp);
		//redis框架插件
		RedisPlugin redisPlugin=new RedisPlugin(PropKit.get("redis.name"),PropKit.get("redis.host"));
		me.add(redisPlugin);
		//mongodb插件
		//MongodbPlugin mPlugin=new MongodbPlugin(PropKit.get("mongo.host"),PropKit.getInt("mogno.port"),PropKit.get("mongo.database"));
		//me.add(mPlugin);
		/*//自动注册表和model关系
		 AutoTableBindPlugin atbp = new AutoTableBindPlugin(druidPlugin, ParamNameStyles.lowerUnderlineModule("syn"));
		atbp.setShowSql(true);
		//大小写不敏感
		atbp.setContainerFactory(new CaseInsensitiveContainerFactory());
		me.add(atbp);*/

		//定时任务插件
//		quartzPlugin = new QuartzPlugin();
		//me.add(quartzPlugin);
	}

	/**
	 * 配置全局拦截器
	 */
	public void configInterceptor(Interceptors me) {
		me.add(new LoggerInteceptor());
		//me.add(new LoginInterceptor());
	}

	/**
	 * 配置处理器
	 */
	public void configHandler(Handlers me) {

	}

	/**
	 * 初始化执行
	 */
	 public void afterJFinalStart() {

	};
	
	
	/**
	 * Description: 系统停止后执行
	 */
	@Override
	public void beforeJFinalStop() {
    
		if(quartzPlugin!=null){
			quartzPlugin.stop();
		}
	}
}
