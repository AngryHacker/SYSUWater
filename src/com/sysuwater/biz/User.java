package com.sysuwater.biz;

/**
 * �û�
 * @author 
 *
 */
public class User {
	
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
	private int loginTime;
	
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
	public int getUserID(){
		return userID;
	}
	
	public void setUserID(int userID){
		this.userID = userID;
	}
	
	public int getLoginTime(){
		return loginTime;
	}
	
	public Boolean isBoy(){
		if(this.sex != null)
			return sex;
		return false;
	}
	
	public void setSex(boolean sex){
		this.sex = sex;
	}
	
	public Boolean isAdmin(){
		if(this.isAdmin != null){
			return isAdmin;
		}
		return false;
	}
	
	public void setIsAdmin(Boolean isAdmin){
		this.isAdmin = isAdmin;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getSignature() {
		return signature;
	}

	public void setSignature(String signature) {
		this.signature = signature;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
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
	public Integer register(User newUser){
		return -1;
	}
	
	/**
	 * �����û�������Ϣ
	 * 
	 * @param userID
	 * @return
	 */
	public User getUserInfo(int userID){
		User user = new User();
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
