package com.sysuwater.biz;

/**
 * ����
 * @author
 *
 */
public class Comment {
	
	/**
	 * ���� ID
	 */
	private int comID;
	
	/**
	 * ������������ ID
	 */
	private int postID;
	
	/**
	 * ������ ID
	 */
	private int authorID;
	
	/**
	 * ����ʱ��
	 */
	private int createTime;
	
	/**
	 * ��������
	 */
	private String content;
	
	/**
	 * �������ǳ�
	 */
	private String authorName;
	
	/**
	 * ��Ӧ getter/setter
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
	 * ȡ�����ӵ���������
	 * 
	 * @param postID
	 * @return
	 */
	public Comment[] getCommentsByPostID(int postID){
		Comment[] comments = new Comment[1];
		return comments;
	}
	
	/**
	 * ����������
	 * @param postID ���� ID
	 * @param authorID �û� ID
	 * @param content ��������
	 * @return
	 */
	public boolean createNewComment(int postID, int authorID, String content){
		
		return true;
	}

}
