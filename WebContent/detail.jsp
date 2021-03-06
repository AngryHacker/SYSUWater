<%@page import="com.sysuwater.biz.Comment"%>
<%@page import="com.sysuwater.common.Time"%>
<%@page import="com.sysuwater.biz.Post"%>
<%@page import="com.sysuwater.biz.Plate"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String uid = (String)session.getAttribute("uid");
	Boolean is_login = false;
	if(uid == null){
		response.sendRedirect("login.jsp");
		return;
	}
	else
		is_login = true;
	
	Boolean is_admin = (Boolean)session.getAttribute("isAdmin");
	if(is_admin == null) is_admin = false;
	
	// 获得所有版块
	Plate[] plates = null;
	Post[] hotPosts = null;
	Integer pid = null;
	Integer postID = null;
	Post post = null;
	Comment[] comments = null;
	
	try{
		plates = Plate.getPlateList();
		hotPosts = Post.getTopPost(5);
		String p = request.getParameter("p");
		if(p == null){
			response.sendRedirect("index.jsp");
			return;
		}
		pid = Integer.valueOf(p);
		
		String postIdString = request.getParameter("id");
		if(postIdString == null){
			response.sendRedirect("post.jsp?p="+pid);
			return;
		}
		postID = Integer.valueOf(postIdString);
		
		String r = request.getParameter("r");
		if("delete".equals(r) && is_admin){
			boolean isSuccess = Post.deletePost(postID, Integer.parseInt(uid));
			if(isSuccess){
				response.sendRedirect("post.jsp?p=" + pid);
				return;
			}
		}
		post = Post.getPostByID(postID);
		
		comments = Comment.getCommentsByPostID(postID);
		
	}catch(Exception e){
		// log
	}
	
	if(post == null) response.sendRedirect("index.jsp");
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="static/css/site.css" />
<link rel="stylesheet" type="text/css" href="static/css/detail.css" />
<title>SYSUWater</title>
</head>
<body>
<div class="wrap">
	<div class="nav">
		<a href="index.jsp">首页</a>
		<% if(plates != null){
			for(Plate plate:plates){
				if(pid == plate.getPid()) {%>
		<a href="post.jsp?p=<%=plate.getPid()%>" class="selected"><%=plate.getPname()%></a>
		<% }else{ %>
		<a href="post.jsp?p=<%=plate.getPid()%>"><%=plate.getPname()%></a>
		<% }}} %>
		<% if(is_login){ %>
		<a href="user.jsp" class="fr personal" >个人中心</a>
		<% }else{ %>
		<a href="login.jsp" class="fr personal" >登录</a>
		<a href="register.jsp" class="fr personal" >注册</a>
		<% } %>
	</div>
	
	<div class="container clearfix">
		<div class="left_block fl tie_bd" id="tie_bd">
			<div class="tie-item tie-first-item">
				<div class="tie-con">
					<div class="tie-con-hd">
						<div class="tie-con-hd-panel">
							<a href="user.jsp?id=<%=post.getAuthorID()%>"><%=post.getAuthorName()%></a>
							<span class="time" id="floor-$item.floor">楼主 &nbsp;&nbsp; <%=Time.convertFromIntToString(post.getCreateTime(),"yyyy-MM-dd HH:mm:ss")%></span>
							<span class="time">阅读：<%=post.getVisit()%></span>
						</div>
						<h2 class="tie-con-hd-title js-tietitle" style="color:#444;"><%=post.getTitle()%></h2>
					</div>
					<div class="tie-con-bd clearfix">
                    	<div class="tie-content"><%=post.getContent()%></div>
               		</div>
               		<div class="tie-con-manange">
               			<div class="tie-con-manange-panel">
                        	<a href="#editor">回复本帖</a>
                        	<% if(is_admin){ %>
                        	<a href="detail.jsp?r=delete&p=<%=pid%>&id=<%=postID %>">删除帖子</a>
                        	<% } %>
                    	</div>
               		</div>
				</div>
			</div>
			
			<% if(comments != null){
				for(int i = 0;i < comments.length;i++){
				%>
			<div class="tie-item">
				<div class="tie-con">
					<div class="tie-con-hd tie-con-hd-sub">
						<div class="tie-con-hd-panel tie-con-hd-panel-sub">
							<a href="user.jsp?id=<%=comments[i].getAuthorID()%>"><%=comments[i].getAuthorName()%></a>
							<span class="time" id="floor-$item.floor"><%out.print(i+2);%>楼 &nbsp;&nbsp; <%=Time.convertFromIntToString(comments[i].getCreateTime(),"yyyy-MM-dd HH:mm:ss")%></span>
						</div>
					</div>
					<div class="tie-con-bd clearfix">
                    	<div class="tie-content"><%=comments[i].getContent()%></div>
               		</div>
				</div>
			</div>
			<% }} %>
			
			<form action="commentcheck.jsp" method="post">
				<div class="commentform">
					<div class="panel_head" id="editor">发表评论</div>
					
					<textarea class="comment_content" name="comment_content" id="comment_content" style="width: 500px; height: 200px;"></textarea>
					<div class="clearfix">
						<input type="hidden" name="post_id" value="<%=postID%>" />
						<input type="hidden" name="pid" value="<%=pid%>" />
						<input type="submit" class="comment_btn" value="回复本帖" />
					</div>
				</div>
			</form>
			
		</div>
		
		<div class="right_block  fr">
			<div class="board-write">
				<div class="dd-window">
            		<a class="top" href="newpost.jsp?p=<%=pid%>"><b>发 帖</b></a>
	       		</div>
	   		</div>
	   		
			<div class="hot">
				<h2 class="tit01">
					<a href="" class="tit01_s">热点</a>
					<a href="" class="a_more fr">更多</a>
				</h2>
				<div class="hot_c clearfix" style="height: auto;">
					<% if(hotPosts != null){
            			for(Post tmpPost:hotPosts){%>
            		<div class="hot_items clearfix">
						<h3 class="tit02">
							<a href="detail.jsp?p=<%=tmpPost.getPid()%>&id=<%=tmpPost.getPostID()%>"><%=tmpPost.getTitle()%></a>
						</h3>
						<p class="pmeta01 clearfix">
							<span class="fl">
								作者：<a href="user.jsp?u=<%=tmpPost.getAuthorID()%>"><%=tmpPost.getAuthorName()%></a>
							</span>
							<a href="">评论</a>
						</p>
            		</div>
            		<% }} %>

				</div>
			</div>
		</div>
	</div>
	<div class="footer clearfix">
		<p>SYSUWater —— 我们是中大论坛爱好者。这里是情怀的聚集地。</p>
		<p>我们坚信纯文字便是最美的，文字是最水的力量</p>
		<p>Hope you like it</p>
	</div>
</div>
</body>
</html>