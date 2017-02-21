/**
 * TestRedisToController.java
 * Created at 2015年10月23日
 * Created by gaojiawei
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.dfh;

import com.alibaba.fastjson.JSON;
import com.jfinal.plugin.redis.Redis;

/**
 * ClassName: TestRedisToController
 * Description: TODO
 * Author: gaojiawei
 * Date: 2015年10月23日
 */
public class TestRedisToController {
	public static void main(String[] args) {
		new Test();
		System.out.println(JSON.toJSONString(Redis.use().getJedis().keys("*")));;
	}
}
