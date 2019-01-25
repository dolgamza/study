<%@page contentType="text/html;charset=utf-8"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);

String strTitle = "";
String strLocation = "";
%>
<jsp:include page="../inc/Header.v2.jsp" flush="false">
	<jsp:param name="title" value="<%=java.net.URLEncoder.encode(strTitle, java.nio.charset.StandardCharsets.UTF_8.toString())%>"/>
	<jsp:param name="location" value="<%=java.net.URLEncoder.encode(strLocation, java.nio.charset.StandardCharsets.UTF_8.toString()) %>"/>
</jsp:include>

<style>
body {background-color:#eee;color:#777;}
.rooptop, .footer {display:none;}

a {text-decoration:none;color:#000;}
a:visited {color:#555;}
a:hover {color:#80191f;}

.subheading_img {width:160px;height:auto;}
.section div {width:90%;margin-left:auto;margin-right:auto;margin-bottom:5px;}

@media only screen and (max-width : 1040px) {
}

</style>

<script>
function login() {
	location.href = "../settle/center.jsp";
}
</script>

<div class='section'>
		<img src='../images/main/logo4sub.png' class='subheading_img'/>
   		<div style='margin-top:20px;margin-bottom:80px;'>로그인 후 이용가능합니다.</div>	

		<form>
		<div><label for='f_id'></label><input type='text' id='f_id' placeholder='휴대폰번호'></div>
		<div><label for='f_pw'></label><input type='password' id='f_pw' placeholder='비밀번호'></div>
		<div style='margin-top:10px;margin-bottom:20px;'><a href='searchpw.jsp'>비밀번호찾기</a> | <a href='regist.jsp'>회원가입</a></div>
		<div class='btn' onclick='login();'>로그인</div>
		</form>

</div>

<jsp:include page="../inc/Footer.v2.jsp" flush="false">
	<jsp:param name="param" value=""/>
</jsp:include>

