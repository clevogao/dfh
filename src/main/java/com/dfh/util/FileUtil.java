package com.dfh.util;

import java.io.File;


/**
 * 系统环境相关
 * 
 * @author helyho
 *
 * Voovan Framework.
 * WebSite: https://github.com/helyho/Voovan
 * Licence: Apache v2 License
 */
public class FileUtil {

	/**
	 * 获得应用的工作根目录路径
	 * 
	 * @return
	 */
	public static String getContextPath() {
		return System.getProperty("user.dir");
	}

	/**
	 * 使用相对路径获得系统的完整路径
	 * 
	 * @return
	 */
	public static String getSystemPath(String absolutePath) {
		return getContextPath() + File.separator + absolutePath;
	}

	/**
	 * 休眠函数
	 * 
	 * @param sleepTime
	 */
	public static void sleep(int sleepTime) {
		try {
			Thread.currentThread();
			Thread.sleep(sleepTime);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 获取当前栈信息
	 * 
	 * @return
	 */
	public static StackTraceElement[] getStackElements() {
		Throwable ex = new Throwable();
		return ex.getStackTrace();
	}
	
	/**
	 * 获取当前栈信息
	 * 
	 * @return
	 */
	public static String getStackMessage(){
		String stackInfo = "";
		Throwable ex = new Throwable();
		for (StackTraceElement stackTraceElement : ex.getStackTrace()) {
			stackInfo += stackTraceElement.toString();
			stackInfo += "\r\n";
		}
		
		return stackInfo;
	}
	
	/**
	 * 获取当前栈信息
	 * 
	 * @return
	 */
	public static String getStackElementsMessage(StackTraceElement[] stackTraceElements){
		String stackInfo = "";
		for (StackTraceElement stackTraceElement : stackTraceElements) {
			stackInfo += stackTraceElement.toString();
			stackInfo += "\r\n";
		}
		
		return stackInfo;
	}


	/**
	 * 获取 JVM中的所有线程
	 * @return
	 */
	public static Thread[] getJVMThreads(){
		ThreadGroup group = Thread.currentThread().getThreadGroup().getParent();
		int estimatedSize = group.activeCount() * 2;
		Thread[] slackList = new Thread[estimatedSize];
		int actualSize = group.enumerate(slackList);
		Thread[] list = new Thread[actualSize];
		System.arraycopy(slackList, 0, list, 0, actualSize);
		return list;
	}
}
