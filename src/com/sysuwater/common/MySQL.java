package com.sysuwater.common;

import java.lang.reflect.Executable;
import java.sql.*;

import org.apache.naming.java.javaURLContextFactory;

import com.sun.xml.internal.ws.Closeable;

//import com.mysql.jdbc.PreparedStatement;

import jdk.internal.org.objectweb.asm.commons.StaticInitMerger;

public class MySQL
{
	
	public final static String DBName = "SYSUWater";
	
	public final static String DBHost = "127.0.0.1";
	
	public final static String DBPort = "3306";
	
	public final static String DBUser = "root";
	
	public final static String DBPsw = "CNkenio123";
	
	static Connection conn = null;
	
	static java.sql.PreparedStatement pst = null;
	
	/**
	 * 获取新的  MySQL 连接
	 * @return
	 */
	public static Connection getConnection()
	{
		try
		{
			String connectString = "jdbc:mysql://" + DBHost + ":" + DBPort + "/" + DBName
					+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
		
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(connectString, DBUser, DBPsw);

			return conn;
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return null;
		}
	}
	
	public static PreparedStatement prepareSQL ( String sql )
	{
		try
		{
			pst = conn.prepareStatement( sql );
		}
		catch( Exception e )
		{
			e.printStackTrace();
			return null;
		}
		return pst;
	}
	
	public void closeConnection()
	{
		try
		{
			conn.close();
			pst.close();
		}
		catch( Exception e )
		{
			e.printStackTrace();
		}
	}

}
