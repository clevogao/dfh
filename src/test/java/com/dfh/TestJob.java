/**
 * TestJob.java
 * Created at 2015年10月30日
 * Created by gaojiawei
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.dfh;

import com.dfh.main.QuartzPlugin;

/**
 * ClassName: TestJob
 * Description: TODO
 * Author: gaojiawei
 * Date: 2015年10月30日
 */
public class TestJob {
	public static void main(String[] args) {
		new Test();
		QuartzPlugin a=new QuartzPlugin();
		a.start();
		a.stop();
	}
}
