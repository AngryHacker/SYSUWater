<%@page import="com.sysuwater.biz.Post"%>
<%@page import="com.sysuwater.biz.Plate"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String uid = (String)session.getAttribute("uid");
	Boolean is_login = false;
	if(uid == null)
		response.sendRedirect("login.jsp");
	else
		is_login = true;
	
	String method = request.getMethod();
	if(method.equalsIgnoreCase("POST")) {
		try{
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			String p = request.getParameter("p");
			if(title == null || content == null || p == null){
				throw new Exception("不可为空！");
			}
			
			int pid = Integer.parseInt(p);
			Post post = new Post();
			int post_id = post.createNewPost(pid, title, content, Integer.parseInt(uid));
			
			if(post_id == -1){
				throw new Exception("发帖失败");
			}
			
			response.sendRedirect("detail.jsp?p=" + pid + "&id=" + post_id);
			
		}catch(Exception e){
			e.printStackTrace();
			response.sendRedirect("index.jsp");
		}
	}
	
	// 获得所有版块
	Plate[] plates = null;
	Integer pid = null;
	try{
		plates = Plate.getPlateList();
		String p = request.getParameter("p");
		if(p == null) response.sendRedirect("index.jsp");
		pid = Integer.valueOf(p);
	}catch(Exception e){
		// log
	}
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="static/css/site.css" />
<link rel="stylesheet" type="text/css" href="static/css/detail.css" />
<title>SYSUWater —— 我要发帖</title>
</head>
<body>
<div class="wrap">
	<div class="nav">
		<a href="index.jsp">首页</a>
		<% if(plates != null){
			for(Plate plate:plates){
				if(pid != null && pid == plate.getPid()) {%>
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
			<form action="newpost.jsp" method="post">
				<div class="postform">
					<div class="panel_head" id="editor">我要发帖</div>
					<input type="text" class="ptitle" name="title" id="title" placeholder="帖子标题">
					<textarea class="comment_content" name="content" id="comment_content" placeholder="帖子内容" style="width:640px; height: 300px;"></textarea>
					<div class="clearfix">
						<input type="hidden" name="p" value="<%=pid%>" />
						<input type="submit" class="comment_btn" value="发帖" />
					</div>
				</div>
			</form>
			
		</div>
		
		<div class="right_block  fr">
			<div class="hot">
				<h2 class="tit01">
					<a href="" class="tit01_s">热点</a>
					<a href="" class="a_more fr">更多</a>
				</h2>
				<div class="hot_c clearfix" style="height: auto;">
					<div class="hot_items clearfix">
						<h3 class="tit02">
							<a href="">中大竟出现宇宙草！</a>
						</h3>
						<p class="pmeta01 clearfix">
							<span class="fl">
								作者：<a href="">中大 Din</a>
							</span>
							<a href="">评论</a>
						</p>
            		</div>
            		
            		<div class="hot_items clearfix">
						<h3 class="tit02">
							<a href="">神盾局第三季开播，你猜到剧情了吗</a>
						</h3>
						<p class="pmeta01 clearfix">
							<span class="fl">
								作者：<a href="">中大 Ain</a>
							</span>
							<a href="">评论</a>
						</p>
            		</div>
            		
            		<div class="hot_items clearfix">
						<h3 class="tit02">
							<a href="">2015国赛，评选身边猪一样的队友</a>
						</h3>
						<p class="pmeta01 clearfix">
							<span class="fl">
								作者：<a href="">中大 Bin</a>
							</span>
							<a href="">评论</a>
						</p>
            		</div>

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