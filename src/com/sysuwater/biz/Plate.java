package com.sysuwater.biz;

import com.sysuwater.common.*;
import java.sql.*;

/**
 * 版块
 * @author
 *
 */
public class Plate {
	
	/**
	 * 版块 ID
	 */
	private int pid;
	
	/**
	 * 版块名称
	 */
	private String pname;
	
	/**
	 * 版块介绍
	 */
	private String introduction;
	
	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

	public int getPid(){
		return pid;
	}
	
	public void setPid(int pid){
		this.pid = pid;
	}
	
	public String getPname(){
		return pname;
	}
	
	public void setPname(String pname){
		this.pname = pname;
	}
	
	/**
	 * 获取所有版块
	 * @return
	 * @throws Exception 
	 */
	public Plate[] getPlateList() throws Exception
	{
		MySQL m_Mysql = new MySQL();
		m_Mysql.ConnectToMySQL();
		if( null == m_Mysql.getConnection() )
		{
			throw new Exception("连接出错！");
		}
		
		String sql = "select * from plate";
		try
		{
			ResultSet ret = m_Mysql.Query(sql);
			ret.last();
			int size = ret.getRow();
			Plate[] plates = new Plate[size];
			ret.beforeFirst();
			int i = 0;
			while( ret.next() )
			{
				int pid = ret.getInt( "p_id" );
				String pname = ret.getString( "pname" );
				String intro = ret.getString( "introduction" );
				plates[i] = new Plate();
				plates[i].setPid( pid );
				plates[i].setPname( pname );
				plates[i].setIntroduction( intro );
				i++;
			}
			m_Mysql.closeConnection();
			return plates;
		}
		catch( Exception e )
		{
			e.printStackTrace();
			m_Mysql.closeConnection();
			return null;
		}
	}
	
	/**
	 * 创建新版块，暂时不写
	 * 
	 * @param pname
	 * @return
	 */
	public boolean createNewPlate(String pname){
		return true;
	}

}
