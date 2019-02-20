<%@page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "kr.co.beable.chain.*" %>
<%
	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
	
	String strTitle 	= "";
	String strLocation 	= "";
	
	ArrayList<ChainVO.resLocationTapVO> arr = new ChainBean().FC_LOCATION_TAP_PROC();
	
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

.section span {margin:0;}
input.fa {width:calc(100% - 130px);margin:0;}
input.fc {width:100px;background-color:#80191f;text-align:center;color:white;cursor:pointer;}

.section span:last-child {margin-left:5px;}  
.section select {width:49%;}
div.txt {text-align:left;font-size:0.8em;}

</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/js/alertify.css?0.5" type="text/css" media="screen">
<script src="${pageContext.request.contextPath}/js/alertify.js" type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/js/formchecker.js?0.1' type='text/javascript'></script>
<script>
$(document).ready(function() {
	
	var isChecked = false; // 이용약관 동의 여부
	
	//뒤로가기  
	$(".back").click(function() {
		location.href='login.jsp';
	});
	
	$("#cb").click(function() {
		if (!isChecked) {
			$("#cb").attr("src", "../images/check_on.png");
			isChecked = true;
		} else {
			$("#cb").attr("src", "../images/check_off.png");
			isChecked = false;
		}
	});
	
	$("#certificateMsg").hide();
	
});

var getLocList = function() {
	var url     = "registLocList.jsp?p_pos=franchise&p_sidoCode="+$("#sido").val();
	var script  = document.createElement("script");
	script.type = "text/javascript";
	script.src  = url;
	document.getElementsByTagName("head")[0].appendChild(script);
}

function auth() {
	
	if (!fnRegChk('auth')) {
		return;
	} else {
	
		$.post("${pageContext.request.contextPath}/membership/certificateProc.jsp", $("#frmRegi").serialize(), function(data){
			var json = JSON.parse($.trim(data));
			if(json.isSuccess) {
				alertify.alert(json.resMsg);
				$("#certificateMsg").show();
				$("#chkFid").val(json.ResFid);
			} else {
				alertify.alert(json.resMsg);
			}
		})
		.error(function(){
			alertify.alert("인증번호 전송 중 오류가 발생했습니다.\n시스템 관리자에게 문의하세요.");
		});
		
	}
}

function regist() {
	//등록화면 유효성 체크
	if (!fnRegChk('all')) {
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

function fnRegChk(gubun) {
	
	//지역선택
	if (!$('#sido>option:selected').val()) {
			alertify.alert('지역을 선택해 주세요.');
			$('#sido').css('background-color' ,'#fee');
			$('#sido').focus();
			return false;
		} else $('#sido').css('background-color' ,'#fff');
	
	//지점선택
	if (!$('#franchise>option:selected').val()) {
			alertify.alert('지점을 선택해 주세요.');
			$('#franchise').css('background-color' ,'#fee');
			$('#franchise').focus();
			return false;
		} else $('#franchise').css('background-color' ,'#fff');
	
	//휴대폰번호
	if (!checkLength($('#f_id'), 1, 11)) {
		alertify.alert('휴대폰번호를 입력해 주세요.');
		$('#f_id').css('background-color' ,'#fee');
		$('#f_id').focus();
		return false;
	} else $('#f_id').css('background-color' ,'#fff');

	if(gubun == "all"){
	
		//인증번호(시간 체크)
		if (!checkLength($('#f_ath'), 1, 6)) {
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
		
		//비고
		if (!checkLength($('#f_cardno'), 1, 250)) {
			alertify.alert('회원카드번호를 입력해 주세요.');
			$('#f_cardno').css('background-color' ,'#fee');
			$('#f_cardno').focus();
			return false;
		} else $('#f_cardno').css('background-color' ,'#fff');

		if($('#chkFid').val() != "") {
			if ($('#f_id').val() != $('#chkFid').val()) {
				alertify.alert('인증번호를 받은 휴대폰번호를 바꿀 수 없습니다.');
				$('#f_id').val($('#chkFid').val());
				$('#f_id').css('background-color' ,'#fee');
				$('#f_id').focus();
				return false;
			} else $('#f_id').css('background-color' ,'#fff');
		}
	
	}
		
	return true;
}

</script>

<div class='back'>&lt;</div>
<div class='section'>
   		<div class='title'>회원가입</div>	

		<form name='frmRegi' id='frmRegi' method='post'>
		<input type="hidden" id="chkFid">
		<div class='subtitle'>지점선택</div>
		<div>
			<span><select name='sido' id='sido' onchange='getLocList();'>
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
		
		<div class='subtitle'>휴대폰번호</div>
		<div><label for='f_id'></label><input type='text' name='f_id' id='f_id' placeholder='휴대전화번호' onkeyup='numberOnly(this);' maxlength='11'></div>
		<div><!--  
			--><span><input type='text' name='f_ath' id='f_ath' placeholder='인증번호' class='fa'></span><!--  
			--><span><input type='text' id='btnCetification' value='인증' class='fc' onclick='auth();'></span><!--  
		--></div>
		<div style='text-align:left;' id='certificateMsg'>인증번호를 발송였습니다.</div>
		
		<div class='subtitle'>비밀번호</div>
		<div><label for='f_pw'></label><input type='password' name='f_pw' id='f_pw' placeholder='비밀번호 입력'></div>
		<div><input type='password' name='f_pw2' id='f_pw2' placeholder='비밀번호 확인'></div>
 
		<div class='subtitle'>회원카드번호</div>
		<div><label for='f_cardno'></label>
			<input type='text' name='f_cardno' id='f_cardno' placeholder='회원카드 번호 입력(숫자만 입력)' onkeyup='numberOnly(this);' maxlength='10'>
			
			
		</div>
		<div class='txt'>※ 회원카드는 이용하실 센터에서 수령 가능합니다.<br>※ 회원카드가 없으면 결제가 불가능합니다.</div>
		<div><img src='../images/card_sample.png'></div>


		<div class='subtitle'>이용약관 및 환불규정</div>
		<div class='txt' style='vertical-align:top;'><span style='height:20px;'><img id='cb' src='../images/check_off.png' width='17' height='17'></span><span style='height:20px;vertical-align:top;'>이용약관 및 환불규정에 대한 모든 내용에 동의합니다.</span></div>
		<div><textarea class='nbgfont' style='width:calc(100% - 20px);font-size:0.6em;line-height:1.2em;height:230px;'>
제 1 조 (목적)
 
이 약관은 비에이블코리아㈜이하 ("회사")가 운영하는 비에이블스터디카페(이하 "비에이블 스터디카페"라 한다)에서 제공하는 인터넷관련 서비스(이하 "서비스"라 한다)를 이용함에 있어 비에이블 스터디카페와 이용자의 권리·의무 및 책임사항을 규정함을 목적으로 합니다.

제 2 조 (정의)
 1."비에이블 스터디카페"란 "회사"가 재화 또는 용역을 이용자에게 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하여 재화를 거래할 수 있도록 설정한 가상의 영업장을 말하며, 아울러 비에이블 스터디카페를 운영하는 사업자의 의미로도 사용합니다.
2."이용자"란 "비에이블 스터디카페"에 접속하여 이 약관에 따라 "비에이블 스터디카페"가 제공하는 서비스를 받는 회원 및 비회원을 말합니다.
3.'회원'이라 함은 "비에이블 스터디카페"에 개인정보를 제공하여 회원등록을 한 자로서, "비에이블 스터디카페"의 정보를 지속적으로 제공받으며, "비에이블 스터디카페"가 제공하는 서비스를 계속적으로 이용할 수 있는 자를 말합니다.
4.'비회원'이라 함은 회원에 가입하지 않고 "비에이블 스터디카페"가 제공하는 서비스를 이용하는 자를 말합니다.

제3조 (약관의 명시와 개정)
1."비에이블 스터디카페"는 이 약관의 내용과 상호, 센터 소재지, 대표자의 성명, 사업자등록번호, 연락처(전화, 팩스,전자우편 주소 등) 등을 이용자가 알 수 있도록 "비에이블 스터디카페"의 서비스화면(전면)에 게시합니다.
2."비에이블 스터디카페"는 약관의 규제 등에 관한 법률, 전자 문서 및 전자거래 기본법, 전자서명법, 정보통신망이용촉진및정보보호등에관한법률, 방문판매 등에 관한 법률, 소비자 기본법 등 관련법을 위반하지 않는 범위에서 이 약관을 개정할 수 있습니다. 
3."비에이블 스터디카페"의 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 비에이블 스터디카페의 서비스화면에 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다.
4."비에이블 스터디카페"의 약관을 개정할 경우에는 그 개정약관은 그 적용일자 이후에 체결되는 계약에만 적용되고 그 이전에 이미 체결된 계약에 대해서는 개정전의 약관조항이 그대로 적용됩니다. 다만 이미 계약을 체결한 이용자가 개정약관 조항의 적용을 받기를 원하는 뜻을 제3항에 의한 개정약관의 공지기간 내에 "비에이블 스터디카페"에 송신하여 "비에이블 스터디카페"의 동의를 받은 경우에는 개정약관 조항이 적용됩니다.
5.이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 정부가 제정한 전자거래소비자보호지침 및 관계법령 또는 상관례에 따릅니다.

제4조 (서비스의 제공 및 변경)
 1."비에이블 스터디카페"는 다음과 같은 업무를 수행합니다. 

재화에 대한 정보 제공 및 구매계약의 체결
구매계약이 체결된 재화의 전송
기타 "비에이블 스터디카페"가 정하는 업무

2."비에이블 스터디카페"는 재화의 품절 또는 기술적 사양의 변경 등의 경우에는 장차 체결되는 계약에 의해 제공할 재화의 내용을 변경할 수 있습니다. 이 경우에는 변경된 재화의 내용 및 제공일자를 각 센터별로 명시하여 현재의 재화의 내용을 게시한 곳에 그 제공일자 이전 7일부터 공지합니다.
3."비에이블 스터디카페" 제공하기로 이용자와 계약을 체결한 서비스의 내용을 재화의 품절 또는 기술적 사양의 변경 등의 사유로 변경할 경우에는 "비에이블 스터디카페"는 이로 인하여 이용자가 입은 손해를 배상합니다. 단, "비에이블 스터디카페"의 고의 또는 과실이 없는 경우에는 그러하지 아니합니다.

제5조 (서비스의 중단)
 1."비에이블 스터디카페"는 컴퓨터 등 정보통신설비의 보수점검·교체 및 고장, 통신의 두절 등의 사유가 발생한 경우에는 서비스의 제공을 일시적으로 중단할 수 있습니다.
2.제1항에 의한 서비스 중단의 경우에는 "비에이블 스터디카페"는 제8조에 정한 방법으로 이용자에게 통지합니다.
3."비에이블 스터디카페"는 제1항의 사유로 서비스의 제공이 일시적으로 중단됨으로 인하여 이용자 또는 제3자가 입은 손해에 대하여 배상합니다. 단 "비에이블 스터디카페"의 고의 또는 과실이 없는 경우에는 그러하지 아니합니다.

제6조 (회원가입)
 1.이용자는 "비에이블 스터디카페"의 회원카드를 이용하고자 하는 센터에서 현장 발급 받은 후 “비에이블 스터디카페”가 정한 가입양식에 따라 회원정보를 기입한 후 이 약관에 동의한다는 의사표시를 함으로서 회원가입을 신청합니다.
2."비에이블 스터디카페"는 제1항과 같이 회원으로 가입할 것을 신청한 이용자 중 다음 각 호에 해당하지 않는 한 회원으로  등록합니다. 가입신청자가 이 약관 제7조 제3항에 의하여 이전에 회원자격을 상실한 적이 있는 경우, 다만 제7조 제3항에 의한 회원자격 상실 후 3년이 경과한 자로서 "비에이블 스터디카페"에 회원 재가입 승낙을 얻은 경우에는 예외로 한다.
등록 내용에 허위, 기재누락, 오기가 있는 경우
기타 회원으로 등록하는 것이 "비에이블 스터디카페"의 기술상 현저히 지장이 있다고 판단되는 경우
3.회원가입계약의 성립 시기는 해당 "비에이블 스터디카페"의 승낙이 회원에게 도달한 시점으로 합니다.
4.회원은 제16조 제1항에 의한 등록사항에 변경이 있는 경우, 즉시 전자우편 기타 방법으로 해당 "비에이블 스터디카페" 운영자에게 그 변경사항을 알려야 합니다.

제7조 (회원 탈퇴 및 자격 상실 등)
 1.회원은 "비에이블 스터디카페"에서 언제든지 탈퇴를 요청할 수 있으며 "비에이블 스터디카페"는 즉시 회원탈퇴를 처리합니다.
2.회원이 다음 각 호의 사유에 해당하는 경우, "비에이블 스터디카페"는 회원자격을 제한 및 정지시킬 수 있습니다. 
가입 신청시에 허위 내용을 등록한 경우
"비에이블 스터디카페 "를 이용하여 구입한 재화의 대금, 기타 "비에이블 스터디카페" 이용에 관련하여 회원이 부담하는 채무를 기일에 지급하지 않는 경우
다른 사람의 "비에이블 스터디카페" 이용을 방해하거나 그 정보를 도용하는 등 전자거래질서를 위협하는 경우
"비에이블 스터디카페"를 이용하여 법령과 이 약관이 금지하거나 공서양속에 반하는 행위를 하는 경우
3."비에이블 스터디카페"가 회원 자격을 제한·정지 시킨 후, 동일한 행위가 2회 이상 반복되거나 30일 이내에 그 사유가 시정되지 아니하는 경우 "비에이블 스터디카페"는 회원자격을 상실시킬 수 있습니다.
4."비에이블 스터디카페"가 회원자격을 상실시키는 경우에는 회원등록을 말소합니다. 이 경우 회원에게 이를 통지하고, 회원등록 말소 전에 소명할 기회를 부여합니다.

제8조 (회원에 대한 통지)
 1."비에이블 스터디카페"는 회원에 대한 통지를 하는 경우, 회원이 "비에이블 스터디카페"에 제출한 전자우편 주소로 할 수 있습니다.
2."비에이블 스터디카페"는 불특정다수 회원에 대한 통지의 경우 1주일이상 "비에이블 스터디카페" 팝업창에 게시함으로써 개별 통지에 갈음할 수 있습니다.

제9조 (구매신청)
 "비에이블 스터디카페" 이용자는 "비에이블 스터디카페"에서 이하의 방법에 의하여 구매를 신청합니다. 

1.성명, 주소, 전화번호 입력
2.센터 검색 및 선택 
3.재화의 선택
4.결제방법의 선택
5.이 약관에 동의한다는 표시(예, 마우스 클릭)

제10조 (계약의 성립)
 1."비에이블 스터디카페"는 제9조와 같은 구매신청에 대하여 다음 각 호에 해당하지 않는 한 승낙합니다. 다만, 미성년자와 계약을 체결하는 경우에는 법정대리인의 동의를 얻지 못하면 미성년자 본인 또는 법정대리인이 계약을 취소할 수 있다는 내용을 고지하는 조치를 취합니다. 
신청 내용에 허위, 기재누락, 오기가 있는 경우
기타 구매신청에 승낙하는 것이 "비에이블 스터디카페" 기술상 현저히 지장이 있다고 판단하는 경우
2."비에이블 스터디카페"의 승낙이 제12조 제1항의 수신확인통지형태로 이용자에게 도달한 시점에 계약이 성립한 것으로 봅니다.

제11조 (지급방법)
해당 "비에이블 스터디카페"에서 구매한 재화에 대한 대금지급방법은 다음 각 호의 하나로 할 수 있습니다. 

1.계좌이체 
2.신용카드결제
3.온라인무통장입금 
4.전자화폐에 의한 결제
5.적립금에 의한 결제 

제12조 (수신확인통지·구매신청 변경 및 취소)
 1."비에이블 스터디카페"는 이용자의 구매신청이 있는 경우 이용자에게 수신확인통지를 합니다.
2.수신확인통지를 받은 이용자는 의사표시의 불일치 등이 있는 경우에는 수신확인통지를 받은 후 즉시 구매신청 변경 및 취소를 요청할 수 있습니다.
3."비에이블 스터디카페"는 이용자의 구매신청 변경 및 취소 요청이 있을 때에는 그 요청에 따라 처리합니다.

제13조 (배송 또는 전송)
 
"비에이블 스터디카페"는 이용자가 구매한 재화에 대해 배송수단, 수단별 배송비용 부담자, 수단별 배송기간 등을 명시합니다. 만약, "비에이블 스터디카페"의 고의·과실로 약정 기간을 초과한 경우에는 그로 인한 이용자의 손해를 배상합니다.

제14조 (청약철회와 계약해제,해지)
 1."비에이블 스터디카페"와 재화 구매에 관한 계약을 체결한 이용자는 수신확인의 통지를 받은 날부터 7일 이후에는 청약의 철회를 할 수 없습니다. 
2.이용자는 재화를 전송받은 경우 다음 각호의 1에 해당하는 경우에는 환불 및 교환을 할 수 없습니다. 

이용자에게 책임 있는 사유로 재화 등이 멸실 경우
이용자의 사용 또는 일부 소비에 의하여 재화 등의 가치가 현저히 감소한 경우
시간의 경과에 의하여 재판매가 곤란할 정도로 재화등의 가치가 현저히 감소한 경우
같은 성능을 지닌 재화등으로 복제가 가능한 경우

3.제2항 제2호 내지 제4호의 경우에 "비에이블 스터디카페"가 사전에 청약철회 등이 제한되는 사실을 소비자가 쉽게 알 수 있는 곳에 명시하거나 상품을 제공하는 등의 조치를 하지 않았다면 이용자의 청약철회등이 제한되지 않습니다.



제15조 (청약철회와 계약해제,해지의 효과)
 1.환불하고자 한 "비에이블 스터디카페" 해당 센터는 이용자로부터 재화 등을 반환받은 경우 3영업일 이내에 이미 지급받은 재화등의 대금을 환급합니다.
2."비에이블 스터디카페"는 위 대금을 환급함에 있어서 이용자가 신용카드 또는 전자화폐 등의 결제수단으로 재화등의 대금을 지급한 때에는 지체없이 해당 결제수단을 제공한 사업자로 하여금 재화등의 대금의 청구를 정지 또는 취소하도록 요청합니다.
3.청약철회등의 경우 공급받은 재화등의 반환에 필요한 비용은 이용자가 부담합니다. 해당 "비에이블 스터디카페" 운영자는 이용자에게 청약철회등을 이유로 위약금 또는 손해배상을 청구하지 않습니다. 다만 재화등의 내용이 표시·광고 내용과 다르거나 계약내용과 다르게 이행되어 청약철회등을 하는 경우 재화등의 반환에 필요한 비용은 해당 "비에이블 스터디카페" 운영자가 부담합니다.

제16조 (개인정보보호)
 1."비에이블 스터디카페"는 이용자의 정보수집시 구매계약 이행에 필요한 최소한의 정보를 수집합니다. 다음 사항을 필수사항으로 하며 그 외 사항은 선택사항으로 합니다. 

핸드폰번호
비밀번호(회원의 경우)
회원카드 번호 (발급 필수)

2."비에이블 스터디카페"는 이용자의 개인식별이 가능한 개인정보를 수집하는 때에는 반드시 당해 이용자의 동의를 받습니다.
3.제공된 개인정보는 당해 이용자의 동의 없이 목적 외의 이용이나 제3자에게 제공할 수 없으며, 이에 대한 모든 책임은 "비에이블 스터디카페"가 집니다. 다만, 다음의 경우에는 예외로 합니다. 

미성년자의 경우 법정대리인의 요청이 있을시 최소한의 이용자의 정보(성명, 주소, 전화번호)를 알려주는 경우
통계작성, 학술연구 또는 시장조사를 위하여 필요한 경우로서 특정 개인을 식별할 수 없는 형태로 제공하는 경우

4."비에이블 스터디카페"가 제2항과 제3항에 의해 이용자의 동의를 받아야 하는 경우에는 개인정보관리 책임자의 신원(소속, 성명 및 전화번호 기타 연락처), 정보의 수집목적 및 이용목적, 제3자에 대한 정보제공 관련사항(제공받는자, 제공목적 및 제공할 정보의 내용)등 정보통신망이용촉진등에관한법률 제17조 제3항이 규정한 사항을 미리 명시하거나 고지해야 하며 이용자는 언제든지 이 동의를 철회할 수 있습니다.
5.이용자는 언제든지 "비에이블 스터디카페"가 가지고 있는 자신의 개인정보에 대해 열람 및 오류정정을 요구할 수 있으며 "비에이블 스터디카페"는 이에 대해 필요한 조치를 취할 의무를 집니다. 이용자가 오류의 정정을 요구한 경우 "비에이블 스터디카페"는 그 오류를 정정할 때까지 당해 개인정보를 이용하지 않습니다.
6."비에이블 스터디카페"는 개인정보 보호를 위하여 관리자를 한정하여 그 수를 최소화하며 신용카드, 은행계좌 등을 포함한 이용자의 개인정보의 분실, 도난, 유출, 변조 등으로 인한 이용자의 손해에 대하여 모든 책임을 집니다.
7."비에이블 스터디카페" 또는 그로부터 개인정보를 제공받은 제3자는 개인정보의 수집목적 또는 제공 받은 목적을 달성한 때에는 당해 개인정보를 지체없이 파기합니다.

제17조 ("비에이블 스터디카페"의 의무)
 1."비에이블 스터디카페"는 법령과 이 약관이 금지하거나 공서양속에 반하는 행위를 하지 않으면 이 약관이 정하는 바에 따라 지속적이고, 안정적으로 재화를 제공하는 데 최선을 다하여야 합니다.
2."비에이블 스터디카페"는 이용자가 안전하게 인터넷서비스를 이용할 수 있도록 이용자의 개인정보(신용정보 포함)보호를 위한 보안시스템을 갖추어야 합니다.
3."비에이블 스터디카페"는 재화에 대하여 「표시·광고의공정화에관한법률」 제3조 소정의 부당한 표시·광고행위를 함으로써 이용자가 손해를 입은 때에는 이를 배상할 책임을 집니다.
4."비에이블 스터디카페“ 이용자가 원하지 않는 영리목적의 광고성 전자우편을 발송하지 않습니다.

제18조 (회원의 카드번호 및 비밀번호에 대한 의무)
1.제16조의 경우를 제외한 카드번호와 비밀번호에 관한 관리책임은 회원에게 있습니다.
2.회원은 자신의 카드번호 및 비밀번호를 제3자에게 이용하게 해서는 안됩니다.
3.회원이 자신의 카드번호 및 비밀번호를 도난 당하거나 제3자가 사용하고 있음을 인지한 경우에는 바로 해당 "비에이블 스터디카페" 운영자에게 통보하고 안내가 있는 경우에는 그에 따라야 합니다.

제19조 (회원의 카드번호 및 비밀번호에 대한 의무)
이용자는 다음 행위를 하여서는 안됩니다.  

1.신청 또는 변경시 허위내용의 등록
2."비에이블 스터디카페"에 게시된 정보의 변경
3."비에이블 스터디카페"가 정한 정보 이외의 정보(컴퓨터 프로그램 등)의 송신 또는 게시
4."비에이블 스터디카페" 기타 제3자의 저작권 등 지적재산권에 대한 침해
5."비에이블 스터디카페" 기타 제3자의 명예를 손상시키거나 업무를 방해하는 행위
6.외설 또는 폭력적인 메시지·화상·음성 기타 공서양속에 반하는 정보를 "비에이블 스터디카페"에 공개 또는 게시하는 행위

제20조 ("비에이블 스터디카페"와 센터와의 관계)
 1.상위 "비에이블스터디카페"와 하위 "센터"가 하이퍼 링크(예: 하이퍼 링크의 대상에는 문자, 그림 및 동화상 등이 포함됨)방식 등으로 연결된 경우, 전자를 연결 "비에이블 스터디카페"(웹 사이트)이라고 하고 후자를 피연결 "센터 이용 결제"(웹사이트)라고 합니다.
2.연결 "비에이블 스터디카페"는 피연결 "센터"가 독자적으로 제공하는 재화에 의하여 이용자와 행하는 거래에 대해서 보증책임을 지지 않는다는 뜻을 연결 "센터"의 사이트에서 명시한 경우에는 그 거래에 대한 보증책임을 지지 않습니다.

제21조 (저작권의 귀속 및 이용제한)
 1."비에이블 스터디카페"가 작성한 저작물에 대한 저작권 기타 지적재산권은 "비에이블 코리아(주)"에 귀속합니다.
2.이용자는 "비에이블 스터디카페"를 이용함으로써 얻은 정보를 "비에이블 스터디카페"의 사전 승낙 없이 복제, 송신, 출판, 배포, 방송 기타 방법에 의하여 영리목적으로 이용하거나 제3자에게 이용하게 하여서는 안됩니다.

제22조 (분쟁해결)
 1."비에이블 스터디카페"는 이용자가 제기하는 정당한 의견이나 불만을 반영하고 그 피해를 보상처리하기 위하여 피해보상처리기구를 설치·운영합니다.
2."비에이블 스터디카페"는 이용자로부터 제출되는 불만사항 및 의견은 우선적으로 그 사항을 처리합니다. 다만, 신속한 처리가 곤란한 경우에는 이용자에게 그 사유와 처리일정을 즉시 통보해 드립니다.
3."비에이블 스터디카페"와 이용자 간에 발생한 전자상거래 분쟁과 관련하여 이용자의 피해구제신청이 있는 경우에는 공정거래위원회 또는 시·도지사가 의뢰하는 분쟁조정기관의 조정에 따를 수 있습니다.

제23조 (재판권 및 준거법)
 1."비에이블 스터디카페"와 이용자간에 발생한 전자거래 분쟁에 관한 소송은 제소 당시의 이용자의 주소에 의하고, 주소가 없는 경우에는 거소를 관할하는 지방법원의 전속관할로 합니다. 다만, 제소 당시 이용자의 주소 또는 거소가 분명하지 않거나 외국 거주자의 경우에는 민사소송법상의 관할법원에 제기합니다.
2."비에이블 스터디카페"와 이용자간에 제기된 전자거래 소송에는 한국법을 적용합니다.

"회사"는 분쟁이 발생하였을 경우에 "이용자"가 제기하는 정당한 의견이나 불만을 반영하여 적절하고 신속한 조치를 취합니다. 다만, 신속한 처리가 곤란한 경우에 "회사"는 "이용자"에게 그 사유와 처리일정을 통보합니다.
		</textarea></div>




		<div class='btn' onclick='regist();'>회원가입</div>
		</form>

</div>

<jsp:include page="../inc/Footer.v2.jsp" flush="false">
	<jsp:param name="param" value=""/>
</jsp:include>

