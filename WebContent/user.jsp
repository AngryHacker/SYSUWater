<%@page import="com.sun.swing.internal.plaf.metal.resources.metal"%>
<%@page import="com.sysuwater.biz.User"%>
<%@page import="com.sysuwater.biz.Post"%>
<%@page import="com.sysuwater.biz.Plate"%>
<%@page import="com.sysuwater.common.Time"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	// get user id
	String uid = (String)session.getAttribute("uid");
	if(uid == null){
		response.sendRedirect("login.jsp");
		return;
	}
	
	boolean is_me = true;
	
	if(request.getParameter("u") != null && request.getParameter("u") != uid){
		uid = request.getParameter("u");
		is_me = false;
	}
	
	// logout
	String r = request.getParameter("r");
	if(r != null && "logout".equals(r)){
		session.invalidate();
		response.sendRedirect("index.jsp");
		return;
	}
	
	Plate[] plates = null;
	User me = null;
	try{
		plates = Plate.getPlateList();
		me = User.getUserInfo(Integer.parseInt(uid));
		if(me == null){
			response.sendRedirect("index.jsp");
			return;
		}
		if(me.getSignature() == null || me.getSignature().equals("") || me.getSignature().equals("null"))
			me.setSignature("还没有留下任何签名哦~");
		
	}catch(Exception e){
		// log
	}
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="static/css/site.css" />
<link rel="stylesheet" type="text/css" href="static/css/user.css" />
<title>SYSUWater —— 个人中心</title>
</head>
<body>
<div class="wrap">
	<div class="nav">
		<a href="index.jsp">首页</a>
		<% if(plates != null){
			for(Plate plate:plates){%>
		<a href="post.jsp?p=<%=plate.getPid()%>"><%=plate.getPname()%></a>
		<% }} %>
		<% if(is_me){ %>
		<a href="user.jsp?r=logout" class="fr personal" >注销</a>
		<a href="updatepsw.jsp" class="fr personal" >修改密码</a>
		<% }else{ %>
		<a href="user.jsp" class="fr personal" >个人中心</a>
		<% } %>
	</div>
	
	<div class="container clearfix">
		<div class="left_block fl">
		
			<div class="zm-profile-section-wrap zm-profile-details-wrap">
				<div class="zm-profile-section-head">
					<span class="zm-profile-section-name"><%=me.getNickname()%> &nbsp;的详细资料</span>
					<% if(is_me){ %>
					<a class="zg-right zg-link-litblue-normal zm-profile-answer-page-return" href="updatesig.jsp">修改资料</a>
					<% } %>
				</div>
				<div class="zm-profile-section-list zm-profile-details">
				
					<div class="zm-profile-module zg-clear">
						<h3><i class="zm-profile-icon zm-profile-icon-location"></i> <span>用户名</span></h3>
						<div class="zm-profile-module-desc">
							<ul class="zm-profile-details-items">
								<li><div class="zm-profile-details-item-detail"><%=me.getUsername()%></div></li>
							</ul>
						</div>
					</div>
					
					<div class="zm-profile-module zg-clear">
						<h3><i class="zm-profile-icon zm-profile-icon-location"></i> <span>昵称</span></h3>
						<div class="zm-profile-module-desc">
							<ul class="zm-profile-details-items">
								<li><div class="zm-profile-details-item-detail"><%=me.getNickname()%></div></li>
							</ul>
						</div>
					</div>
					
					<div class="zm-profile-module zg-clear">
						<h3><i class="zm-profile-icon zm-profile-icon-location"></i> <span>性别</span></h3>
						<div class="zm-profile-module-desc">
							<ul class="zm-profile-details-items">
								<li><div class="zm-profile-details-item-detail"><% if(me.isBoy()) out.print("男"); else out.print("女"); %></div></li>
							</ul>
						</div>
					</div>
					
					<div class="zm-profile-module zg-clear">
						<% if(is_me){ %>
						<h3><i class="zm-profile-icon zm-profile-icon-location"></i> <span>我的邮箱</span></h3>
						<% }else{ %>
						<h3><i class="zm-profile-icon zm-profile-icon-location"></i> <span>他的邮箱</span></h3>
						<% } %>
						<div class="zm-profile-module-desc">
							<ul class="zm-profile-details-items">
								<li><div class="zm-profile-details-item-detail"><%=me.getEmail()%></div></li>
							</ul>
						</div>
					</div>
					
					<div class="zm-profile-module zg-clear">
						<% if(is_me){ %>
						<h3><i class="zm-profile-icon zm-profile-icon-location"></i> <span>我的签名</span></h3>
						<% }else{ %>
						<h3><i class="zm-profile-icon zm-profile-icon-location"></i> <span>他的签名</span></h3>
						<% } %>
						<div class="zm-profile-module-desc">
							<ul class="zm-profile-details-items">
								<li><div class="zm-profile-details-item-detail"><%=me.getSignature()%></div></li>
							</ul>
						</div>
					</div>
					
					<div class="zm-profile-module zg-clear">
						<h3><i class="zm-profile-icon zm-profile-icon-location"></i> <span>最近登录时间</span></h3>
						<div class="zm-profile-module-desc">
							<ul class="zm-profile-details-items">
								<li><div class="zm-profile-details-item-detail"><%=Time.convertFromIntToString(me.getLoginTime(), "yyyy-MM-dd HH:mm:ss") %></div></li>
							</ul>
						</div>
					</div>
					
				</div>
			</div>
			
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