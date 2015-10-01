package com.sysuwater.common;

import java.sql.Connection;
import java.sql.DriverManager;

public class MySQL {
	
	public final static String DBName = "SYSUWater";
	
	public final static String DBHost = "127.0.0.1";
	
	public final static String DBPort = "3306";
	
	public final static String DBUser = "root";
	
	public final static String DBPsw = "123456";
	
	/**
	 * 获取新的  MySQL 连接
	 * @return
	 */
	public static Connection getConnection(){
		try{
			String connectString = "jdbc:mysql://" + DBHost + ":" + DBPort + "/" + DBName
					+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
		
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(connectString, DBUser, DBPsw);
		
			return con;
			
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
	

}
