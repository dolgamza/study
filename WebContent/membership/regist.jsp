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
body {color:#777;}
.rooptop {position:relative;}
.footer {display:none;}

a {text-decoration:none;color:#000;}
a:visited {color:#555;}
a:hover {color:#80191f;}

.back {position:absolute;color:#80191f;font-size:1.4em;top:73px;left:20px;cursor:pointer;}

.section div {width:90%;margin-left:auto;margin-right:auto;margin-bottom:5px;}
.section div.title {margin-top:20px;text-align:center;color:#80191f;font-size:1.4em;margin-bottom:50px;}
.section div.subtitle {margin-top:20px;text-align:left;color:#80191f;font-size:1em;margin-bottom:10px;}

input.fa {width:calc(50% - 12px);border-right:0;}
input.fb {width:calc(25% - 22px);border-left:0;text-align:right;padding-right:10px;}
input.fc {width:calc(25% - 27px);background-color:#80191f;text-align:center;color:white;padding-right:10px;margin-left:7px;cursor:pointer;}

</style>

<script>
function goBack() {
	location.href='login.jsp';
}

function auth() {
	alert('okay?');
}

function regist() {
	location.href = "../settle/center.jsp";
}
</script>

<div class='back' onclick='goBack();'>&lt;</div>
<div class='section'>
   		<div class='title'>회원가입</div>	

		<form>
		<div class='subtitle'>휴대폰번호</div>
		<div><label for='f_id'></label><input type='text' id='f_id' placeholder='휴대폰번호'></div>
		<div>
				<span><label for='f_ath'></label><input type='text' id='f_ath' placeholder='인증번호' class='fa'></span><!--  
				--><span><input type='text' id='b' value='02:00' class='fb'></span><!--  
				--><span><input type='text' id='b' value='인증' class='fc' onclick='auth();'></span>
		</div>
		<div style='text-align:left;'>인증되었습니다.</div>
		
		<div class='subtitle'>비밀번호</div>
		<div><label for='f_pw'></label><input type='password' id='f_pw' placeholder='비밀번호'></div>
		<div><input type='password' id='f_pw2' placeholder='비밀번호확인'></div>

		<div class='subtitle'>회원카드번호</div>
		<div><label for='f_cardno'></label><input type='text' id='f_cardno' placeholder='회원카드번호'></div>
		<div><img src='../images/card_sample.png'></div>

		<div class='btn' onclick='regist();'>회원가입</div>
		</form>

</div>


<jsp:include page="../inc/Footer.v2.jsp" flush="false">
	<jsp:param name="param" value=""/>
</jsp:include>

