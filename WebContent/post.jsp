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
	try{
		plates = Plate.getPlateList();
	}catch(Exception e){
		// log
	}
	
	Post[] posts = null;
	try{
		String p = request.getParameter("p");
		if(p == null) p = "1";
		Integer pid = Integer.valueOf(p);
		Post post = new Post();
		posts = post.getPostList(pid);
	}catch(Exception e){
		// log
		e.printStackTrace();
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="static/css/site.css" />
<link rel="stylesheet" type="text/css" href="static/css/post.css" />
<title>SYSUWater —— 帖子列表</title>
</head>
<body>
<div class="wrap">
	<div class="nav">
		<a href="">首页</a>
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
			<div class="board-list-hd">
    			<div class="board-list-title">话题</div>
    			<div class="right fr">
    				<div class="board-list-write">
    					<a href="/tlist/study-1-0-a-a.html" id="order-recent-publish">最新发表</a>
    					<em class="icon-rank-down"></em>
    				</div>
        			<div class="board-list-count">点击/回复</div>
        			<div class="board-list-reply">
        				<a href="/tlist/study-1-1-a-a.html" id="order-recent-repley"> 我要回复</a>
        				<em class="icon-rank-down"></em>
        			</div>
    			</div>
			</div>
			<div class="board-list-bd" id="board-list-bd">
				<div class="board-list-one even">
	    			<div class="board-list-title">
	    				<div class="board-list-title-box">
	    					<div class="board-list-title-wrap">
	    						<div class="board-list-title-inner">
                        			<span class="article-title">
                        				<a href="" class="black" target="_blank">
                        				中大竟出现宇宙草！</a>
                        			</span>
                        		</div>
                        	</div>
                        </div>
                    </div>
                    <div class="right fr">
                    	<div class="board-list-write">
                    		<a target="_blank" href="">中大 Din</a>
                    		<span class="date">10-02 00:20</span>
                    	</div>
                    	<div class="board-list-count">
                    		<div class="board-list-count-inner">
	        			    	<span>658</span>/15
	        			    </div>
	        			</div>
	        			<div class="board-list-reply">
	        				<a target="_blank" href="">去评论</a>
	        			</div>
	        		</div>
	        	</div>
	        	<div class="board-list-one odd">
	    			<div class="board-list-title">
	    				<div class="board-list-title-box">
	    					<div class="board-list-title-wrap">
	    						<div class="board-list-title-inner">
                        			<span class="article-title">
                        				<a href="" class="black" target="_blank">
                        				世界冠军竟是中大体育老师</a>
                        			</span>
                        		</div>
                        	</div>
                        </div>
                    </div>
                    <div class="right fr">
                    	<div class="board-list-write">
                    		<a target="_blank" href="">中大 Bin</a>
                    		<span class="date">10-02 00:20</span>
                    	</div>
                    	<div class="board-list-count">
                    		<div class="board-list-count-inner">
	        			    	<span>658</span>/15
	        			    </div>
	        			</div>
	        			<div class="board-list-reply">
	        				<a target="_blank" href="">去评论</a>
	        			</div>
	        		</div>
	        	</div>
	        	
	        	<% if(posts != null){
	        	   	for(int i = 0;i < posts.length;++i){
	        	   		if(i%2 == 1){ %>
	        	<div class="board-list-one odd">
	        	        <% }else{ %>
	        	<div class="board-list-one even">
	        	   		<% } %>
	    			<div class="board-list-title">
	    				<div class="board-list-title-box">
	    					<div class="board-list-title-wrap">
	    						<div class="board-list-title-inner">
                        			<span class="article-title">
                        				<a href="detail.jsp?id=<%=posts[i].getPostID() %>" class="black" target="_blank">
                        				<%=posts[i].getTitle()%></a>
                        			</span>
                        		</div>
                        	</div>
                        </div>
                    </div>
                    <div class="right fr">
                    	<div class="board-list-write">
                    		<a target="_blank" href="user.jsp?id=<%=posts[i].getAuthorID()%>"><%=posts[i].getAuthorName()%></a>
                    		<span class="date">10-02 00:20</span>
                    	</div>
                    	<div class="board-list-count">
                    		<div class="board-list-count-inner">
	        			    	<span>658</span>/15
	        			    </div>
	        			</div>
	        			<div class="board-list-reply">
	        				<a target="_blank" href="">去评论</a>
	        			</div>
	        		</div>
	        	</div>
	        	<% }
	        	}%>
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
		<p>Hope you like it</p>
	</div>
</div>
</body>
</html>