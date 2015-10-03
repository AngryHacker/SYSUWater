<%@page import="com.sysuwater.biz.User"%>
<%@page import="com.sysuwater.biz.Plate"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String uid = (String)session.getAttribute("uid");
	Boolean is_login = false;
	if(uid != null) is_login = true;
	
    String msg = "";
    
	// 获得所有版块
	Plate[] plates = null;
	try{
		plates = Plate.getPlateList();
	}catch(Exception e){
		// log
	}
	
	String method = request.getMethod();
	if(method.equalsIgnoreCase("POST")) {
		try{
			String username = request.getParameter("name");
			String sex = request.getParameter("sex");
			String nick = request.getParameter("nick");
			String email = request.getParameter("mail");
			String psw = request.getParameter("psw");
			String psw2 = request.getParameter("psw2");
			
			if(username == null){
				throw new Exception("用户名不能为空！");
			}
			if(nick == null){
				throw new Exception("昵称不能为空！");
			}
			if(email == null){
				throw new Exception("邮箱不能为空！");
			}
			if(psw == null || psw2 == null){
				throw new Exception("密码不能为空！");
			}
			if(!psw.equals(psw2)){
				throw new Exception("两次输入密码不相同!");
			}
			
			User user = new User();
			user.setUsername(username);
			if(sex.equals("1")){
				user.setSex(true);
			}else{
				user.setSex(false);
			}
			user.setEmail(email);
			user.setIsAdmin(false);
			user.setNickname(nick);
			user.setPassword(psw);
			
			int id = user.registerTmp(user);
			if(id == -1){
				throw new Exception("注册失败，请重试!");
			}
			session.setAttribute("uid", Integer.toString(id));
			session.setAttribute("isAdmin", false);
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
<link rel="stylesheet" type="text/css" href="static/css/register.css" />
<title>SYSUWater —— 注册 </title>
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
					<div class="switch"><span class="switch_btn_focus">新用户注册</span></div>
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
								<form id="loginform" name="loginform" action="register.jsp" method="post">
									<div class="uinArea" id="uinArea">
										<label class="input_tips" id="uin_tips" for="u" style="display: block;">用户名</label>
										<div class="inputOuter">
											<input type="text" onclick="displayNone('uin_tips');displayNone('error_tips');" onblur="changeTips(this, 'uin_tips');" class="inputstyle" id="u" name="name" value="" tabindex="1">
										</div>
									</div>
									<div id="sex_div" class="sex">
										<input type="radio" id="imweb_sex_1" name="sex" checked="checked" value="1">
										<label for="sex_man">男</label>
										<input type="radio" id="imweb_sex_2" name="sex" value="2">
										<label for="sex_woman">女</label>
									</div>
									<div class="uinArea" id="nickArea">
										<label class="input_tips" id="nick_tips" for="u" style="display: block;">昵称</label>
										<div class="inputOuter">
											<input type="text" onclick="displayNone('nick_tips');displayNone('error_tips');" onblur="changeTips(this, 'nick_tips');" class="inputstyle" id="u" name="nick" value="" tabindex="1">
										</div>
									</div>
									<div class="uinArea" id="mailArea">
										<label class="input_tips" id="mail_tips" for="email" style="display: block;">邮箱</label>
										<div class="inputOuter">
											<input type="text" onclick="displayNone('mail_tips');displayNone('error_tips');" onblur="changeTips(this, 'mail_tips');" class="inputstyle" id="email" name="mail" value="" tabindex="1">
										</div>
									</div>
									<div class="pwdArea" id="pwdArea">
										<label class="input_tips" id="pwd_tips" for="p" style="display: block;">密码</label>
										<div class="inputOuter">
											<input type="password" onclick="displayNone('pwd_tips');displayNone('error_tips');" onblur="changeTips(this, 'pwd_tips');" class="inputstyle password" id="psw" name="psw" value="" maxlength="16" tabindex="2">
										</div>
									</div>
									<div class="pwdArea" id="pwd2Area">
										<label class="input_tips" id="pwd2_tips" for="psw2" style="display: block;">再输一遍密码</label>
										<div class="inputOuter">
											<input type="password" onclick="displayNone('pwd2_tips');displayNone('error_tips');" onblur="changeTips(this, 'pwd2_tips');" class="inputstyle password" id="psw2" name="psw2" value="" maxlength="16" tabindex="2">
										</div>
									</div>
									<div class="submit">
										<a class="login_button">
											<input type="submit" tabindex="6" value="注册" class="btn" id="login_button" />
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
//document.getElementById("uin_tips").style.display="none";
//document.getElementById("pwd_tips").style.display="none";
//document.getElementById("error_tips").style.display="none";

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