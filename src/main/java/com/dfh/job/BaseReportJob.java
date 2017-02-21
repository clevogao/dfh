/**
 * BaseReportJob.java
 * Created at 2015年10月16日
 * Created by gaojiawei
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.dfh.job;
import java.util.Date;
import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

/**
 * ClassName: BaseReportJob
 * Description: TODO
 * Author: gaojiawei
 * Date: 2015年10月16日
 */
public abstract class BaseReportJob implements Job {
	protected String job_name = "";
	private ThreadLocal<Date> starTime = new ThreadLocal<Date>();
	Logger logger = Logger.getLogger(BaseReportJob.class);

	public BaseReportJob() {
		job_name = getClass().getSimpleName();
	}

	public abstract void excute();
	
	
	
	/**
	 * Description: 插入一条成功纪录
	 */
	public void insertLog() {
		Db.use("report").save("report_log",
				new Record().set("job_name", job_name).set("start_time", starTime.get()).set("end_time", new Date())
						.set("status", 1).set("excute_time", new Date().getTime() - starTime.get().getTime()));
	}
	/**
	 * Description: 根据名称插入一条成功纪录
	 */
	public void insertLog(String name) {
		Db.use("report").save("report_log",
				new Record().set("job_name", name).set("start_time", starTime.get()).set("end_time", new Date())
						.set("status", 1).set("excute_time", new Date().getTime() - starTime.get().getTime()));
	}
	/**
	 * Description: 根据名称插入一条status:0 失败纪录
	 */
	public void insertLog(int status, String name, String content) {
		Db.use("report").save("report_log",
				new Record().set("job_name", name).set("start_time", starTime.get()).set("end_time", new Date())
						.set("status", status).set("excute_time", new Date().getTime() - starTime.get().getTime())
						.set("content", content));
	}
	/**
	 * Description: 插入一条status:0 失败纪录
	 */
	public void insertLog(int status, String content) {
		Db.use("report").save("report_log",
				new Record().set("job_name", job_name).set("start_time", starTime.get()).set("end_time", new Date())
						.set("status", status).set("excute_time", new Date().getTime() - starTime.get().getTime())
						.set("content", content));
	}

	/**
	 * 定时任务执行方法
	 */
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		logger.info("开始同步 ===========" + getClass().getName());
		starTime.set(new Date());
		
		try {
			//调用实现方法
			this.excute();
			insertLog();
		} catch (Exception e) {
			logger.info("同步" + getClass().getName() + "失败", e);
			insertLog(0, e.getMessage());
		}
		logger.info("完成同步===========" + getClass().getName());
	}
}
