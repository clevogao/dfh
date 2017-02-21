/**
 * SelectOneJob.java
 * Created at 2015年12月4日
 * Created by gaojiawei
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.dfh.job.sys;

import com.jfinal.plugin.activerecord.Db;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

/**
 * ClassName: SelectOneJob
 * Description: 每60秒查询一次数据，防止断开连接
 * Author: gaojiawei
 * Date: 2015年12月4日
 */
public class SelectOneJob implements Job{

	/**
	 * Description: 每60秒查询一次数据，防止断开连接
	 * @param arg0
	 * @throws JobExecutionException
	 * Created by gaojiawei 2015年12月4日
	 */
	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		Db.find("select 1");
	}
}
