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
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" type="text/css" media="all">
    <link rel="stylesheet" href="<%=application.getContextPath() %>/css/style.css?41243" type="text/css" media="all">
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js" type="text/javascript"></script>
    <script src="http://code.jquery.com/ui/1.12.1/jquery-ui.min.js" type="text/javascript"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui-touch-punch/0.2.3/jquery.ui.touch-punch.min.js" type="text/javascript"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.lazyload/1.9.1/jquery.lazyload.min.js" type="text/javascript"></script>
    <script src="<%=application.getContextPath() %>/js/common.js" type="text/javascript"></script>
	<script type="text/javascript">
	var strLocation = "<%=strLocation%>"; // it is required at 'popupmenu.js'
	</script>
</head>
<body>
	<div id="section_pop_menu"></div>
	<div id="container">
		<div id="header">
			<span id="section_top_logo"><a href='<%=application.getContextPath() %>'><img src='<%=application.getContextPath() %>/images/logo.png'></a></span>
			<span id="section_top_navigation">
				<%@include file="DropdownMenu.jsp"%>
			</span>
		</div>

		<div id="section_location"><span></span></div>
		<div><a href='javascript:toggleDrawer();'><img id="drawer" src='<%=application.getContextPath() %>/images/burger_w.png'></a></div>

		<div id="section_body">
				
<!--  start document -->

