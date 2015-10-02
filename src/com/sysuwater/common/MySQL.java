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
	
	private static Connection conn = null;
	
	private static PreparedStatement pst = null;
	
	private static ResultSet ret = null;
	
	/**
	 * 获取新的  MySQL 连接
	 * @return
	 */
	public void ConnectToMySQL()
	{
		try
		{
			String connectString = "jdbc:mysql://" + DBHost + ":" + DBPort + "/" + DBName
					+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
		
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(connectString, DBUser, DBPsw);
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public ResultSet Query( String sql )
	{
		try
		{
			pst = conn.prepareStatement( sql );
			ret = pst.executeQuery();
			return ret;
		}
		catch( Exception e )
		{
			e.printStackTrace();
			return null;
		}
	}
	
	public int Update( String sql )
	{
		try
		{
			pst = conn.prepareStatement( sql );
			int cnt = pst.executeUpdate();
			return cnt;
		}
		catch( Exception e )
		{
			e.printStackTrace();
			return -1;
		}
	}
	
	public void closeConnection()
	{
		try
		{
			conn.close();
			pst.close();
			if( null != ret )
				ret.close();
		}
		catch( Exception e )
		{
			e.printStackTrace();
		}
	}

}
