<%@page contentType="text/html;charset=utf-8"%>
<%@ page import = "kr.co.dw.util.*" %>
<%@ include file = "/membership/loginSess.jsp" %>
<%
	//로컬 스토리지
	
	request.setCharacterEncoding("utf-8");
	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
	
	String strTitle		= "결제";
	String strLocation	= "";
	
	String centerNo		= StrUtil.nvl(request.getParameter("centerNo")	, "28");			//센터 번호
	String cardNo		= StrUtil.nvl(request.getParameter("cardNo")	, "1");				//카드 번호
	String rfidNo		= StrUtil.nvl(request.getParameter("rfidNo")	, "1");				//RFID 번호
	String cardType		= StrUtil.nvl(request.getParameter("cardType")	, "1");				//회원구분
	String chkRoom		= StrUtil.nvl(request.getParameter("chkRoom")	, "0");				//룸타입
	String product		= StrUtil.nvl(request.getParameter("product")	, "P_PNM_1000");	//PRD_CD _ PRD_NM _ PRICE _ PRD_TIME _ DELAY_YN
	String chkSeat		= StrUtil.nvl(request.getParameter("chkSeat")	, "D_24");			//SEAT_CD _ SEAT_NO
	String reserveYmd	= StrUtil.nvl(request.getParameter("strReserveYmd"));				//이용일자
	String evHh			= StrUtil.nvl(request.getParameter("strev_hh"));					//이용시간-시
	String evMm			= StrUtil.nvl(request.getParameter("strev_mm"));					//이용시간-분
	
	String reserveTime	= "";
	
	reserveYmd	= reserveYmd.replace("/", "");
	reserveTime	= (!"".equals(evHh+evMm) && (evHh+evMm).length() == 4) ? evHh+":"+evMm : "";
	System.out.println("reserveYmd : "+reserveYmd);
	System.out.println("evHh : "+evHh);
	System.out.println("evMm : "+evMm);
	
	System.out.println("centerNo : " + centerNo);
	System.out.println("cardNo : " + cardNo);
	System.out.println("rfidNo : " + rfidNo);
	System.out.println("cardType : " + cardType);
	System.out.println("chkRoom : " + chkRoom);
	System.out.println("product : " + product);
	System.out.println("chkSeat : " + chkSeat);
	
	String[] products	= product.split("_");
	String[] chkSeats	= chkSeat.split("_");
	
	String prdCd		= products[0];
	String prdNm		= products[1];
	String prdAmt		= products[2];
	String prdTime		= products[3];
	String prdDelayYn	= products[4];
	String seatNo		= chkSeats[1];
	
	System.out.println("prdCd : " + prdCd);
	System.out.println("prdNm : " + prdNm);
	System.out.println("prdAmt : " + prdAmt);
	System.out.println("prdTime : " + prdTime);
	System.out.println("prdDelayYn : " + prdDelayYn);
	System.out.println("seatNo : " + seatNo);
%>


<!--************************************************************************************ 
수정해야 할 사항
1. P_NEXT_URL, P_NOTI_URL, P_RETURN_URL을 시스템의 환경에 맞게 수정해야 한다.
2. 기본적으로 상점아이디가 INIpayTest로 세팅되어 있으므로, 1번을 통해 정상동작 여부 확인했으면 P_MID를 상점아이디로 수정한다.
3. 모바일 결제의 경우 euc-kr만 지원을 하고 있습니다. utf-8환경의 경우  결제요청 form내 accept-charset="euc-kr" 처리가 될 수 있도록 변경이 필요합니다.

주의사항
* 기본적으로 세팅해 놓은 P_NEXT_URL, P_NOTI_URL, P_RETURN_URL은 집에 있는 개인PC쪽 주소이므로, 해당 PC가 shutdown되어 있으면 동작되지 않는다.  
************************************************************************************-->
<jsp:include page="../inc/Header.v2.jsp" flush="false">
   <jsp:param name="title" value="<%=java.net.URLEncoder.encode(strTitle, java.nio.charset.StandardCharsets.UTF_8.toString())%>"/>
   <jsp:param name="location" value="<%=java.net.URLEncoder.encode(strLocation, java.nio.charset.StandardCharsets.UTF_8.toString()) %>"/>
</jsp:include>

<style>
body {color:#777;text-align:center;}
.rooptop {position:relative;}
.footer {display:none;}
#burger {display:none;}
.back {position:absolute;color:#80191f;font-size:1.4em;top:73px;left:20px;cursor:pointer;}
.section {width:90%;text-align:center;margin-left:auto;margin-right:auto;}

.section div.title {margin-top:20px;text-align:center;color:#80191f;font-size:1.4em;margin-bottom:50px;}
.section div.subtitle {margin-top:20px;text-align:left;color:#80191f;font-size:1em;margin-bottom:10px;}

p {position:relative;width:100%;height:40px;text-align:left;}
label {position:absolute;width:130px;margin-top:7px;font-size:0.75em;}
input[type=text] {position:absolute;width:calc(100% - 132px);right:0;font-size:0.75em;}
select {position:absolute;width:calc(100% - 120px);right:0;padding-left:5px;font-size:0.75em;}

.btn {text-align:center;border:0;}

.detail {font-size:0.75em;text-align:left;}
.room {text-align:right;color:#80191f;font-weight:bold;font-size:1.2em;padding-top:30px;}
.prod {text-align:right;color:#80191f;font-size:0.9em;padding-top:5px;}
.price {text-align:right;color:#000;font-size:1.3em;padding:14px 0;}

</style>
<script src="${pageContext.request.contextPath}/js/formchecker.js?0.1" type="text/javascript"></script>
<script type="text/javascript"> 

window.name = "BTPG_CLIENT";

var width = 330;
var height = 480;
var xpos = (screen.width - width) / 2;
var ypos = (screen.width - height) / 2;
var position = "top=" + ypos + ",left=" + xpos;
var features = position + ", width=320, height=440";

function on_load() { 
	payform = document.inipay_form;
	/**************************************************************************** 
	OID(상점주문번호)를 랜덤하게 생성시키는 루틴
	상점에서 각 거래건마다 부여하는 고유의 주문번호가 있다면 이 루틴은 필요없고, 
	해당 값을 P_OID에 세팅해서 사용하면 된다.
	
	curr_date = new Date(); 
	year = curr_date.getYear(); 
	month = curr_date.getMonth(); 
	day = curr_date.getDay(); 
	hours = curr_date.getHours(); 
	mins = curr_date.getMinutes(); 
	secs = curr_date.getSeconds(); 
	myform.P_OID.value = year.toString() + month.toString() + day.toString() + hours.toString() + mins.toString() + secs.toString();
	****************************************************************************/ 
	var timestamp = new Date().getTime();
	
	payform.P_OID.value   = "BEABLE_"+timestamp;
} 


function on_pay() { 
	payform = document.inipay_form;
	
	if ($("#P_GOPAYMETHOD>option:selected").val() == "") {
			alert("결제수단을 선택해주세요.");
			return;
	}
	
	if ($("#P_UNAME").val().trim() == "") {
			alert("성명을 입력해주세요.");
			return;
	}
	
	if ($("#P_EMAIL").val().trim() != "") {
		if (!checkEmail($('#P_EMAIL'))) {
			alert("이메일주소를 정확히 입력해주세요.");
			return;
		}
	}
	
	if ($("#P_MOBILE").val().trim() == "") {
		alert("휴대폰번호를 입력해주세요.");
		return;
	}

	
	
	/**************************************************************************** 
	결제수단 action url을 아래와 같이 설정한다
	URL끝에 /를 삭제하면 다음과 같은 오류가 발생한다.
	"일시적인 오류로 결제시도가 정상적으로 처리되지 않았습니다.(MX1002) 자세한 사항은 이니시스(1588-4954)로 문의해주세요."
	****************************************************************************/
	//beable에서 신용카드만 현재사용
	var p_reserved = "";
	if(payform.P_GOPAYMETHOD.value == "CARD" || payform.P_GOPAYMETHOD.value == "MEMB") {
		p_reserved = "twotrs_isp=Y&block_isp=Y&twotrs_isp_noti=N&apprun_check=Y";   //신용카드 거래시 반드시 입력되어야하는 값
		payform.action = "https://mobile.inicis.com/smart/wcard/"; //신용카드
	} else if(myform.P_GOPAYMETHOD.value == "VBANK") {
		myform.action = "https://mobile.inicis.com/smart/vbank/"; //가상계좌
	} else if(myform.P_GOPAYMETHOD.value == "BANK") {
		p_reserved = "twotrs_bank=Y&apprun_check=Y";   //계좌이체 필수옵션 반드시 입력되어야하는 값
		myform.action = "https://mobile.inicis.com/smart/bank/"; //계좌이체
	} else if(myform.P_GOPAYMETHOD.value == "HPP") {
		myform.action = "https://mobile.inicis.com/smart/mobile/"; //휴대폰
	} else if(myform.P_GOPAYMETHOD.value == "CULTURE") {
		myform.action = "https://mobile.inicis.com/smart/culture/"; //문화 상품권
	} else if(myform.P_GOPAYMETHOD.value == "HPMN") {
		myform.action = "https://mobile.inicis.com/smart/hpmn/"; //해피머니 상품권
	} else {
		p_reserved = "twotrs_isp=Y&block_isp=Y&twotrs_isp_noti=N&apprun_check=Y";   //신용카드 거래시 반드시 입력되어야하는 값
		payform.action = "https://mobile.inicis.com/smart/wcard/"; // 엉뚱한 값이 들어오면 카드가 기본이 되게 함
	}
	
	//금액 ',' 제거
	$("#P_AMT").val($("#P_AMT").val().trim().replace(/,/g,""));

	var p_noti = "";
	p_noti += "centerNo=<%= centerNo %>|cardNo=<%= cardNo %>|rfidNo=<%= rfidNo %>|cardType=<%= cardType %>|chkRoom=<%= chkRoom %>|product=<%= product %>|chkSeat=<%= chkSeat %>|reserveYmd=<%= reserveYmd %>|reserveTime=<%= reserveTime %>";
	p_noti += "|eMail="+$("#P_EMAIL").val()+"|mobileNo="+$("#P_MOBILE").val()+"|payMethod="+$("#P_GOPAYMETHOD").val();
	//p_noti += "centerNo="+$("#pCenterNo").val()+"|chkRoom="+$("#pChkRoom").val()+"|chkSeat="+$("#pChkSeat").val()+"|product="+$("#pProduct").val();

	$("#P_NOTI").val(p_noti);//P_NOTI 설정

	$("#P_RESERVED").val(p_reserved);   //P_RESERVED 복합필드 설정
	payform.P_RETURN_URL.value   = payform.P_RETURN_URL.value + "?P_OID=" + payform.P_OID.value; // 계좌이체 결제시 P_RETURN_URL로 P_OID값 전송(GET방식 호출)
	// payform.target = "_self"; // 주석 혹은 제거 시 self 로 지정됨

	payform.submit(); 
}

function goBack() {
	var room = -1;
	if ("C" == "<%= chkRoom %>") {
		room = 0;
	} else if ("S" == "<%= chkRoom %>") {
		room = 1;
	} else {
		return;
	}
	location.href='price_'+room+'.jsp?centerNo=<%=centerNo %>&cardNo=<%=cardNo%>&chkSeat=<%=chkSeat%>';
}

$(document).ready(function(){
	on_load();
});
   
</script> 

<div class='back' onclick='goBack();'>&lt;</div>
<div class='section'>
	<div class='title'>이용권 결제</div>   
	<div class='subtitle'>00센터</div>
	<div class='detail'>소지하고 계신 카드의 센터와 결제하시려는 센터가 일치하는지 확인해 주세요.</div>

	<div class='room'>CAMPUS ROOM</div>
	<div class='prod'>당일권 / 4시간</div>
	<div class='price'><%= CurrencyUtil.getCurrency(prdAmt) %>원</div>

	<div class='subtitle'>결제수단</div>
	
<!--utf-8환경의 경우 accept-charset="euc-kr" 반드시 설정이 되셔야 한글이 깨지지 않습니다. -->

<form name="inipay_form" method="post" accept-charset="euc-kr">
	<!--
	전달해야 하는 파라미터
	
	P_MID             상점아이디 char(10) 필수
	P_AMT             거래금액 char(8) 필수
	P_UNAME           결제고객성명 char(30) 필수
	P_GOODS           결제상품명 char(80) 필수
	P_UNAME           고객성명 char(30) 필수
	
	P_NEXT_URL        결과화면URL char(250) 신용카드, 가상계좌(채번), 휴대폰, 문화상품권, 해피머니에서 사용
	P_NOTI_URL        결과처리URL char(250) 계좌이체, 삼성월렛, Kpay, 가상계좌(입금)에서 사용
	P_RETURN_URL      결과화면URL char(250) 계좌이체, 삼성월렛, kpay 사용
	
	P_NOTI            기타주문정보 char(800) 선택
	P_OID             주문번호 char(40) 선택 / 한글불가 - 숫자/영문/특수기호의 형태(가상계좌 결제 시 필수)
	P_MOBILE          사용자휴대폰번호 char(15) 선택 / '-'를 포함한 번호를 입력한다. 휴대폰 결제시는 널값이 낫다.
	P_EMAIL           사용자이메일주소 char(30) 선택
	P_CARD_OPTION     카드선택옵션 char(2) 선택 / 설정시 해당 카드사가 맨위에 표시됨
	P_ONLY_CARDCODE   신용카드 노출제한 옵션 - 선택된 카드 리스트만 출력되며, 나머지 카드는 출력되지 않습니다.
	
	P_RESERVED        복합 parameter 정보 
	* P_RESERVED=URL encode(name=value&name=value…) 의 형태로 전달(복합필드의 연결구분자가 &이므로 URL encode필요) post방식의 전송은 기본 urlencoding 처리됨
	1. ISP인증분리/새창방지 옵션 - twotrs_isp=Y&block_isp=Y@twotrs_isp_noti=N , 신용카드 결제시 필수(webview 환경은 메뉴얼 내용 참고)
	2. 가상계좌 현금영수증 사용 (기본은 미사용) - vbank_receipt = Y , vbank_receipt =N 
	3. 계좌이체 현금영수증 사용 (기본은 사용) - bank_receipt = Y , bank_receipt = N 
	4. 카드포인트 사용하기 옵션 - cp_yn=Y 
	5. (자체 에스크로/신 에스크로) 사용여부 - useescrow=Y 그 외 계약에 따른 옵션은 별도 문의 필요 ( 에스크로 사용 상점아이디일 경우 ) 
	
	
	*** 휴대폰 전용 필드 ***
	P_HPP_METHOD      상품컨텐츠구분 char(1) 휴대폰(HPP) 결제수단 사용시 필수 / 1=컨텐츠, 2=실물
	
	*** 가상계좌 전용 필드 ***
	P_VBANK_DT        가상계좌입금기한 char(8) 선택 / YYYYMMDD로 설정, 값이 없으면 요청일+10일로 처리됨
	
	-->
	<!-- 안심클릭, 가상계좌(채번), 휴대폰, 문화상품권, 해피머니 사용시 필수 항목 - 인증결과를 해당 url로 post함, 즉 이 URL이 화면상에 보여지게 됨 -->
	<!-- <input type="hidden" name="P_NEXT_URL" value="http://가맹점 Next_url"> --> 
	<input type="hidden" name="P_NEXT_URL" value="http://127.0.0.1:9090<%= application.getContextPath() %>/settle/inipay_rnext.jsp">

	<!-- ISP, 가상계좌(입금), 계좌이체, kpay, 삼성월렛 필수항목 - 이 URL로 결제결과 정보가 리턴됨 -->
	<!-- <input type="hidden" name="P_NOTI_URL" value="http://가맹점 Noti_url"> --> 
	<input type="hidden" name="P_NOTI_URL" value="http://127.0.0.1:9090<%= application.getContextPath() %>/settle/inipay_rnoti.jsp">

	<!-- ISP 필수항목 - ISP, 계좌이체, 삼성월렛, kpay 동작이 완료된 후 이 URL이 화면상에 보여짐 -->
	<!-- <input type="hidden" name="P_RETURN_URL" value="http://가맹점 Return_url"> --> 
	<input type="hidden" name="P_RETURN_URL" value="http://127.0.0.1:9090<%= application.getContextPath() %>/settle/inipay_rreturn.jsp">

	<!-- P_MID 상점아이디. 상점아이디 char(10) 필수 -->
	<!-- 기본적으로 상점아이디가 INIpayTest로 세팅되어 있으므로, 정상동작 여부 확인했으면 P_MID를 상점아이디로 수정한다. -->
	<input type="hidden" id="P_MID" name="P_MID" value="INIpayTest">

	<!-- P_OID 상점주문번호 (상점 임의의 유니크한 번호 설정). 상점 주문번호는 최대 40 BYTE 길이입니다. -->
	<!-- onLoad시 자동채번됨.(on_load함수에서 자동채번 사용) -->
	<input type="hidden" id="P_OID" name="P_OID" value=""> 

	<!--  P_RESERVED 복합 parameter 정보. 옵션 추가는 & 구분자 추가하여 파라미터 추가하시면됩니다. -->
	<input type="hidden" id="P_RESERVED" name="P_RESERVED" value="">
	
	<!-- P_NOTI 회원사에서 이용하는 추가 정보 필드로 전달한 값이 그대로 반환. 최대 800byte를 초과하지 않도록 셋팅 -->
	<input type="hidden" id="P_NOTI" name="P_NOTI" value="">
	
	<!-- P_HPP_METHOD : 컨텐츠 구분. 휴대폰 결제시 필수. 계약된 정보에 따라 입력 필요 1:컨텐츠, 2:실물  -->
	<input type="hidden" id="P_HPP_METHOD" name="P_HPP_METHOD" value="1">

	<p>
		<label for="P_GOPAYMETHOD">결제수단선택</label>
		<select id="P_GOPAYMETHOD" name="P_GOPAYMETHOD">
			<option value="CARD" selected>신용카드</option>
			<option value="MEMB">회원권/할인권</option>
		</select>
	</p>
	<p><label for="P_GOODS">상품명</label><input type="text" id="P_GOODS" name="P_GOODS" value="<%= prdNm %>" readonly><input type="hidden" id="P_AMT" name="P_AMT" value="<%= prdAmt.replace(",","") %>" readonly></p>
	<p><label for="P_UNAME">성명</label><input type="text" id="P_UNAME" name="P_UNAME" value="" maxlength="30"></p>
	<p><label for="P_EMAIL">이메일주소</label><input type="text" id="P_EMAIL" name="P_EMAIL" value="" maxlength="30"></p>
	<p><label for="P_MOBILE">휴대폰번호</label><input type="text" id="P_MOBILE" name="P_MOBILE" value="<%= DwUtil.addDashPhoneNumber(sessUsrPhoneNo) %>" maxlength="20"></p> 
	<div class="btn off" onclick="on_pay()">결제</div>

</form> 

</div>

<jsp:include page="../inc/Footer.v2.jsp" flush="false">
	<jsp:param name="param" value=""/>
</jsp:include>