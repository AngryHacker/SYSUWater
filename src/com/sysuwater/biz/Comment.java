package com.sysuwater.biz;

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
	private int createTime;
	
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
	
	public int getCreateTime() {
		return createTime;
	}
	
	public void setCreateTime(int createTime){
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
	 */
	public Comment[] getCommentsByPostID(int postID){
		Comment[] comments = new Comment[1];
		return comments;
	}
	
	/**
	 * 发表新评论
	 * @param postID 帖子 ID
	 * @param authorID 用户 ID
	 * @param content 评论内容
	 * @return
	 */
	public boolean createNewComment(int postID, int authorID, String content){
		
		return true;
	}

}
