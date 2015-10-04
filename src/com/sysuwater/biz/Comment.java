package com.sysuwater.biz;

import com.sysuwater.common.MySQL;
import java.sql.*;
import java.util.Date;

/**
 * 评论
 * @author
 *
 */
public class Comment {
	
	/**
	 * 评论 ID
	 */
	private int comID;
	
	/**
	 * 评论所属帖子 ID
	 */
	private int postID;
	
	/**
	 * 评论者 ID
	 */
	private int authorID;
	
	/**
	 * 评论时间
	 */
	private long createTime;
	
	/**
	 * 评论内容
	 */
	private String content;
	
	/**
	 * 评论者昵称
	 */
	private String authorName;
	
	/**
	 * 对应 getter/setter
	 */
	public int getComID(){
		return comID;
	}
	
	public void setComID(int comID){
		this.comID = comID;
	}
	
	public int getPostID(){
		return postID;
	}
	
	public void setPostID(int postID){
		this.postID = postID;
	}
	
	public int getAuthorID(){
		return authorID;
	}
	
	public void setAuthorID(int authorID){
		this.authorID = authorID;
	}
	
	public long getCreateTime() {
		return createTime;
	}
	
	public void setCreateTime(long createTime){
		this.createTime = createTime;
	}
	
	public String getAuthorName(){
		return authorName;
	}
	
	public void setAuthorName(String authorName) {
		this.authorName = authorName;
	}
	
	public String getContent() {
		return content;
	}
	
	public void setContent(String content) {
		this.content = content;
	}
	
	/**
	 * 取得帖子的所有评论
	 * 
	 * @param postID
	 * @return
	 * @throws Exception 
	 */
	public static Comment[] getCommentsByPostID(int postID) throws Exception
	{
		MySQL m_Mysql = new MySQL();
		try
		{
			m_Mysql.ConnectToMySQL();
			String sql = "select * from comments left join users on author_id=user_id where post_id="+postID;
			ResultSet ret = m_Mysql.Query(sql);
			ret.last();
			int size = ret.getRow();
			ret.beforeFirst();
			Comment [] comments = new Comment[size];
			
			int index=0;
			while(ret.next())
			{
				comments[index] = new Comment();
				int comId = ret.getInt("com_id");
				String content = ret.getString("content");
				long createTime = ret.getLong("create_time");
				int authorId = ret.getInt("author_id");
				String authorName = ret.getString("nickname");
				
				comments[index].setComID(comId);
				comments[index].setContent(content);
				comments[index].setPostID(postID);
				comments[index].setAuthorID(authorId);
				comments[index].setCreateTime(createTime);
				comments[index].setAuthorName(authorName);
				index++;
			}
			m_Mysql.closeConnection();
			return comments;
		}
		catch( Exception e )
		{
			e.printStackTrace();
			throw new Exception(e);
		}
	}
	
	/**
	 * 发表新评论
	 * @param postID 帖子 ID
	 * @param authorID 用户 ID
	 * @param content 评论内容
	 * @return
	 * @throws Exception 
	 */
	public static boolean createNewComment(int postID, int authorID, String content) throws Exception
	{
		MySQL m_Mysql = new MySQL();
		try
		{
			m_Mysql.ConnectToMySQL();
			long createTime = new Date().getTime()/1000;
			String sql = "insert into comments(post_id,author_id,content,create_time)values("
					+postID+","+authorID+",'"+content+"',"+createTime+")";
			m_Mysql.Update(sql);
		}
		catch( Exception e )
		{
			e.printStackTrace();
			throw new Exception(e);
		}
		m_Mysql.closeConnection();
		return true;
	}

}
