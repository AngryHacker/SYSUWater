package com.sysuwater.biz;
import com.mysql.jdbc.PreparedStatement;
import com.sysuwater.common.*;

import jdk.internal.org.objectweb.asm.commons.StaticInitMerger;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.util.Date;

/**
 * �û�
 * @author
 *
 */
public class User
{	
	/**
	 * ���ܸ��µ��ֶ�����
	 */
	public static final String TYPE_EMAIL = "email";
	public static final String TYPE_SIGNATURE = "signature";
	public static final String TYPE_NICKNAME = "nickname";
	public static final String TYPE_PASSWORD = "password";
	
	/**
	 * �û� ID
	 */
	private int userID;
	
	/**
	 * ��½ʱ��
	 */
	private long loginTime;
	
	/**
	 * �Ա�
	 * 1 - �� true 0 - Ů false
	 */
	private Boolean sex;
	
	/**
	 * �Ƿ����Ա
	 */
	private Boolean isAdmin;
	
	/**
	 * �û���
	 */
	private String username;
	
	/**
	 * �ǳ�
	 */
	private String nickname;
	
	/**
	 * ����
	 */
	private String password;
	
	/**
	 * ����
	 */
	private String email;
	
	/**
	 * ǩ��
	 */
	private String signature;
	
	/**
	 * ��Ӧ�� getter/setter
	 */
	public int getUserID()
	{
		return userID;
	}
	
	public void setUserID(int userID)
	{
		this.userID = userID;
	}
	
	public long getLoginTime()
	{
		return loginTime;
	}
	
	public Boolean isBoy()
	{
		if(this.sex != null)
			return sex;
		return false;
	}
	
	public void setSex(boolean sex)
	{
		this.sex = sex;
	}
	
	public Boolean isAdmin()
	{
		if(this.isAdmin != null)
		{
			return isAdmin;
		}
		return false;
	}
	
	public void setIsAdmin(Boolean isAdmin)
	{
		this.isAdmin = isAdmin;
	}

	public String getUsername()
	{
		return username;
	}

	public void setUsername(String username)
	{
		this.username = username;
	}

	public String getNickname()
	{
		return nickname;
	}
	
	public void setNickname( String nickname )
	{
		this.nickname = nickname;
	}
	
	public String getEmail()
	{
		return email;
	}

	public void setEmail(String email)
	{
		this.email = email;
	}

	public String getSignature()
	{
		return signature;
	}

	public void setSignature(String signature)
	{
		this.signature = signature;
	}

	public String getPassword()
	{
		return password;
	}

	public void setPassword(String password)
	{
		this.password = password;
	}
	
	/**
	 * �û���½��ʧ��ʱ isSuccess Ϊ false, ����ֵ����
	 * password �� md5 ��Ƚ�
	 * 
	 * @param username �û���
	 * @param password ����
	 * @return
	 */
	public LoginInfo login(String username, String password){
		LoginInfo res = new LoginInfo();
		res.setIsAdmin(true);
		res.setIsSuccess(true);
		res.setUserID(1);
		return res;
	}
	
	public LoginInfo loginTmp( String username, String password )
	{
		LoginInfo res = new LoginInfo();
		res.setIsSuccess(false);
		if( null == username || null == password )
		{
			return res;
		}
		MySQL m_Mysql = new MySQL();
		m_Mysql.ConnectToMySQL();
		String sql = "select user_id, is_admin, password from users where username='"+username+"'";
		try
		{
			ResultSet ret = m_Mysql.Query(sql);
			if( ret.next() )
			{
				int id = ret.getInt("user_id");
				boolean isAdmin = ret.getBoolean("is_admin");
				String rightPwd = ret.getString("password");
				final String pwdMD5 =  MD5Util.String2MD5( password );
				if( 0 == pwdMD5.compareTo(rightPwd) )
				{
					res.setIsSuccess(true);
					res.setIsAdmin(isAdmin);
					res.setUserID(id);
				}
			}
		}
		catch( Exception e )
		{
			e.printStackTrace();
		}	
		return res;
	}
	
	/**
	 * ���ݽ������յ��ֶ�Ϊ username��sex��password��nickname��email
	 * password �� md5 ������ݿ�
	 * 
	 * ʧ�ܷ��� -1, �ɹ����� �û� ID
	 * @param newUser
	 * @return
	 */
	public Integer register( User newUser )
	{		
		return 1;
	}
	public Integer registerTmp( User newUser )
	{
		int res = -1;
		/**
		 * �ж��ֶ��Ƿ�Ϊ��, ���򷵻�ʧ��-1;
		 */
		if( null == newUser.username )
			return res;
		if( null == newUser.sex )
			return res;
		if( null == newUser.password )
			return res;
		if( null == newUser.nickname )
			return res;
		if( null == email )
			return res;		
		final String pwdMD5 = MD5Util.String2MD5( newUser.password );
		if( null == pwdMD5 )
			return res;
		
		MySQL m_Mysql = new MySQL();
		m_Mysql.ConnectToMySQL();
		newUser.loginTime = new Date().getTime()/1000;
		String sql = "insert into users ( username,sex,nickname,password,is_admin,email,signature,login_time )"
				+ "values('"+newUser.username+"',"+newUser.sex+",'"+newUser.nickname+"','"+pwdMD5+"',"
				+newUser.isAdmin+",'"+newUser.email+"','"+newUser.signature+"',"+newUser.loginTime+")";
		int cnt = m_Mysql.Update( sql );
		
		if( cnt > 0 )
		{
			try
			{
				sql = "select max(user_id) from users";
				ResultSet ret = m_Mysql.Query(sql);
				if( ret.next() )
					res = ret.getInt(1);
			}
			catch( Exception e )
			{
				e.printStackTrace();
			}
		}
		m_Mysql.closeConnection();
		return res;
	}
	
	/**
	 * �����û�������Ϣ
	 * 
	 * @param userID
	 * @return
	 */
	public User getUserInfo(int userID){
		User user = new User();
		user.email = "2436@qq.com";
		user.isAdmin = true;
		user.userID = 1;
		user.loginTime = 12345678;
		user.sex = true;
		user.signature = "hehe";
		user.username = "ljc";
		return user;
	}
	
	/**
	 * ���¶�Ӧ�ֶ�Ϊ value ֵ
	 * type �Ŀ���ȡֵΪ���涨��� final static ����
	 * 
	 * @param type
	 * @param value
	 * @return
	 */
	public Boolean updateInfo(String type, String value){
		return true;
	}
	
	public class LoginInfo{
		/**
		 * ��½�Ƿ�ɹ�
		 */
		private Boolean isSuccess;
		
		/**
		 * �û� ID
		 */
		private int userID;
		
		/**
		 * �Ƿ����Ա
		 */
		private Boolean isAdmin;
		
		public Boolean IsSuccess() {
			return isSuccess;
		}

		public void setIsSuccess(Boolean isSuccess) {
			this.isSuccess = isSuccess;
		}

		public int getUserID() {
			return userID;
		}

		public void setUserID(int userID) {
			this.userID = userID;
		}

		public Boolean IsAdmin() {
			return isAdmin;
		}

		public void setIsAdmin(Boolean isAdmin) {
			this.isAdmin = isAdmin;
		}
	}

}
