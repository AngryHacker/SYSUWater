<%@page import="com.sysuwater.biz.User.LoginInfo"%>
<%@page import="com.sysuwater.biz.Plate"%>
<%@page import="com.sysuwater.biz.User"%>
<%@page import="com.sysuwater.biz.Post"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String uid = (String)session.getAttribute("uid");
	if(uid == null){
		response.sendRedirect("login.jsp");
		return;
	}
	
	// 获得所有版块
	 Plate[] plates = null;
	 Post[] hotPosts = null;
	 try{
	 	plates = Plate.getPlateList();
	 	hotPosts = Post.getTopPost(5);
	 }catch(Exception e){
	 	// log
	 }
	
	String msg = "";
	
	String method = request.getMethod();
	if(method.equalsIgnoreCase("POST")) {
		try{
			String psw = request.getParameter("psw");
			String psw2 = request.getParameter("psw2");
			if(psw == null || psw2 == null){
				throw new Exception("密码不可为空");
			}
			if(!psw.equals(psw2)){
				throw new Exception("两次密码输入不一致");
			}
			
			User user = new User();
			boolean isSuccess = user.updateInfo(Integer.parseInt(uid), User.TYPE_PASSWORD, psw);
			if(!isSuccess){
				throw new Exception("修改失败，请重试");
			}
			response.sendRedirect("user.jsp");
		} catch(Exception e) {
			msg = e.getMessage();
		}
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="static/css/site.css" />
<link rel="stylesheet" type="text/css" href="static/css/login.css" />
<title>SYSUWater —— 修改密码 </title>
</head>
<body>
<div class="wrap">
	<div class="nav">
		<a href="index.jsp">首页</a>
		<% if(plates != null){
			for(Plate plate:plates){ %>
		<a href="post.jsp?p=<%=plate.getPid()%>"><%=plate.getPname()%></a>
		<% }} %>
		<a href="" class="fr personal" >个人中心</a>
	</div>
	
	<div class="container clearfix">
		<div class="left_block fl">
			<div class="login_no_qlogin">
				<div class="header">
					<div class="switch"><span class="switch_btn_focus">密码修改</span></div>
				</div>
				<div class="login_tips">
				<% if(msg == null || msg == ""){ %>
				<div class="error_tips" id="error_tips" style="display: none;">
				<% }else{ %>
				<div class="error_tips" id="error_tips" style="display: blcok;">
				<% } %>
					<span class="error_logo" id="error_logo"></span>
					<span class="err_m" id="err_m"><%=msg%></span>
				</div>
				</div>
				<div class="web_qr_login" id="web_qr_login">
					<div class="web_qr_login_show" id="web_qr_login_show">
						<div class="web_login" id="web_login">
							<div class="tips"></div>
							<div class="login_form">
								<form id="loginform" name="loginform" action="updatepsw.jsp" method="post">
									<div class="uinArea" id="uinArea">
										<div class="inputOuter">
											<input type="password"  placeholder="新密码" class="inputstyle password" id="u" name="psw" value=""  maxlength="16" tabindex="2">
										</div>
									</div>
									<div class="pwdArea" id="pwdArea">
										<div class="inputOuter">
											<input type="password" placeholder="再输一遍"  class="inputstyle password" id="p" name="psw2" value="" maxlength="16" tabindex="2">
										</div>
									</div>
									<div class="submit">
										<a class="login_button">
											<input type="submit" tabindex="6" value="提交" class="btn" id="login_button" />
										</a>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="clearfix"></div>
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
<script>
function displayNone(text){
	document.getElementById(text).style.display="none";
}
function changeTips(field, tips){
	var inputText = field.value;
	if(inputText == null || inputText == ""){
		document.getElementById(tips).style.display="block";
	}
}
</script>
</body>
</html>