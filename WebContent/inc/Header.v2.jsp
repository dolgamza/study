<%@page contentType="text/html;charset=utf-8"%>
<%
request.setCharacterEncoding("utf-8");
String strTitle = java.net.URLDecoder.decode(((request.getParameter("title")!=null)?request.getParameter("title"):"") , java.nio.charset.StandardCharsets.UTF_8.toString());
String strLocation = java.net.URLDecoder.decode(((request.getParameter("location")!=null)?request.getParameter("location"):""), java.nio.charset.StandardCharsets.UTF_8.toString());
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=3.0, minimum-scale=1.0, user-scalable=yes">
    <meta name="format-detection" content="telephone=yes">
    <meta name="mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-capable" content="yes">
	<meta http-equiv="Expires" content="-1"> 
	<meta http-equiv="Pragma" content="no-cache"> 
	<meta http-equiv="Cache-Control" content="No-Cache"> 
    <meta name="keywords" content="">
    <meta name="description" content="">
    <meta name="robots" content="index,follow">
    <meta property="og:title" content="http://www.beablekorea.com">
    <meta property="og:url" content="비에이블코리아(주)">
    <meta property="og:image" content="<%=application.getContextPath() %>/images/link.png">
    <meta property="og:description" content="무인카페, 스터디카페, 조용한분위기">
    
    <title><%=strTitle %></title>
    
    <link rel="canonical" href="http://">
    <link rel="apple-touch-icon-precomposed" href="/favicon.ico">
    <link rel="shortcut icon" href="<%=application.getContextPath() %>/favicon.ico">
    <link rel="stylesheet" href="<%=application.getContextPath() %>/css/style.v2.css?<%= (new java.util.Date()).toLocaleString()%>" type="text/css" media="all">
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js" type="text/javascript"></script>
    <script src="<%=application.getContextPath() %>/js/common.js?<%= (new java.util.Date()).toLocaleString()%>" type="text/javascript"></script>
</head>
<body>
	<div class="rooptop">
		<a href='<%=application.getContextPath() %>/'><img src='<%=application.getContextPath() %>/images/main/logo.png' class='logo'></a>
		<span id='burger'><a href='javascript:toggleDrawer();'><img id="drawer" src='<%=application.getContextPath() %>/images/burger_w.png'></a></span>
		<span class="menu">
			<ul>
				<li><span class='nochild'><a href="<%=application.getContextPath() %>/chain/"><img src='<%=application.getContextPath() %>/images/menu_01.png?1'></a></span>
				<li><span><img src='<%=application.getContextPath() %>/images/menu_02.png?1'></span>
					<ul class='submenu'>
						<li><a href="<%=application.getContextPath() %>/customer/"><img src='<%=application.getContextPath() %>/images/menu_02_01.png?1'></a></li>
						<li class='onlymobile'><a href="<%=application.getContextPath() %>/membership/login.jsp"><img src='<%=application.getContextPath() %>/images/menu_02_02.png?1'></a></li>
						<li class='onlymobile'><a href="<%=application.getContextPath() %>/membership/login.jsp"><img src='<%=application.getContextPath() %>/images/menu_02_03.png?1'></a></li>
					</ul>
				</li>
			</ul>
		</span>
	</div>

<!--  start document -->

