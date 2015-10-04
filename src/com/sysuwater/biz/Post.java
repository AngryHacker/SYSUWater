package com.sysuwater.biz;

import java.sql.ResultSet;
import java.util.Date;

import com.sysuwater.common.MySQL;

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
	private long createTime;
	
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
	 * 访问数
	 */
	private int visit;
	
	/**
	 * 评论数
	 */
	private int commentNum;

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

	public int getCommentNum()
	{
		return commentNum;
	}
	
	public void setCommentNum( int commentNum )
	{
		this.commentNum = commentNum;
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
	public Post[] getPostList(int pid)
	{	
		Post[] post = new Post[2];
		post[0] = new Post();
		post[0].authorID = 1;
		post[0].authorName = "user1";
		post[0].createTime = 12345678;
		post[0].pid = 1;
		post[0].postID = 1;
		post[0].title = "first post";
		
		post[1] = new Post();
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
			String sql = "select *, count(comments.post_id) as commentNum from post left join "
					+ "users on author_id = user_id left join comments on post.post_id=comments.post_id "
					+ "where p_id="+pid+" and is_delete=0 group by post.post_id";
			ResultSet ret = m_Mysql.Query(sql);
			ret.last();
			int size = ret.getRow();
			if( size <= 0 )
				throw new Exception("无该板块ID！");
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
				String authodName = ret.getString("nickname");
				int commentNum = ret.getInt("commentNum");
				
				posts[index].setAuthorID(authorId);
				posts[index].setAuthorName(authodName);
				posts[index].setCreateTime(createTime);
				posts[index].setPostID(postId);
				posts[index].setPid(pid);
				posts[index].setTitle(title);
				posts[index].setVisit(visit);
				posts[index].setCommentNum(commentNum);
				index++;
			}
			for( int i = 0; i < posts.length; i++ )
			{
				int newVisit = posts[i].getVisit()+1;
				sql = "update post set visit="+newVisit+" where post_id="+posts[i].getPostID();
				m_Mysql.Update(sql);
			}
			m_Mysql.closeConnection();
			return posts;
		}
		catch( Exception e )
		{
			e.printStackTrace();
			throw new Exception(e);
		}
	}
	
	/**
	 * 取得对应帖子详情，需要所有数据
	 * 要把 visit 加 1
	 * 
	 * @param postID 帖子 ID
	 * @return
	 */
	public static Post getPostByID( int postID ) throws Exception
	{
		Post post = new Post();
		MySQL m_Mysql = new MySQL();
		try
		{
			m_Mysql.ConnectToMySQL();
			String sql = "select *, count(comments.post_id) as commentNum from post left join "
					+ "users on author_id = user_id left join comments on post.post_id=comments.post_id "
					+ "where post.post_id="+postID+" and is_delete=0 group by post.post_id";
			ResultSet ret = m_Mysql.Query(sql);
			if( ret.next() )
			{
				int pid= ret.getInt("p_id");
				String title = ret.getString("title");
				String content = ret.getString("content");
				int visit = ret.getInt("visit");
				long createTime = ret.getLong("create_time");
				int authorId = ret.getInt("author_id");
				String authodName = ret.getString("nickname");
				int commentNum = ret.getInt("commentNum");
				
				post.setAuthorID(authorId);
				post.setAuthorName(authodName);
				post.setCreateTime(createTime);
				post.setPostID(postID);
				post.setPid(pid);
				post.setTitle(title);
				post.setContent(content);
				post.setVisit(visit);
				post.setCommentNum(commentNum);
			}
			else
			{
				throw new Exception("无该Post ID！");
			}
			int newVisit = post.getVisit()+1;
			sql = "update post set visit="+newVisit+" where post_id="+post.getPostID();
			m_Mysql.Update(sql);
			m_Mysql.closeConnection();
			return post;
		}
		catch( Exception e )
		{
			e.printStackTrace();
			throw new Exception(e);
		}
	}
	
	/**
	 * 发帖
	 * @param pid 版块 ID
	 * @param title 标题
	 * @param content 内容
	 * @param authorID 用户
	 * @return
	 * @throws Exception 
	 */
	public int createNewPost(int pid, String title, String content, int authorID) throws Exception
	{
		int res = -1;
		MySQL m_Mysql = new MySQL();
		try
		{
			m_Mysql.ConnectToMySQL();
			long createTime = new Date().getTime()/1000;
			String sql = "insert into post(title,content,create_time,author_id,p_id) values('"
					+title+"','"+content+"',"+createTime+","+authorID+","+pid+")";
			int cnt = m_Mysql.Update(sql);
			if( cnt > 0 )
			{
				sql = "select max(post_id) as id from post";
				ResultSet ret = m_Mysql.Query(sql);
				if( ret.next() )
				{
					res = ret.getInt("id");
				}
				ret.close();
			}
		}
		catch( Exception e )
		{
			e.printStackTrace();
			throw new Exception(e);
		}
		return res;
	}
	
	/**
	 * 删除对应帖子，把 is_delete 标记为 1
	 * 需要校验 authorID 是否为管理员
	 * 
	 * @param postID 帖子 ID
	 * @param authorID 操作用户 ID
	 * @return
	 * @throws Exception 
	 */
	public boolean deletePost(int postID, int authorID) throws Exception
	{
		MySQL m_Mysql = new MySQL();
		try
		{
			m_Mysql.ConnectToMySQL();
			String sql = "select is_admin from users where user_id="+authorID;
			ResultSet ret = m_Mysql.Query(sql);
			int isAdmin = 0;
			if( ret.next() )
			{
				isAdmin = ret.getInt("is_admin");
			}
			else
			{
				throw new Exception("查无该author ID");
			}
			if( 1 == isAdmin )
			{
				sql = "update post set is_delete=1 where post_id="+postID;
				int cnt = m_Mysql.Update(sql);
				if( cnt <= 0 )
					return false;
			}
			else
			{
				throw new Exception("该用户不是管理员！");
			}
		}
		catch( Exception e )
		{
			e.printStackTrace();
			throw new Exception(e);
		}
		return true;
	}
	
	/**
	 * 获取评论数前N位的帖子
	 * @param args
	 * @throws Exception 
	 */
	public Post[] getTopPost( int topN ) throws Exception
	{
		MySQL m_Mysql = new MySQL();
		try
		{
			m_Mysql.ConnectToMySQL();
			String sql = "select *, count(comments.post_id) as commentNum from post left join "
					+ "users on author_id = user_id left join comments on post.post_id=comments.post_id "
					+ "where is_delete=0 group by post.post_id order by commentNum desc limit 0,"+topN;
			ResultSet ret = m_Mysql.Query(sql);
			ret.last();
			int size = ret.getRow();
			ret.beforeFirst();
			Post [] posts = new Post[size];
			int index = 0;
			while( ret.next() )
			{
				posts[index] = new Post();
				int postId= ret.getInt("post_id");
				String title = ret.getString("title");
				int visit = ret.getInt("visit");
				long createTime = ret.getLong("create_time");
				int authorId = ret.getInt("author_id");
				String authodName = ret.getString("username");
				int commentNum = ret.getInt("commentNum");
				
				posts[index].setAuthorID(authorId);
				posts[index].setAuthorName(authodName);
				posts[index].setCreateTime(createTime);
				posts[index].setPostID(postId);
				posts[index].setPid(pid);
				posts[index].setTitle(title);
				posts[index].setVisit(visit);
				posts[index].setCommentNum(commentNum);
				index++;
			}
			for( int i = 0; i < posts.length; i++ )
			{
				int newVisit = posts[i].getVisit()+1;
				sql = "update post set visit="+newVisit+" where post_id="+posts[i].getPostID();
				m_Mysql.Update(sql);
			}
			m_Mysql.closeConnection();
			return posts;
		}
		catch( Exception e )
		{
			e.printStackTrace();
			throw new Exception(e);
		}
	}
	
	/**
	 * 对应函数先在  main中测试
	 * @param args
	 */
	public static void main(String[] args)
	{	
		/*
		try
		{
			Comment [] comments = new Comment().getCommentsByPostID(1);
			for( int i = 0; i < comments.length; i++ )
			{
				System.out.println("com_id: "+comments[i].getComID()+" comtent: "+comments[i].getContent()+
						" create_time: " + comments[i].getCreateTime()+" author_id: "+comments[i].getAuthorID()
						+" author_name: "+comments[i].getAuthorName()+" post_id: " + comments[i].getPostID());
			}
		}
		*/
		/*
		try
		{
			Comment comment = new Comment();
			boolean res = comment.createNewComment(1, 2, "test_insert");
			System.out.println(res);
		}
		catch( Exception e )
		{
			System.out.println(e);
		}
		
		Post postTmp = new Post();
		
		try
		{
			int res = postTmp.createNewPost(1, "title", "test_content", 2);
			System.out.println(res);
		}
		
		catch( Exception e )
		{
			System.out.println(e);
		}
		*/
		/*
		Post postTmp = new Post();
		try
		{
			Post [] posts = postTmp.getTopPost(3);
			for( int i = 0; i < posts.length; i ++ )
			{
				System.out.println("postId: "+posts[i].getPostID()+" pid: "+posts[i].getPid()+
						" authorId: "+posts[i].getAuthorID()+" authorName: "+posts[i].getAuthorName() + " title:"
						+ posts[i].getTitle() + " createTime: "+posts[i].getCreateTime() + 
						" visit: " + posts[i].getVisit() + " comment_number: " + posts[i].getCommentNum());
			}
		}
		*/
		User newUser = new User();
		try
		{
			newUser.updateInfo(2, "nickname", "newNickname");
		}
		catch( Exception e )
		{
			System.out.println(e);
		}
		
		/*
		try
		{
			Post post = postTmp.getPostByID(8);
			System.out.println("postId: "+post.getPostID()+" pid: "+post.getPid()+
					" authorId: "+post.getAuthorID()+" authorName: "+post.getAuthorName() + " title:"
					+ post.getTitle() + " createTime: "+post.getCreateTime() + 
					" visit: " + post.getVisit() + " comment_number: " + post.getCommentNum());
		}
		catch( Exception e )
		{
			System.out.println(e);
		}
		*/
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
