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
<link rel="stylesheet" href="${pageContext.request.contextPath}/js/alertify.css?0.5" type="text/css" media="screen">
<script src="${pageContext.request.contextPath}/js/alertify.js" type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/js/formchecker.js?0.1' type='text/javascript'></script>
<script>
function login() {
	
	if (!checkLength($('#f_id'), 10, 11)) {
		alertify.alert('올바른 휴대전화번호를 입력하십시오.');
		$('#f_id').css('background-color' ,'#fee');
		$('#f_id').focus();
		return false;
	} else $('#f_id').css('background-color' ,'#fff');
	
	if (!checkPhone($('#f_id'))) {
		alertify.alert("휴대전화번호를 정확히 입력하세요.");
		$('#f_id').css('background-color' ,'#fee');
		$('#f_id').focus();
		return false;
	} else $('#f_id').css('background-color' ,'#fff');
	
	$.post("${pageContext.request.contextPath}/membership/loginIdCheckProc.jsp", $("#frmEnt").serialize(), function(data){
		var json = JSON.parse($.trim(data));
		if(json.isSuccess) {
			//location.href = json.resUrl;
			nextPage(json.resUrl);
		} else {
			alertify.alert(json.resMsg);
		}
	})
	.error(function(){
		alertify.alert("로그인 중 오류가 발생했습니다.\n시스템 관리자에게 문의하세요.");
	});

	return false;
};

function nextPage(url){
	var frm = document.frmEnt;
	frm.target = "_self";
	frm.action = url;
	frm.submit();
}

function goMain() {
	location.href='${pageContext.request.contextPath}';
}

</script>

<div class='section'>
		<a href='javascript:goMain();'><img src='../images/main/logo4sub.png' class='subheading_img'/></a>
   		<div style='margin-top:20px;margin-bottom:80px;line-height:1.2em;'>비밀번호를 찾고자 하는<br/>휴대전화번호를 입력해 주세요.</div>	

		<form id='frmEnt' name='frmEnt' method='post'>
		<div><label for='f_id'></label><input type='text' name= 'f_id' id='f_id' placeholder='휴대전화번호' onkeypress='numberOnly(this);' maxlength='11'></div>
		<div class='btn' onclick='login();'>다음</div>
		</form>

</div>

<jsp:include page="../inc/Footer.v2.jsp" flush="false">
	<jsp:param name="param" value=""/>
</jsp:include>

