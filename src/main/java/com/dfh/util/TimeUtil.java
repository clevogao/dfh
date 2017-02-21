package com.dfh.util;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;
import java.util.UUID;

/**
 * ClassName: TimeUtil
 * Description: TODO
 * Author: gaojiawei
 * Date: 2015年10月16日
 */
public class TimeUtil {
	/**
	 * 获取唯一标示
	 */
	public static String getStringTime() {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSSS");
		return sdf.format(date) + UUID.randomUUID().toString().substring(0, 4);//
	}

	/**
	 * Description: 获取今天日期
	 * @return
	 * Created by gaojiawei 2015年10月16日
	 */
	public static String getDate() {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		return df.format(new Date());
	}

	/**
	 * 根据指定格式获取时间戳
	 */
	public static Timestamp getTimestamp(String time, String format) {
		DateFormat d = new SimpleDateFormat(format);
		try {
			return new Timestamp(d.parse(time).getTime());
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}

	public static java.sql.Date getSqlDate(String time) {
		try {
			return new java.sql.Date(TimeUtil.getTimestamp(time).getTime());
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 获取指定时间的时间戳
	 * (时间格式yyyy-MM-dd 或者yyyy-MM-dd HH:mm:ss)
	 */
	public static Timestamp getTimestamp(String time) {
		DateFormat d;
		if (time.length() < 12) {
			d = new SimpleDateFormat("yyyy-MM-dd");
		} else {
			d = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		}
		try {
			return new Timestamp(d.parse(time).getTime());
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * @return 在两个时间之间
	 */
	public static boolean between(Timestamp s, Timestamp e) {
		try {
			if (s.getTime() < System.currentTimeMillis() && e.getTime() > System.currentTimeMillis())
				return true;
			return false;
		} catch (Exception e1) {
			e1.printStackTrace();
			return false;
		}
	}

	/**
	 * 获取当前时间戳
	 */
	public static Timestamp getNewDate() {
		return new Timestamp(System.currentTimeMillis());
	}

	/**
	 * Description: 只获取时间
	 */
	public static String getTime() {
		SimpleDateFormat df = new SimpleDateFormat("hh:mm:ss");
		return df.format(new Date());
	}

	/**
	 * 根据format获取当前时间字符串
	 */
	public static String getFormatDate(String format) {
		SimpleDateFormat df = new SimpleDateFormat(format);
		return df.format(new Date());
	}

	/**
	 * 根据format获取指定时间字符串
	 */
	public static String getFormatDate(Date d, String format) {
		SimpleDateFormat df = new SimpleDateFormat(format);
		return df.format(d);
	}

	/**
	 * 字符串转换为时间
	 */
	public static Date formatDate(String s, String format) {
		DateFormat df = new SimpleDateFormat(format);
		try {
			return df.parse(s);
		} catch (ParseException e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 获得当前周周一的日期
	 */
	public static String getWeekMonday() {
		int mondayPlus = getMondayPlus();
		GregorianCalendar currentDate = new GregorianCalendar();
		currentDate.add(GregorianCalendar.DATE, mondayPlus);
		Date monday = currentDate.getTime();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String preMonday = sdf.format(monday);
		return preMonday;
	}
	/**
	 * 获得指定周周一的日期
	 */
	public static String getWeekMonday(String date) {
		int mondayPlus = getMondayPlus(date);
		GregorianCalendar currentDate = new GregorianCalendar();
		currentDate.setTime(getSqlDate(date));
		currentDate.add(GregorianCalendar.DATE, mondayPlus);
		Date monday = currentDate.getTime();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String preMonday = sdf.format(monday);
		return preMonday;
	}

	/**
	 * 获得当前周日 的日期
	 */
	public static String getWeekSunday() {
		int mondayPlus = getMondayPlus();
		GregorianCalendar currentDate = new GregorianCalendar();
		currentDate.add(GregorianCalendar.DATE, mondayPlus + 6);
		Date monday = currentDate.getTime();
		DateFormat df = DateFormat.getDateInstance();
		String preMonday = df.format(monday);
		return preMonday;
	}
	/**
	 * 获得指定日期的周日 的日期
	 */
	public static String getWeekSunday(String date) {
		int mondayPlus = getMondayPlus(date);
		GregorianCalendar currentDate = new GregorianCalendar();
		currentDate.setTime(getSqlDate(date));
		currentDate.add(GregorianCalendar.DATE, mondayPlus + 6);
		Date monday = currentDate.getTime();
		DateFormat df = DateFormat.getDateInstance();
		String preMonday = df.format(monday);
		return preMonday;
	}
	
	/**
	 * Description: 获取本月第一天日期
	 */
	public static String getMonthFistDay(){
		Calendar c = Calendar.getInstance();
		c.setTime(new Date());
		c.set(Calendar.DATE, 1);
		return new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
	}
	/**
	 * Description: 获取指定时间的月第一天
	 */
	public static String getMonthFistDay(String date){
		Calendar c = Calendar.getInstance();
		c.setTime(getSqlDate(date));
		c.set(Calendar.DATE, 1);
		return new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
	}
	
	/**
	 * Description: 获取增量 day天数的日期
	 * @param time (yyyy-MM-dd)
	 */
	public static String getSubData(String time,int day){
		Calendar c = Calendar.getInstance();
		c.setTime(getSqlDate(time));
		int daytime=c.get(Calendar.DATE); 
		c.set(Calendar.DATE,daytime+day);
		return new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
	}
	
	/**
	 * 获得当周和周一的日期差
	 */
	public static int getMondayPlus() {
		Calendar cd = Calendar.getInstance();
		// 获得今天是一周的第几天，星期日是第一天，星期二是第二天......
		int dayOfWeek = cd.get(Calendar.DAY_OF_WEEK);
		if (dayOfWeek == 1) {
			return -6;
		} else {
			return 2 - dayOfWeek;
		}
	}
	/**
	 * 
	 * 获得指定日期和周一的日期差
	 */
	public static int getMondayPlus(String date) {
		Calendar cd = Calendar.getInstance();
		cd.setTime(getSqlDate(date));
		// 获得今天是一周的第几天，星期日是第一天，星期二是第二天......
		int dayOfWeek = cd.get(Calendar.DAY_OF_WEEK);
		if (dayOfWeek == 1) {
			return -6;
		} else {
			return 2 - dayOfWeek;
		}
	}
	
	
	public static String  getBeforDay(){
		return getBeforDay(getDate());
	}
	
	/**
	 * 
	 * Description: 根据任意一天算出前一天
	 * @param specifiedDay 传入的日期
	 * @return
	 * Created by zhangjianfeng 2015年10月19日
	 */
	  public static String getBeforDay(String specifiedDay){  
	        Calendar c = Calendar.getInstance();  
	        Date date = null;  
	        try{  
	            date = new SimpleDateFormat("yy-MM-dd").parse(specifiedDay);  
	        }catch (Exception e) {  
	            e.printStackTrace();  
	        }  
	        c.setTime(date);  
	        int day = c.get(Calendar.DATE);  
	        c.set(Calendar.DATE, day-1);  
	        String dayBefore = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());  
	        return dayBefore;  
	  }  
	  /**
	   * 
	   * Description: 获取当月天数
	   * @return
	   * Created by zhangjianfeng 2015年10月21日
	   */
	  public static Integer getMonthforDay(){
		  Calendar aCalendar = Calendar.getInstance(Locale.CHINA);
		  return aCalendar.getActualMaximum(Calendar.DATE);
	  }
	  
	public static void main(String[] args) {
		System.out.println(getMonthforDay());
	}
}
