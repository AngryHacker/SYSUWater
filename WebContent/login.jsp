<%@page import="com.sysuwater.biz.User.LoginInfo"%>
<%@page import="com.sysuwater.biz.Plate"%>
<%@page import="com.sysuwater.biz.User"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String uid = (String)session.getAttribute("uid");
	Boolean is_login = false;
	if(uid != null && uid != "") is_login = true;
	
	// 获得所有版块
	Plate[] plates = null;
	try{
		plates = Plate.getPlateList();
	}catch(Exception e){
		// log
	}
	
	String msg = "";
	
	String method = request.getMethod();
	if(method.equalsIgnoreCase("POST")) {
		try{
			String username = request.getParameter("name");
			String psw = request.getParameter("psw");
			User user = new User();
			LoginInfo res = user.login(username, psw);
			if(!res.IsSuccess()){
				throw new Exception("登录失败，请重试");
			}
			session.setAttribute("uid", Integer.toString(res.getUserID()));
			session.setAttribute("isAdmin", res.IsAdmin());
			response.sendRedirect("index.jsp");
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
<title>SYSUWater —— 登录 </title>
</head>
<body>
<div class="wrap">
	<div class="nav">
		<a href="index.jsp">首页</a>
		<% if(plates != null){
			for(Plate plate:plates){ %>
		<a href="post.jsp?p=<%=plate.getPid()%>"><%=plate.getPname()%></a>
		<% }} %>
		<% if(is_login){ %>
		<a href="" class="fr personal" >个人中心</a>
		<% }else{ %>
		<a href="login.jsp" class="fr personal" >登录</a>
		<a href="register.jsp" class="fr personal" >注册</a>
		<% } %>
	</div>
	
	<div class="container clearfix">
		<div class="left_block fl">
			<div class="login_no_qlogin">
				<div class="header">
					<div class="switch"><span class="switch_btn_focus">账号密码登录</span></div>
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
								<form id="loginform" name="loginform" action="login.jsp" method="post">
									<div class="uinArea" id="uinArea">
										<label class="input_tips" id="uin_tips" for="u" style="display: block;">用户名</label>
										<div class="inputOuter">
											<input type="text" onclick="displayNone('uin_tips');displayNone('error_tips');" onblur="changeTips(this, 'uin_tips');" class="inputstyle" id="u" name="name" value="" tabindex="1">
										</div>
									</div>
									<div class="pwdArea" id="pwdArea">
										<label class="input_tips" id="pwd_tips" for="p" style="display: block;">密码</label>
										<div class="inputOuter">
											<input type="password" onclick="displayNone('pwd_tips');displayNone('error_tips');" onblur="changeTips(this, 'pwd_tips');" class="inputstyle password" id="p" name="psw" value="" maxlength="16" tabindex="2">
										</div>
									</div>
									<div class="submit">
										<a class="login_button">
											<input type="submit" tabindex="6" value="登录" class="btn" id="login_button" />
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