package com.dfh.util;

import java.util.Collection;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class CheckUtil {

	/**
	 * 校验集合是NULL还是空集合
	 * 
	 * @param list
	 *            :需要校验的集合
	 * @return true:null或者空集合,false:有值的集合
	 */
	public static boolean NullOrEmpty(List list) {
		if (null != list && list.size() > 0) {
			return false;
		} else {
			return true;
		}
	}

	/***
	 * 校验字符串是NULL还是""
	 * 
	 * @param str
	 *            :需要校验的字符串
	 * @return true:NULL或者"",false:有值的字符串
	 */
	public static boolean NullOrEmpty(String str) {
		if (null == str || "".equals(str)) {
			return true;
		} else {
			return false;
		}
	}

	/***
	 * 校验对象数组是否是NULL
	 * 
	 * @param str
	 *            :需要校验的对象
	 * @return true:NULL,false:对象不为空
	 */
	public static boolean NullOrEmpty(Object[] obj) {
		if (null != obj && obj.length > 0) {
			return false;
		} else {
			return true;
		}
	}

	/***
	 * 校验对象是否是NULL
	 * 
	 * @param str
	 *            :需要校验的对象
	 * @return true:NULL,false:对象不为空
	 */
	public static boolean NullOrEmpty(Object obj) {
		if (null == obj) {
			return true;
		} else {
			return false;
		}
	}
    	
	/**
	 * 是否是浮点数
	 * 
	 * @param str
	 *            :校验对象
	 * @return true:是,false:不是
	 */
	public static boolean isMoney(String str) {
		try {
			Double s = new Double(str);
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	/**
	 * 是否是整数数
	 * 
	 * @param str
	 *            :校验对象
	 * @return true:是,false:不是
	 */
	public static boolean isNumber(String str) {
		try {
			Long s = new Long(str);
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	/**
	 * 是否是中文
	 * 
	 * @param str
	 *            :校验对象
	 * @return true:是,false:不是
	 */
	public static boolean ischinese(String str) {
		Pattern p = Pattern.compile("[\u4E00-\u9FA5]");
		Matcher m = p.matcher(str);
		return m.matches();
	}

	/**
	 * 校验中英混合字符长度(中文字符长度*3)
	 * 
	 * @param str
	 *            :字符
	 * @param size
	 *            :最大长度
	 * @return true:通过,false:未通过
	 */
	public static boolean eqlength(String str, long size) {
		long tl = 0;
		for (int itemp = 0; itemp < str.length(); itemp++) {
			if (ischinese(str.substring(itemp, itemp + 1))) {
				tl += 3;
			} else {
				tl += 1;
			}
		}
		if (tl > size) {
			return false;
		}
		return true;
	}

	/**
	 * 校验中英混合字符长度(中文字符长度*3)
	 * 
	 * @param str
	 *            :字符
	 * @param size
	 *            :最大长度
	 * @param isNull
	 *            :是否校验为空
	 * @return true:通过,false:未通过
	 */
	public static boolean eqlength(String str, long size, boolean isNull) {
		long tl = 0;

		// 是否校验为空
		if (isNull) {
			if (CheckUtil.NullOrEmpty(str)) {
				return false;
			}
		}

		for (int itemp = 0; null!=str&&itemp < str.length(); itemp++) {
			if (ischinese(str.substring(itemp, itemp + 1))) {
				tl += 3;
			} else {
				tl += 1;
			}
		}
		if (tl > size) {
			return false;
		}
		return true;
	}
	
	public static boolean isNum(String str){
		return str.matches("^[-+]?(([0-9]+)([.]([0-9]+))?|([.]([0-9]+))?)$");
	}
	
	public static boolean isEquals(Object obj1,Object obj2){
	    if(obj1 == obj2){
	        return true;
	    }
	    if(obj1 != null && obj1.equals(obj2) || obj2 != null && obj2.equals(obj1)){
	        return true;
	    }
	    return false;
	}
	public static String getBaseNullValue(String parm,String value){
		return NullOrEmpty(parm)?value:parm;
	}
	public static List getBaseNullValue(List parm,List value){
		return NullOrEmpty(parm)?value:parm;
	}
	public static Collection getBaseNullValue(Collection parm,Collection value){
		return parm==null||parm.isEmpty()?value:parm;
	}
}
