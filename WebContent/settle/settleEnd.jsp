<%@page contentType="text/html;charset=utf-8"%>
<%@ include file = "/membership/loginSess.jsp" %>
<%
	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);

	String strTitle 		= "";
	String strLocation 		= "";
%>
<jsp:include page="../inc/Header.v2.jsp" flush="false">
	<jsp:param name="title" value="<%=java.net.URLEncoder.encode(strTitle, java.nio.charset.StandardCharsets.UTF_8.toString())%>"/>
	<jsp:param name="location" value="<%=java.net.URLEncoder.encode(strLocation, java.nio.charset.StandardCharsets.UTF_8.toString()) %>"/>
</jsp:include>

<style>
body {background-image:url('../images/complete_bg.png');height:calc(100% + 50px);background-size:cover;}
.logo {display:none;}
.rooptop {background-color:transparent;}
.footer {display:none;}
.section {margin-top:-30px;}
.subheading_img {width:130px;height:auto;}
.subheading {color:white;}
.content {color:white;font-size:0.75em;line-height:1.4em;}
.content.s {font-size:0.6em;padding-bottom:30px;}
.history {margin-top:90px;margin-bottom:20px;}
.history img {width:150px;opacity:0.5;filter:alpha(opacity=50);}
</style>

<script>
$(document).ready(function() {
	
});
</script>

<div class='section'>
	<img src='../images/main/logo4sub.png' class='subheading_img'/>
	<div class='subheading'>결제 완료</div>
	<div class='content'>이용해 주셔서 감사합니다.<br/>비에이블스터디카페는 당신의 열정을 항상 응원합니다.</div>

	<div class='history'><a href='settleList.jsp'><img src='../images/settle_history.png?1'></a></div>
	<div class='content s'>결제내역은 홈페이지 우측상단 목록에서 확인하실 수 있습니다.</div>
</div>

<jsp:include page="../inc/Footer.v2.jsp" flush="false">
	<jsp:param name="param" value=""/>
</jsp:include>