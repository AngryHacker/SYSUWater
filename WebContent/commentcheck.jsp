<%@page import="com.sysuwater.biz.Comment"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String uid = (String)session.getAttribute("uid");
	Boolean is_login = false;
	if(uid == null) response.sendRedirect("login.jsp");

	try{
		String p = request.getParameter("pid");
		if(p == null) throw new Exception("pid 不可为 NULL");
		Integer pid = Integer.valueOf(p);
		
		String postIDString = request.getParameter("post_id");
		if(postIDString == null) throw new Exception("postID 不可为 NULL");
		Integer post_id = Integer.valueOf(postIDString);
		
		String content= request.getParameter("comment_content");
		if(content == null) throw new Exception("评论内容不可为空");
		
		content = content.replaceAll(" ","&nbsp;");
		content = content.replaceAll("\r\n","<br/>");
		content = content.replaceAll("\n","<br/>");
		
		Boolean success = Comment.createNewComment(post_id, Integer.parseInt(uid), content);
		if(!success) {
			throw new Exception("评论失败");
		}
		
		response.sendRedirect("detail.jsp?p=" + pid + "&id=" + post_id);
	}catch(Exception e){
		// log
		e.printStackTrace();
		response.sendRedirect("index.jsp");
	}
	
%>