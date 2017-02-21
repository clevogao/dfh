/**
 * BaseTest.java
 * Created at 2015年12月2日
 * Created by gaojiawei
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.dfh;

import org.junit.Before;
import com.jfinal.plugin.activerecord.Db;

/**
 * ClassName: BaseTest
 * Description: TODO
 * Author: gaojiawei
 * Date: 2015年12月2日
 */
public class BaseTest {
	@Before
	public void init(){
		new Test();
	}
	
	/**
	 * Description:  打印sql返回结果
	 * @param sql
	 * @param parm 
	 * Created by gaojiawei 2015年12月2日
	 */
	public void log(String sql,Object... parm){
		System.out.println(Db.find(sql,parm));
	}
	/**
	 * Description: 打印sql返回结果
	 * @param sql
	 * Created by gaojiawei 2015年12月2日
	 */
	public void log(String sql){
		
		System.out.println(Db.find(sql));
	}
}
