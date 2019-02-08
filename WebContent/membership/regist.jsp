<%@page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "kr.co.beable.chain.*" %>
<%
	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
	
	String strTitle 	= "";
	String strLocation 	= "";
	
	ArrayList<ChainVO.resLocationTapVO> arr = new ChainBean().FC_LOCATION_TAP_PROC("");
	
	/**
	회원가입시 약관, 개인보호정책 등 추가해야 됨.
	**/
	
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

input.fa {width:calc(30% - 11px);border-right:0;}
input.fb {width:calc(25% - 24px);border-left:0;text-align:right;padding-right:10px;}
input.fc {width:calc(45% - 24px);background-color:#80191f;text-align:center;color:white;padding-right:10px;margin-left:0px;cursor:pointer;}

.section span:last-child {margin-left:5px;}
.section select {width:49%;}

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

function auth() {
	alert('okay?');
}

function regist() {
	//등록화면 유효성 체크
	if (!fnRegChk()) {
		return;
	} else {
		alertify.confirm("등록 하시겠습니까?", function (e) {
			if (e) {
				$.post("${pageContext.request.contextPath}/membership/registProc.jsp", $("#frmRegi").serialize(), function(data){
					var json = JSON.parse($.trim(data));
					if(json.isSuccess) {
						location.href = json.resUrl;
					} else {
						alertify.alert(json.resMsg);
					}
				})
				.error(function(){
					alertify.alert("등록 중 오류가 발생했습니다.\n시스템 관리자에게 문의하세요.");
				});
			}
		});
	}
}

var getLocList = function() {
	var url     = "registLocList.jsp?p_pos=franchise&p_sidoCode="+$("#sido").val();
	var script  = document.createElement("script");
	script.type = "text/javascript";
	script.src  = url;
	document.getElementsByTagName("head")[0].appendChild(script);
}

function fnRegChk() {
	
	//휴대폰번호
	if (!checkLength($('#f_id'), 1, 11)) {
		alertify.alert('휴대폰번호를 입력해 주세요.');
		$('#f_id').css('background-color' ,'#fee');
		$('#f_id').focus();
		return false;
	} else $('#f_id').css('background-color' ,'#fff');
	
	//인증번호(시간 체크)
	if (!checkLength($('#f_ath'), 1, 5)) {
		alertify.alert('인증번호를 입력해 주세요.');
		$('#f_ath').css('background-color' ,'#fee');
		$('#f_ath').focus();
		return false;
	} else $('#f_ath').css('background-color' ,'#fff');
	
	//비밀번호
	if (!checkLength($('#f_pw'), 1, 20)) {
		alertify.alert('비밀번호를 입력해 주세요.');
		$('#f_pw').css('background-color' ,'#fee');
		$('#f_pw').focus();
		return false;
	} else $('#f_pw').css('background-color' ,'#fff');
	
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
	
	//지점선택
	if (!$('#sido>option:selected').val()) {
			alertify.alert('지점을 선택해 주세요.');
			$('#sido').css('background-color' ,'#fee');
			$('#sido').focus();
			return false;
		} else $('#sido').css('background-color' ,'#fff');
	
	//비고
	if (!checkLength($('#f_cardno'), 1, 250)) {
		alertify.alert('회원카드번호를 입력해 주세요.');
		$('#f_cardno').css('background-color' ,'#fee');
		$('#f_cardno').focus();
		return false;
	} else $('#f_cardno').css('background-color' ,'#fff');
	
	return true;
}

</script>

<div class='back'>&lt;</div>
<div class='section'>
   		<div class='title'>회원가입</div>	

		<form name='frmRegi' id='frmRegi' method='post'>
		<div class='subtitle'>휴대폰번호</div>
		<div><label for='f_id'></label><input type='text' name='f_id' id='f_id' placeholder='휴대전화번호' onkeypress='numberOnly(this);' maxlength='11'></div>
		<div>
			<span><label for='f_ath'></label><input type='text' name='f_ath' id='f_ath' placeholder='인증번호' class='fa'></span><!--  
			--><span><input type='text' id='b' value='02:00' class='fb'></span><!--  
			--><span><input type='text' id='b' value='인증번호받기' class='fc' onclick='auth();'></span>
		</div>
		<div style='text-align:left;'>인증되었습니다.</div>
		
		<div class='subtitle'>비밀번호</div>
		<div><label for='f_pw'></label><input type='password' name='f_pw' id='f_pw' placeholder='비밀번호'></div>
		<div><input type='password' name='f_pw2' id='f_pw2' placeholder='비밀번호확인'></div>

		<div class='subtitle'>지점선택</div>
		<div>
			<span><select name='sido' id="sido" onchange="getLocList();">
			<%
			if(arr != null && arr.size() > 0) {
				out.println("<option value=''>선택</option>");
   				for(int i=0; i<arr.size(); i++){
   					ChainVO.resLocationTapVO vo = (ChainVO.resLocationTapVO)arr.get(i);
   					out.println("<option value='"+vo.SIDO_CD+"'>"+vo.SIDO_NM+"</option>");
   				}
			}
			%>
			</select></span><span><select name='franchise' id="franchise"><option value="">선택</option></select></span>
		</div>

		<div class='subtitle'>회원카드번호</div>
		<div><label for='f_cardno'></label><input type='text' name='f_cardno' id='f_cardno' placeholder='회원카드번호' onkeypress='numberOnly(this);' maxlength='10'></div>
		<div><img src='../images/card_sample.png'></div>

		<div class='btn' onclick='regist();'>회원가입</div>
		</form>

</div>

<jsp:include page="../inc/Footer.v2.jsp" flush="false">
	<jsp:param name="param" value=""/>
</jsp:include>

