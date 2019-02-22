<%@page contentType="text/html;charset=utf-8"%>
<%@ page import = "kr.co.dw.util.*" %>
<%
	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
	
	String strTitle 	= "";
	String strLocation 	= "";
	
	String f_id			= StrUtil.nvl(request.getParameter("f_id"), "");
	
	System.out.println("f_id : " + f_id);
	
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

input.fa {width:50%;}
span.rec {display:inline-block;width:calc(50% - 12px);text-align:right;}
span.rec a {padding:8px 26px;width:100%;}

.subheading_img {width:160px;height:auto;}
.section div {width:90%;margin-left:auto;margin-right:auto;margin-bottom:5px;}

@media only screen and (max-width : 1040px) {
}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/js/alertify.css?0.5" type="text/css" media="screen">
<script src="${pageContext.request.contextPath}/js/alertify.js" type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/js/formchecker.js?0.1' type='text/javascript'></script>
<script>
function NextPage() {
	if($("#f_id").val() != '<%=f_id %>'){
		alertify.alert("가입된 휴대전화 번호와 입력한 휴대전화 번호가 다릅니다.");
		return false;
	}
	location.href='${pageContext.request.contextPath}/membership/inputChangePwd.jsp?f_id='+$("#f_id").val();	
};

function goMain() {
	location.href='${pageContext.request.contextPath}';
}

</script> 

<div class='section'>
		<a href='javascript:goMain();'><img src='../images/main/logo4sub.png' class='subheading_img'/></a>
   		<div style='margin-top:20px;margin-bottom:80px;font-size:0.8em;'>회원정보 인증 후 비밀번호 변경이 가능합니다.<br>(가입된 휴대전화 번호와 입력한 휴대전화 번호가 같아야 인증번호를 받을 수 있습니다.)</div>	

		<form id='frmEnt' name='frmEnt' method='post'>
		<div><label for='f_id'></label><input type='text' name= 'f_id' id='f_id' placeholder='휴대폰번호' onkeypress='numberOnly(this);' maxlength='11'></div>
		<div><!--  --><span><input type='text' name='f_ath' id='f_ath' placeholder='인증번호' class='fa'></span><!--  
			--><span class='rec'><a class='btn' onclick='auth();'>인증번호받기</a></span><!--  --></div>
		<div class='btn' onclick='NextPage();'>다음</div>
		</form>

</div>

<jsp:include page="../inc/Footer.v2.jsp" flush="false">
	<jsp:param name="param" value=""/>
</jsp:include>

