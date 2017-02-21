/**
 * JobInit.java
 * Created at 2015年9月6日
 * Created by gaojiawei
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.dfh.main;
import com.dfh.common.code.DbCode;
import com.dfh.util.TimeUtil;
import com.google.common.base.Throwables;
import com.jfinal.ext.kit.Reflect;
import com.jfinal.log.Logger;
import com.jfinal.plugin.IPlugin;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import org.quartz.*;
import org.quartz.impl.StdSchedulerFactory;

import java.text.ParseException;
import java.util.Date;

/**
 * ClassName: JobInit
 * Description: 初始化job
 * Author: gaojiawei
 * Date: 2015年9月6日
 */
public class QuartzPlugin  implements IPlugin{
	private final Logger logger = Logger.getLogger(QuartzPlugin.class);
	private SchedulerFactory sf;
	private Scheduler sched;
	public QuartzPlugin() {
	}

	public boolean start() {
		this.sf = new StdSchedulerFactory();
		try {
			this.sched = this.sf.getScheduler();
		} catch (SchedulerException e) {
			Throwables.propagate(e);
		}
		//for (Record r : Db.use(PropKit.get("report.name")).find("select * from "+DbCode.MYSQL_REPORT_SITE+" where enable =1 ")) {
			for (Record r : Db.find("select * from "+ DbCode.REPORT_SITE+" where enable =1 ")) {
			String jobClassName = r.getStr("job_name");
			
			Class<?> clazz = (Class<?>) Reflect.on(r.getStr("job_name")).get();
			JobDetail job = new JobDetail("report", jobClassName.substring(jobClassName.lastIndexOf(".")+1), clazz);
			CronTrigger trigger = null;
			try {
				trigger = new CronTrigger("report", jobClassName, r.getStr("cron"));
			} catch (ParseException e) {
				Throwables.propagate(e);
			}
			Date ft = null;
			try {
				ft = this.sched.scheduleJob(job, trigger);
				this.sched.start();
			} catch (SchedulerException e) {
				Throwables.propagate(e);
			}
			logger.debug("启动定时任务："+job.getKey() + " run at: " + TimeUtil.getFormatDate(ft, "yyyy年MM月dd日 HH:mm:ss")
					+ " on expression: " + trigger.getCronExpression());
		}
		return true;
	}

	public boolean stop() {
		try {
			this.sched.shutdown();
		} catch (SchedulerException e) {
			Throwables.propagate(e);
		}
		return true;
	}
}
