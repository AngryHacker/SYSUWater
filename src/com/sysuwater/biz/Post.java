package com.sysuwater.biz;

import com.sysuwater.common.*;
import java.sql.*;

import com.sysuwater.biz.User.LoginInfo;

/**
 * ����
 * @author 
 *
 */
public class Post {
	
	/**
	 * ���� ID
	 */
	private int postID;
	
	/**
	 * ���� ID
	 */
	private int authorID;
	
	/**
	 * ����ʱ�䣬Ϊ INT
	 */
	private long createTime;
	
	/**
	 * ��� ID
	 */
	private int pid;
	
	/**
	 * ���ӱ���
	 */
	private String title;
	
	/**
	 * ��������
	 */
	private String content;
	
	/**
	 * �����ǳ�
	 */
	private String authorName;
	
	/**
	 * ������
	 */
	private int visit;
	

	/**
	 * ����Ϊ��Ӧ getter/setter
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
	
	public long getCreateTime() {
		return createTime;
	}
	
	public void setCreateTime(long createTime){
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
		
	public int getVisit() {
		return visit;
	}

	public void setVisit(int visit) {
		this.visit = visit;
	}


	/**
	 * ȡ�������б����� POST ����
	 * ��������� content ������Ҫ
	 * 
	 * @param pid ��� ID
	 * 
	 * TODO�����ھ����Ƿ��ƶ���������������Χ
	 * @return
	 */
	public Post[] getPostList(int pid)
	{	
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
	
	public Post[] getPostListTmp( int pid ) throws Exception
	{
		MySQL m_Mysql = new MySQL();
		try
		{
			m_Mysql.ConnectToMySQL();
			String sql = "select * from post left join users on post.author_id = users.user_id where p_id="+pid
					+" and is_delete=0";
			ResultSet ret = m_Mysql.Query(sql);
			ret.last();
			int size = ret.getRow();
			if( size <= 0 )
				throw new Exception("�޸ð��ID��");
			ret.beforeFirst();
			Post [] posts = new Post[size];
			
			int index = 0;
			while(ret.next())
			{
				posts[index] = new Post();
				int postId= ret.getInt("post_id");
				String title = ret.getString("title");
				int visit = ret.getInt("visit");
				long createTime = ret.getLong("create_time");
				int authorId = ret.getInt("author_id");
				String authodName = ret.getString("username");
				
				posts[index].setAuthorID(authorId);
				posts[index].setAuthorName(authodName);
				posts[index].setCreateTime(createTime);
				posts[index].setPostID(postId);
				posts[index].setPid(pid);
				posts[index].setTitle(title);
				posts[index].setVisit(visit);
				index++;
			}
			return posts;
		}
		catch( Exception e )
		{
			e.printStackTrace();
			throw new Exception(e);
		}
	}
	
	/**
	 * ȡ�ö�Ӧ�������飬��Ҫ��������
	 * Ҫ�� visit �� 1
	 * 
	 * @param postID ���� ID
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
	 * ����
	 * @param pid ��� ID
	 * @param title ����
	 * @param content ����
	 * @param authorID �û�
	 * @return
	 */
	public boolean createrNewPost(int pid, String title, String content, int authorID){
		return true;
	}
	
	/**
	 * ɾ����Ӧ���ӣ��� is_delete ���Ϊ 1
	 * ��ҪУ�� authorID �Ƿ�Ϊ����Ա
	 * 
	 * @param postID ���� ID
	 * @param authorID �����û� ID
	 * @return
	 */
	public boolean deletePost(int postID, int authorID){
		return true;
	}
	
	/**
	 * ��Ӧ��������  main�в���
	 * @param args
	 */
	public static void main(String[] args){
		Post post = new Post();
		try
		{
			Post[] posts = post.getPostListTmp(1);
			for( int i = 0; i < posts.length; i ++ )
			{
				System.out.println("postId: "+posts[i].getPostID()+" pid: "+posts[i].getPid()+
						" authorId: "+posts[i].getAuthorID()+" authorName: "+posts[i].getAuthorName() + " title:"
						+ posts[i].getTitle() + " createTime: "+posts[i].getCreateTime() + " visit: " + posts[i].getVisit());
			}
		}
		catch( Exception e )
		{
			System.out.println(e);
		}
		/*
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
		*/
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
