package com.sysuwater.common;

import java.sql.*;

public class MySQL
{
	
	public final static String DBName = "SYSUWater";
	
	public final static String DBHost = "127.0.0.1";
	
	public final static String DBPort = "3306";
	
	public final static String DBUser = "test";
	
	public final static String DBPsw = "123456";
	
	private static Connection conn = null;
	
	private static PreparedStatement pst = null;
	
	private static ResultSet ret = null;
	
	/**
	 * ��ȡ�µ�  MySQL ����
	 * @return
	 * @throws Exception 
	 */
	public void ConnectToMySQL() throws Exception
	{
		try
		{
			String connectString = "jdbc:mysql://" + DBHost + ":" + DBPort + "/" + DBName
					+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
		
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(connectString, DBUser, DBPsw);
			if( null == conn )
				throw new Exception("�������ݿ����");
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
			throw new Exception(e);
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
	
	public int Update( String sql ) throws Exception
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
			throw new Exception(e);
		}
	}
	
	public void closeConnection() throws Exception
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
			throw new Exception(e);
		}
	}

}
