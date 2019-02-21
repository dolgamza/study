<%@page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "kr.co.beable.chain.*" %>
<%@ include file = "/membership/loginSess.jsp" %>
<%
	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
	
	request.setCharacterEncoding("utf-8");
	
	String strTitle 	= "";
	String strLocation 	= "";
	
	String strGubun 	= StrUtil.nvl(request.getParameter("gubun"), "");
	String strStoreNo 	= StrUtil.nvl(request.getParameter("store_no"), "");
	String strStoreNm 	= StrUtil.nvl(request.getParameter("store_nm"), "");
	String strCardNo 	= StrUtil.nvl(request.getParameter("card_no"), "");
	
	String buttonNm 	= "";
	
	System.out.println("strGubun : " + strGubun);
	
	if("M".equalsIgnoreCase(strGubun)) { buttonNm = "변경"; } else { buttonNm = "등록"; }

	System.out.println("buttonNm : " + buttonNm);
  
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
.section div.title {margin-top:20px;text-align:center;color:#80191f;font-size:1.4em;margin-bottom:50px;}
.section div.subtitle {margin-top:20px;text-align:left;color:#80191f;font-size:1em;margin-bottom:10px;}

.section div.frm {position:relative;text-align:left;height:40px;}
label {position:absolute;width:120px;margin-top:8px;}
input {position:absolute;margin-left:128px;margin-top:0px;width:calc(100% - 140px);}
.noborder {border:0 none;background-color:transparent;}

@media only screen and (max-width : 1040px) {

}

</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/js/alertify.css?0.5" type="text/css" media="screen">
<script src="${pageContext.request.contextPath}/js/alertify.js" type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/js/formchecker.js?0.1' type='text/javascript'></script>
<script>
$(document).ready(function() {
	
	//뒤로가기
	$(".back").click(function() {
		location.href='login.jsp';
	});
	
});

function modifyCardNo() {
	
	//카드번호 확인
	if (!checkLength($('#f_cardno'), 1, 20)) {
		alertify.alert('카드번호를 입력해 주세요.');
		$('#f_cardno').css('background-color' ,'#fee');
		$('#f_cardno').focus();
		return false;
	} else $('#f_cardno').css('background-color' ,'#fff');
	
	$.post("${pageContext.request.contextPath}/membership/cardModifyProc.jsp", $("#frmEnt").serialize(), function(data){
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


</script>
<div class='section'>
		<a href='javascript:goMain();'><img src='../images/main/logo4sub.png' class='subheading_img'/></a>
   		<div class='title'>카드번호 <%=buttonNm %></div>	

		<form name='frmEnt' id='frmEnt' method='post'>
		<input type="hidden" id="strGubun" name="strGubun" value="<%=strGubun %>">
		<input type="hidden" id="strStoreNo" name="strStoreNo" value="<%=strStoreNo %>">
		
		<div class='frm'><label>가맹점명</label><input type='text' class='noborder' value='<%=strStoreNm %>'></div>
		<div class='frm'><label for='f_cardno'>회원카드번호</label><input type='text' name='f_cardno' id='f_cardno' placeholder='회원카드번호(숫자만 입력)' onkeyup='numberOnly(this);' maxlength='10'></div>
		<div><img src='../images/card_sample.png'></div>

		<div class='btn' onclick='modifyCardNo();'><%=buttonNm %></div>
		</form>

</div>

<jsp:include page="../inc/Footer.v2.jsp" flush="false">
	<jsp:param name="param" value=""/>
</jsp:include>

