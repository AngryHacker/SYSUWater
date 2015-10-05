package com.sysuwater.biz;

import com.sun.org.apache.xml.internal.resolver.helpers.PublicId;
import com.sysuwater.common.*;
import java.sql.ResultSet;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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
	
	public void setLoginTime( long loginTime )
	{
		this.loginTime = loginTime;
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
	public LoginInfo login( String username, String password ) throws Exception
	{
		LoginInfo res = new LoginInfo();
		res.setIsSuccess(false);
		if( null == username || null == password )
		{
			return res;
		}
		
		MySQL m_Mysql = new MySQL();
		try
		{
			m_Mysql.ConnectToMySQL();
			String sql = "select user_id, is_admin, password from users where username='"+username+"'";
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
				long loginTime = new Date().getTime()/1000;
				sql = "update users set login_time="+loginTime+" where user_id="+id;
				m_Mysql.Update(sql);
			}
			ret.close();
		}
		catch( Exception e )
		{
			e.printStackTrace();
			throw new Exception(e);
		}
		m_Mysql.closeConnection();
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
	public Integer register( User newUser ) throws Exception
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
		try
		{
			m_Mysql.ConnectToMySQL();
			String sql = "select * from users where username='" + newUser.username+"'";
			ResultSet ret = m_Mysql.Query(sql);
			if( ret.next() )
				throw new Exception("�ظ��û�����");
			ret.close();
			
			newUser.loginTime = new Date().getTime()/1000;
			sql = "insert into users ( username,sex,nickname,password,is_admin,email,signature,login_time )"
					+ "values('"+newUser.username+"',"+newUser.sex+",'"+newUser.nickname+"','"+pwdMD5+"',"
					+newUser.isAdmin+",'"+newUser.email+"','"+newUser.signature+"',"+newUser.loginTime+")";
			int cnt = m_Mysql.Update( sql );
			if( cnt > 0 )
			{
				sql = "select max(user_id) from users";
				ret = m_Mysql.Query(sql);
				if( ret.next() )
					res = ret.getInt(1);
				ret.close();
			}
		}
		catch( Exception e )
		{
			e.printStackTrace();
			throw new Exception(e);
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
	public static User getUserInfo( int userID ) throws Exception
	{
		User m_User = new User();
		MySQL m_Mysql = new MySQL();
		try
		{
			m_Mysql.ConnectToMySQL();
			String sql = "select * from users where user_id="+userID;
			ResultSet ret = m_Mysql.Query(sql);
			if( ret.next() )
			{
				String username = ret.getString("username");
				String nickname = ret.getString("nickname");
				String email = ret.getString("email");
				String signature = ret.getString("signature");
				boolean isAdmin = ret.getBoolean("is_admin");
				boolean sex = ret.getBoolean("sex");
				long loginTime = ret.getLong("login_time");
				
				m_User.setUsername( username );
				m_User.setNickname(nickname);
				m_User.setEmail(email);
				m_User.setSignature(signature);
				m_User.setNickname(nickname);
				m_User.setSex(sex);
				m_User.setIsAdmin(isAdmin);
				m_User.setLoginTime(loginTime);
			}
			else
			{
				throw new Exception("�޸��û���¼��");
			}
			ret.close();
		}
		catch( Exception e )
		{
			e.printStackTrace();
			throw new Exception(e);
		}
		return m_User;
	}
	
	/**
	 * ���¶�Ӧ�ֶ�Ϊ value ֵ
	 * type �Ŀ���ȡֵΪ���涨��� final static ����
	 * 
	 * @param type
	 * @param value
	 * @return
	 * @throws Exception 
	 */
	public Boolean updateInfo( int userID, String type, String value ) throws Exception
	{
		MySQL m_Mysql = new MySQL();
		try
		{
			m_Mysql.ConnectToMySQL();
			if( 0 == type.compareTo("password") )
			{
				value =  MD5Util.String2MD5( value );
			}
			String sql = "update users set "+type+"='"+value+"' where user_id="+userID;
			m_Mysql.Update(sql);
			m_Mysql.closeConnection();
		}
		catch( Exception e )
		{
			e.printStackTrace();
			throw new Exception(e);
		}
		return true;
	}
	
	public static boolean checkUserName(String userName) {
		String regex = "^[a-z0-9_]{3,15}$";
		Pattern p = Pattern.compile(regex);
		Matcher m = p.matcher(userName);
		return m.matches();
	}
	
	public static boolean checkPassword(String password) {
		String regex = "^[a-z0-9_]{6,15}$";
		Pattern p = Pattern.compile(regex);
		Matcher m = p.matcher(password);
		return m.matches();
	}
	
	public static boolean checkEmail(String email) {
		String regex = "^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
		Pattern p = Pattern.compile(regex);
		Matcher m = p.matcher(email);
		return m.matches();
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
	
	public static void main(String[] args){
		System.out.println(checkUserName("123"));
		System.out.println(checkUserName("123asd"));
		System.out.println(checkUserName("123awe.."));
		
		System.out.println(checkPassword("12345"));
		System.out.println(checkPassword("12345aw"));
		System.out.println(checkPassword("12345...."));
		
		System.out.println(checkEmail("234"));
		System.out.println(checkEmail("234@qq.com"));
		System.out.println(checkEmail("234@mail.qq.com"));
	}

}
