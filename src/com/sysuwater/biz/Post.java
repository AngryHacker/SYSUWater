package com.sysuwater.biz;
//import java.util.*;

import com.sysuwater.biz.User.LoginInfo;

/**
 * 帖子
 * @author 
 *
 */
public class Post {
	
	/**
	 * 帖子 ID
	 */
	private int postID;
	
	/**
	 * 作者 ID
	 */
	private int authorID;
	
	/**
	 * 发帖时间，为 INT
	 */
	private int createTime;
	
	/**
	 * 版块 ID
	 */
	private int pid;
	
	/**
	 * 帖子标题
	 */
	private String title;
	
	/**
	 * 帖子内容
	 */
	private String content;
	
	/**
	 * 作者昵称
	 */
	private String authorName;
	
	/**
	 * 以下为对应 getter/setter
	 * @return
	 */
	public int getPostID(){
		return postID;
	}
	
	public void setPostID(int postID){
		this.postID = postID;
	}
	
	public int getAuthorID() {
		return authorID;
	}
	
	public void setAuthorID(int authorID) {
		this.authorID = authorID;
	}
	
	public int getPid() {
		return pid;
	}
	
	public void setPid(int pid) {
		this.pid = pid;
	}
	
	public int getCreateTime() {
		return createTime;
	}
	
	public void setCreateTime(int createTime){
		this.createTime = createTime;
	}
	
	public String getTitle() {
		return title;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getContent() {
		return content;
	}
	
	public void setContent(String content) {
		this.content = content;
	}
	
	public String getAuthorName(){
		return authorName;
	}
	
	public void setAuthorName(String authorName) {
		this.authorName = authorName;
	}

	/**
	 * 取得帖子列表，返回 POST 数组
	 * 数据域除了 content 其他都要
	 * 
	 * @param pid 版块 ID
	 * 
	 * TODO：后期决定是否制定返回帖子数及范围
	 * @return
	 */
	public Post[] getPostList(int pid){
		
		Post[] post = new Post[2];
		post[0].authorID = 1;
		post[0].authorName = "user1";
		post[0].createTime = 12345678;
		post[0].pid = 1;
		post[0].postID = 1;
		post[0].title = "first post";
		
		post[1].authorID = 2;
		post[1].authorName = "user2";
		post[1].createTime = 12345678;
		post[1].pid = 2;
		post[1].postID = 2;
		post[1].title = "second post";
		
		return post;
	}
	
	/**
	 * 取得对应帖子详情，需要所有数据
	 * 
	 * @param postID 帖子 ID
	 * @return
	 */
	public Post getPostByID(int postID){
		Post post = new Post();
		post.authorID = 1;
		post.authorName = "user1";
		post.createTime = 12345678;
		post.pid = 1;
		post.postID = 1;
		post.title = "first post";
		post.content = "just a test file";
		
		return post;
	}
	
	/**
	 * 发帖
	 * @param pid 版块 ID
	 * @param title 标题
	 * @param content 内容
	 * @param authorID 用户
	 * @return
	 */
	public boolean createrNewPost(int pid, String title, String content, int authorID){
		return true;
	}
	
	/**
	 * 删除对应帖子，把 is_delete 标记为 1
	 * 需要校验 authorID 是否为管理员
	 * 
	 * @param postID 帖子 ID
	 * @param authorID 操作用户 ID
	 * @return
	 */
	public boolean deletePost(int postID, int authorID){
		return true;
	}
	
	/**
	 * 对应函数先在  main中测试
	 * @param args
	 */
	public static void main(String[] args){
		User m_User = new User();
		try
		{
		m_User.setSex(true);
		m_User.setEmail("leeweimian@gmail.com");
		m_User.setIsAdmin(false);
		m_User.setPassword("password");
		m_User.setSignature("signature");
		m_User.setUsername("Leeweimian");
		m_User.setNickname("my_Nickname");
		int res = m_User.registerTmp( m_User );
		System.out.println( res );
		}
		catch( Exception e )
		{
			System.out.println(e);
			//e.printStackTrace();
		}
		/*
		try
		{
		LoginInfo res = m_User.loginTmp( "Leeweimian", "password" );
		System.out.println( "id:" + res.getUserID() + " isSuccess:" + res.IsSuccess() + " isAdmin:" + res.IsAdmin());
		}
		catch( Exception e )
		{
			System.out.println(e);
			//e.printStackTrace();
		}
		*/
		/*
		Plate m_Plate = new Plate();
		Plate plates[] = m_Plate.getPlateList();
		for( int i = 0; i < 4; i ++ )
		{
			System.out.println("id: " + plates[i].getPid()+" name: " + plates[i].getPname() + " introduction :"
					+ plates[i].getIntroduction());
		}
		*/
	}

}
