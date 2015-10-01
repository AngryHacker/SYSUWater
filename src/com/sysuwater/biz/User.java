package com.sysuwater.biz;

/**
 * 用户
 * @author 
 *
 */
public class User {
	
	/**
	 * 可能更新的字段名称
	 */
	public static final String TYPE_EMAIL = "email";
	public static final String TYPE_SIGNATURE = "signature";
	public static final String TYPE_NICKNAME = "nickname";
	public static final String TYPE_PASSWORD = "password";
	
	/**
	 * 用户 ID
	 */
	private int userID;
	
	/**
	 * 登陆时间
	 */
	private int loginTime;
	
	/**
	 * 性别
	 * 1 - 男 true 0 - 女 false
	 */
	private Boolean sex;
	
	/**
	 * 是否管理员
	 */
	private Boolean isAdmin;
	
	/**
	 * 用户名
	 */
	private String username;
	
	/**
	 * 密码
	 */
	private String password;
	
	/**
	 * 邮箱
	 */
	private String email;
	
	/**
	 * 签名
	 */
	private String signature;
	
	/**
	 * 对应的 getter/setter
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
	 * 用户登陆，失败时 isSuccess 为 false, 其他值不填
	 * password 先 md5 后比较
	 * 
	 * @param username 用户名
	 * @param password 密码
	 * @return
	 */
	public LoginInfo login(String username, String password){
		LoginInfo res = new LoginInfo();
		return res;
	}
	
	/**
	 * 传递进来不空的字段为 username、sex、password、nickname、email
	 * password 先 md5 后进数据库
	 * 
	 * 失败返回 -1, 成功返回 用户 ID
	 * @param newUser
	 * @return
	 */
	public Integer register(User newUser){
		return -1;
	}
	
	/**
	 * 返回用户基本信息
	 * 
	 * @param userID
	 * @return
	 */
	public User getUserInfo(int userID){
		User user = new User();
		return user;
	}
	
	/**
	 * 更新对应字段为 value 值
	 * type 的可能取值为上面定义的 final static 变量
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
		 * 登陆是否成功
		 */
		private Boolean isSuccess;
		
		/**
		 * 用户 ID
		 */
		private int userID;
		
		/**
		 * 是否管理员
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
