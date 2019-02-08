<%@page contentType="text/html;charset=utf-8"%>
<%@ page import = "kr.co.dw.util.*" %>
<%
	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
	
	String strTitle 	= "";
	String strLocation  = "";
	
	String f_id			= StrUtil.nvl(request.getParameter("f_id"), "");
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
.section div ul {margin-left:20px;}
.section div li {text-align:left;font-size:0.825em;}

@media only screen and (max-width : 1040px) {
}

</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/js/alertify.css?0.5" type="text/css" media="screen">
<script src="${pageContext.request.contextPath}/js/alertify.js" type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/js/formchecker.js?0.1' type='text/javascript'></script>
<script>
function pwdChange() {
	
	//비밀번호 확인
	if (!checkLength($('#f_pw2'), 1, 20)) {
		alertify.alert('비밀번호 확인을 입력해 주세요.');
		$('#f_pw2').css('background-color' ,'#fee');
		$('#f_pw2').focus();
		return false;
	} else $('#f_pw2').css('background-color' ,'#fff');
	
	
	//비밀번호 일치 여부
	if ($('#f_pw').val() != $('#f_pw2').val()) {
		alertify.alert('비밀번호 확인이 일치하지 않습니다.');
		$('#f_pw').val("");
		$('#f_pw2').val("");
		$('#f_pw').css('background-color' ,'#fee');
		$('#f_pw').focus();
		return false;
	} else $('#f_pw').css('background-color' ,'#fff');
	
	$.post("${pageContext.request.contextPath}/membership/inputChangePwdProc.jsp", $("#frmEnt").serialize(), function(data){
		var json = JSON.parse($.trim(data));
		if(json.isSuccess) {
			location.href = json.resUrl;
		} else {
			alertify.alert(json.resMsg);
		}
	})
	.error(function(){
		alertify.alert("비밀번호 변경 중 오류가 발생했습니다.\n시스템 관리자에게 문의하세요.");
	});

	return false;
};

function goMain() {
	location.href='${pageContext.request.contextPath}';
}

</script>

<div class='section'>
		<a href='javascript:goMain();'><img src='../images/main/logo4sub.png' class='subheading_img'/></a>
   		<div style='margin-top:20px;margin-bottom:80px;'>비밀번호를 변경해 주세요.</div>	

		<form id='frmEnt' name='frmEnt' method='post'>
		<div><label for='f_id'></label><input type='text' name='f_id' id='f_id' value='<%=f_id %>' placeholder="휴대전화번호"></div>
		<div><label for='f_pw'></label><input type='password' name= 'f_pw' id='f_pw' placeholder='새 비밀번호' maxlength='20'></div>
		<div><label for='f_pw2'></label><input type='password' name= 'f_pw2' id='f_pw2' placeholder='새 비밀번호 확인' maxlength='20'></div>
		<div>
			<ul>
				<li>영문, 숫자, 특수문자를 함께 사용하면(8자 이상 16자 이하)보다 안전합니다.</li>
				<li>다른 사이트와 다른 비에이블스터디카페 아이디만의 비밀번호를 만들어 주세요.</li>
			</ul>
		</div>
		<div class='btn' onclick='pwdChange();'>확인</div>
		</form>

</div>

<jsp:include page="../inc/Footer.v2.jsp" flush="false">
	<jsp:param name="param" value=""/>
</jsp:include>

