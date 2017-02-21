package com.dfh.main;

import java.util.List;

import com.jfinal.config.Routes;
import com.jfinal.core.Controller;

/**
 * Routes 工具类 自动绑定Controller
 */
public class MyRoutesUtil{
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static void add(Routes me){
		List<Class> list= ClassSearcher.findClasses();
		if(list!=null&&list.isEmpty()==false){
			System.out.print("启动controller：  ");
			for(Class clz:list){
				RouteBind rb=(RouteBind)clz.getAnnotation(RouteBind.class);
				if(rb!=null){
					me.add(rb.path(),clz,rb.viewPath());
				}else if(clz.getSuperclass()!=null){
					if(Controller.class.isAssignableFrom(clz)){
						System.out.print(clz.getSimpleName().replace("Controller", "").toLowerCase()+"  ");
						me.add("/"+clz.getSimpleName().replace("Controller", "").toLowerCase(),clz);
					}
				}
			}
		}
	}
}
