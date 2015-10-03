package com.sysuwater.biz;

import com.sysuwater.common.*;
import java.sql.*;

/**
 * ���
 * @author
 *
 */
public class Plate {
	
	/**
	 * ��� ID
	 */
	private int pid;
	
	/**
	 * �������
	 */
	private String pname;
	
	/**
	 * ������
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
	 * ��ȡ���а��
	 * @return
	 * @throws Exception 
	 */
	public static Plate[] getPlateList() throws Exception
	{
		MySQL m_Mysql = new MySQL();
		try
		{
			m_Mysql.ConnectToMySQL();		
			String sql = "select * from plate";
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
	 * �����°�飬��ʱ��д
	 * 
	 * @param pname
	 * @return
	 */
	public boolean createNewPlate(String pname){
		return true;
	}

}
