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
	
	Plate[] plates = null;
	Post[] hotPosts = null;
	User me = null;
	try{
		plates = Plate.getPlateList();
		hotPosts = Post.getTopPost(5);
		me = User.getUserInfo(Integer.parseInt(uid));
		if(me == null){
			response.sendRedirect("index.jsp");
			return;
		}
		
		String method = request.getMethod();
		if(method.equalsIgnoreCase("post")){
			
			String email = request.getParameter("mail");
			String nickname = request.getParameter("nick");
			String signature = request.getParameter("signature");
			
			if(email == null || email.equals("") || nickname == null || email.equals("")){
				response.sendRedirect("user.jsp");
				return;
			}
			
			if(!email.equals(me.getEmail())){
				me.updateInfo(Integer.parseInt(uid), User.TYPE_EMAIL, email);
			}
			
			if(!nickname.equals(me.getNickname())){
				me.updateInfo(Integer.parseInt(uid), User.TYPE_NICKNAME, nickname);
			}
			
			if(signature == null || signature.equals("")){
				me.updateInfo(Integer.parseInt(uid), User.TYPE_SIGNATURE, "");
			} else if(!signature.equals(me.getSignature())){
				me.updateInfo(Integer.parseInt(uid), User.TYPE_SIGNATURE, signature);
			}
			
			response.sendRedirect("user.jsp");
			return;
		}

	}catch(Exception e){
		// log
		response.sendRedirect("index.jsp");
	}
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="static/css/site.css" />
<link rel="stylesheet" type="text/css" href="static/css/user.css" />
<title>SYSUWater —— 修改资料</title>
</head>
<body>
<div class="wrap">
	<div class="nav">
		<a href="index.jsp">首页</a>
		<% if(plates != null){
			for(Plate plate:plates){%>
		<a href="post.jsp?p=<%=plate.getPid()%>"><%=plate.getPname()%></a>
		<% }} %>
		<a href="user.jsp?r=logout" class="fr personal" >注销</a>
		<a href="updatepsw.jsp" class="fr personal" >修改密码</a>
	</div>
	
	<div class="container clearfix">
		<div class="left_block fl">
			<form action="updatesig.jsp" class="zm-profile-details-editform" method="post">
				<div class="zm-profile-details zm-profile-mbox">
					<div class="zm-profile-module zg-clear">
						<a href="user.jsp" class="zg-link-litblue zg-right">返回个人主页</a>
						<h2 class="zm-profile-mbox-title"><a href="user.jsp"><%=me.getUsername()%></a> » 编辑个人资料</h2>
					</div>
				
					<div class="zm-profile-module zg-clear">
						<h3><label for="zm-profile-edit-headline">昵称</label></h3>
						<div class="zm-profile-module-desc">
							<fieldset class="zm-profile-edit-fieldset">
								<input name="nick" type="text" class="zg-form-text-input" value="<%=me.getNickname()%>">
							</fieldset>
						</div>
					</div>
					
					<div class="zm-profile-module zg-clear">
						<h3><label for="zm-profile-edit-headline">邮箱</label></h3>
						<div class="zm-profile-module-desc">
							<fieldset class="zm-profile-edit-fieldset">
								<input name="mail" type="text" class="zg-form-text-input" value="<%=me.getEmail()%>">
							</fieldset>
						</div>
					</div>
					
					<div class="zm-profile-module zg-clear zm-profile-details-editform-desc">
						<h3><label for="zm-profile-edit-description">个人简介</label></h3>
						<div class="zm-profile-module-desc">
							<fieldset class="zm-profile-edit-fieldset">
								<div class="zm-editable-editor-wrap">
									<div class="zm-editable-editor-outer">
										<div class="zm-editable-editor-inner zg-form-text-input">
											<textarea class="zm-editable-editor-input" name="signature"><%=me.getSignature()%></textarea>
										</div>
									</div>
								</div>
							</fieldset>
						</div>
					</div>
					
					<div class="zm-profile-module zg-clear zm-profile-details-editform-footer">
						<p>
							<input class="zg-btn-blue" type="submit" value="保存设置">
						</p>
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