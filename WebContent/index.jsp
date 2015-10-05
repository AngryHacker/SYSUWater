<%@page import="javafx.geometry.HPos"%>
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
	Post[] post1 = null;
	Post[] post2 = null;
	Post[] post3 = null;
	Post[] post4 = null;
	Post[] post5 = null;
	Post[] post6 = null;
	
	try{
		Post post = new Post();
		plates = Plate.getPlateList();
		hotPosts = Post.getTopPost(11);
		post1 = post.getPostList(1);
		post2 = post.getPostList(2);
		post3 = post.getPostList(3);
		post4 = post.getPostList(4);
		post5 = post.getPostList(5);
		post6 = post.getPostList(6);
		
	}catch(Exception e){
		// log
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="static/css/site.css" />
<link rel="stylesheet" type="text/css" href="static/css/index.css" />
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
	
	<div id="container" class="container clearfix">
		<div class="styleO art">
			<div class="tit">
				<h3><span class="f30">动态</span><span class="f00 iconDian">全站热点</span><a name="art">全站热点</a></h3>
			</div>
			<div class="tbd">
				<div class="chief">
					<div class="main">
						<div class="picBoxOp">
							<img name="page_cnt_2" width="410" height="315" src="http://img1.gtimg.com/blog/pics/hv1/211/227/1777/115607521.jpg">
							<i></i>
							<span>光绘天使</span>
						</div>
					</div>
					<div class="sub">
						<ul class="sub-list pb21h bbld">
							<% if(hotPosts != null){
								for(int i = 0;i <= 10 && i < hotPosts.length;i++){%>
							<li>
								<a class="left f14px" href="detail.jsp?p=<%=hotPosts[i].getPid()%>&id=<%=hotPosts[i].getPostID()%>"><%=hotPosts[i].getTitle()%></a> 
								<a href="user.jsp?u=<%=hotPosts[i].getAuthorID()%>" class="cDGray fr"><%=hotPosts[i].getAuthorName()%></a>
							</li>
							<% }} %>
							
						</ul>
					</div>
				</div>
			</div>
		</div>
		
		<div class="styleO art">
			<div class="tit">
				<span class="more"><a title="" href="post.jsp?p=1" target="_blank">更多</a></span>
				<h3><span class="f30">青春</span><span class="f00 iconDian">校园社团</span><a name="art">校园社团</a></h3>
			</div>
			<div class="tbd">
				<div class="chief">
					<div class="main">
						<div class="picBoxOp">
							<img name="page_cnt_2" width="410" height="315" src="static/img/girl.jpg">
							<i></i>
							<span>那些年走过的日子</span>
						</div>
					</div>
					<div class="sub">
						<ul class="sub-list pb21h bbld">
							<% if(post1 != null){
								for(int i = 0;i <= 10 && i < post1.length;i++){%>
							<li>
								<a class="left f14px" href="detail.jsp?p=1&id=<%=post1[i].getPostID()%>"><%=post1[i].getTitle()%></a> 
								<a href="user.jsp?u=<%=post1[i].getAuthorID()%>" class="cDGray fr"><%=post1[i].getAuthorName()%></a>
							</li>
							<% }} %>
						</ul>
					</div>
				</div>
			</div>
		</div>
		
		<div class="styleO art">
			<div class="tit">
				<span class="more"><a title="" href="post.jsp?p=2" target="_blank">更多</a></span>
				<h3><span class="f30">生活</span><span class="f00 iconDian">休闲娱乐</span><a name="art">休闲娱乐</a></h3>
			</div>
			<div class="tbd">
				<div class="chief">
					<div class="main">
						<div class="picBoxOp">
							<img name="page_cnt_2" width="410" height="315" src="static/img/happy.jpg">
							<i></i>
							<span>功夫熊猫</span>
						</div>
					</div>
					<div class="sub">
						<ul class="sub-list pb21h bbld">
							<% if(post2 != null){
								for(int i = 0;i <= 10 && i < post2.length;i++){%>
							<li>
								<a class="left f14px" href="detail.jsp?p=2&id=<%=post2[i].getPostID()%>"><%=post2[i].getTitle()%></a> 
								<a href="user.jsp?u=<%=post2[i].getAuthorID()%>" class="cDGray fr"><%=post2[i].getAuthorName()%></a>
							</li>
							<% }} %>
						</ul>
					</div>
				</div>
			</div>
		</div>
		
		<div class="styleO art">
			<div class="tit">
				<span class="more"><a title="" href="post.jsp?p=3" target="_blank">更多</a></span>
				<h3><span class="f30">IT</span><span class="f00 iconDian">电脑科技</span><a name="art">电脑科技</a></h3>
			</div>
			<div class="tbd">
				<div class="chief">
					<div class="main">
						<div class="picBoxOp">
							<img name="page_cnt_2" width="410" height="315" src="static/img/it.jpg">
							<i></i>
							<span>科技力量</span>
						</div>
					</div>
					<div class="sub">
						<ul class="sub-list pb21h bbld">
							<% if(post3 != null){
								for(int i = 0;i <= 10 && i < post3.length;i++){%>
							<li>
								<a class="left f14px" href="detail.jsp?p=3&id=<%=post3[i].getPostID()%>"><%=post3[i].getTitle()%></a> 
								<a href="user.jsp?u=<%=post3[i].getAuthorID()%>" class="cDGray fr"><%=post3[i].getAuthorName()%></a>
							</li>
							<% }} %>
						</ul>
					</div>
				</div>
			</div>
		</div>
		
		<div class="styleO art">
			<div class="tit">
				<span class="more"><a title="" href="post.jsp?p=4" target="_blank">更多</a></span>
				<h3><span class="f30">奋斗</span><span class="f00 iconDian">学术科学</span><a name="art">学术科学</a></h3>
			</div>
			<div class="tbd">
				<div class="chief">
					<div class="main">
						<div class="picBoxOp">
							<img name="page_cnt_2" width="410" height="315" src="static/img/math.jpg">
							<i></i>
							<span>数学天地</span>
						</div>
					</div>
					<div class="sub">
						<ul class="sub-list pb21h bbld">
							<% if(post4 != null){
								for(int i = 0;i <= 10 && i < post4.length;i++){%>
							<li>
								<a class="left f14px" href="detail.jsp?p=4&id=<%=post4[i].getPostID()%>"><%=post4[i].getTitle()%></a> 
								<a href="user.jsp?u=<%=post4[i].getAuthorID()%>" class="cDGray fr"><%=post4[i].getAuthorName()%></a>
							</li>
							<% }} %>
						</ul>
					</div>
				</div>
			</div>
		</div>
		
		<div class="styleO art">
			<div class="tit">
				<span class="more"><a title="" href="post.jsp?p=5" target="_blank">更多</a></span>
				<h3><span class="f30">琐碎</span><span class="f00 iconDian">谈天说地</span><a name="art">谈天说地</a></h3>
			</div>
			<div class="tbd">
				<div class="chief">
					<div class="main">
						<div class="picBoxOp">
							<img name="page_cnt_2" width="410" height="315" src="static/img/ko.jpg">
							<i></i>
							<span>一起玩吧</span>
						</div>
					</div>
					<div class="sub">
						<ul class="sub-list pb21h bbld">
							<% if(post5 != null){
								for(int i = 0;i <= 10 && i < post5.length;i++){%>
							<li>
								<a class="left f14px" href="detail.jsp?p=5&id=<%=post5[i].getPostID()%>"><%=post5[i].getTitle()%></a> 
								<a href="user.jsp?u=<%=post5[i].getAuthorID()%>" class="cDGray fr"><%=post5[i].getAuthorName()%></a>
							</li>
							<% }} %>
						</ul>
					</div>
				</div>
			</div>
		</div>
		
		<div class="styleO art">
			<div class="tit">
				<span class="more"><a title="" href="post.jsp?p=6" target="_blank">更多</a></span>
				<h3><span class="f30">张扬</span><span class="f00 iconDian">体育健身</span><a name="art">体育健身</a></h3>
			</div>
			<div class="tbd">
				<div class="chief">
					<div class="main">
						<div class="picBoxOp">
							<img name="page_cnt_2" width="410" height="315" src="static/img/sport.jpg">
							<i></i>
							<span>力量</span>
						</div>
					</div>
					<div class="sub">
						<ul class="sub-list pb21h bbld">
							<% if(post6 != null){
								for(int i = 0;i <= 10 && i < post6.length;i++){%>
							<li>
								<a class="left f14px" href="detail.jsp?p=6&id=<%=post6[i].getPostID()%>"><%=post6[i].getTitle()%></a> 
								<a href="user.jsp?u=<%=post6[i].getAuthorID()%>" class="cDGray fr"><%=post6[i].getAuthorName()%></a>
							</li>
							<% }} %>
						</ul>
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