package com.sysuwater.common;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Time {
	
	/**
	 * ������ʱ��תΪ string
	 * @param time
	 * @return
	 */
	public static String convertFromIntToString(long time, String format){
		SimpleDateFormat sdf = new SimpleDateFormat(format);  
        return sdf.format(new Date(time*1000)); 
	}
	
	/**
	 * ��ȡ��ǰʱ��
	 * @return
	 */
	public static int getCurrentTime(){
		return 12345678;
	}

}
