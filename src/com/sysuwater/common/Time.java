package com.sysuwater.common;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Time {
	
	/**
	 * 将整型时间转为 string
	 * @param time
	 * @return
	 */
	public static String convertFromIntToString(long time, String format){
		SimpleDateFormat sdf = new SimpleDateFormat(format);  
        return sdf.format(new Date(time*1000)); 
	}
	
	/**
	 * 获取当前时间
	 * @return
	 */
	public static int getCurrentTime(){
		return 12345678;
	}

}
