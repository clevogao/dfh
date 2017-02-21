/**
 * PropertiesUtil.java
 * Created at 2016年1月14日
 * Created by gaojiawei
 * Copyright (C) 2016 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.dfh.util;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Properties;
import com.mchange.v2.cfg.PropertiesConfig;

/**
 * ClassName: PropertiesUtil
 * Description: TODO
 * Author: gaojiawei
 * Date: 2016年1月14日
 */
public class PropertiesUtil {
	private static PropertiesUtil p = null;
	public String filePath = "";

	private PropertiesUtil(String path) {
		this.filePath = path;
	};

	private PropertiesUtil() {
	};

	public static PropertiesUtil getInterface(String path) {
		synchronized (PropertiesUtil.class) {
			p = new PropertiesUtil(path);
			return p;
		}
	}

	/** 
	 * 根据KEY，读取文件对应的值 
	 * @param key 键 
	 * @return key对应的值 
	 */
	public String readData(String key) {
		//获取绝对路径  
		filePath = PropertiesConfig.class.getResource("/" + filePath).toString();
		//截掉路径的”file:“前缀  
		filePath = filePath.substring(6);
		Properties props = new Properties();
		try {
			InputStream in = new BufferedInputStream(new FileInputStream(filePath));
			props.load(in);
			in.close();
			String value = props.getProperty(key);
			return value;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	/** 
	 * 修改或添加键值对 如果key存在，修改, 反之，添加。 
	 * @param key 键 
	 * @param value 键对应的值 
	 */
	public void writeData(String key, String value) {
		//获取绝对路径  
		filePath = PropertiesConfig.class.getResource("/" + filePath).toString();
		//截掉路径的”file:/“前缀  
		filePath = filePath.substring(6);
		Properties prop = new Properties();
		try {
			File file = new File(filePath);
			if (!file.exists())
				file.createNewFile();
			InputStream fis = new FileInputStream(file);
			prop.load(fis);
			//一定要在修改值之前关闭fis  
			fis.close();
			OutputStream fos = new FileOutputStream(filePath);
			prop.setProperty(key, value);
			//保存，并加入注释  
			prop.store(fos, "Update '" + key + "' value");
			fos.close();
		} catch (IOException e) {
			System.err.println("Visit " + filePath + " for updating " + value + " value error");
		}
	}
}
