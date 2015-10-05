<%@page import="com.sysuwater.biz.Post"%>
<%@page import="com.sysuwater.biz.Plate"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String uid = (String)session.getAttribute("uid");
	Boolean is_login = false;
	if(uid != null) is_login = true;
	
	// 获得所有版块
	Plate[] plates = null;
	Post[] hotPosts = null;
	try{
		plates = Plate.getPlateList();
		hotPosts = Post.getTopPost(5);
	}catch(Exception e){
		// log
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="static/css/site.css" />
<title>SYSUWater</title>
</head>
<body>
<div class="wrap">
	<div class="nav">
		<a href="" class="selected">首页</a>
		<% if(plates != null){
			for(Plate plate:plates){ %>
		<a href="post.jsp?p=<%=plate.getPid()%>"><%=plate.getPname()%></a>
		<% }} %>
		<% if(is_login){ %>
		<a href="user.jsp" class="fr personal" >个人中心</a>
		<% }else{ %>
		<a href="login.jsp" class="fr personal" >登录</a>
		<a href="register.jsp" class="fr personal" >注册</a>
		<% } %>
	</div>
	
	<div class="container clearfix">
		<div class="left_block fl">
			<center>我是首页你服不服</center>
		</div>
		
		<div class="right_block  fr">
			<div class="hot">
				<h2 class="tit01">
					<a href="" class="tit01_s">热点</a>
					<a href="" class="a_more fr">更多</a>
				</h2>
				<div class="hot_c clearfix" style="height: auto;">  		
            		<% if(hotPosts != null){
            			for(Post post:hotPosts){%>
            		<div class="hot_items clearfix">
						<h3 class="tit02">
							<a href="detail.jsp?p=<%=post.getPid()%>&id=<%=post.getPostID()%>"><%=post.getTitle()%></a>
						</h3>
						<p class="pmeta01 clearfix">
							<span class="fl">
								作者：<a href="user.jsp?u=<%=post.getAuthorID()%>"><%=post.getAuthorName()%></a>
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