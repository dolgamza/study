<%@page contentType="text/html;charset=utf-8"%>
<%@ page import = "kr.co.dw.util.*" %>
<!-- %@ include file = "/membership/loginSess.jsp" % -->
<%
	//로컬 스토리지
	
	request.setCharacterEncoding("utf-8");
	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
	
	String strTitle 	= "결제";
	String strLocation 	= "";
	
	String centerNo 	= StrUtil.nvl(request.getParameter("centerNo"), "28");	//센터 번호
	String chkRoom 		= StrUtil.nvl(request.getParameter("chkRoom"), "0");	//
	String chkSeat		= StrUtil.nvl(request.getParameter("chkSeat"), "D_24");
	String product 		= StrUtil.nvl(request.getParameter("product"), "P_PNM_1000");
	
	System.out.println("centerNo : " + centerNo);
	System.out.println("chkRoom : " + chkRoom);
	System.out.println("chkSeat : " + chkSeat);
	System.out.println("product : " + product);
	
	String[] chkSeats 	= chkSeat.split("_");
	String[] products 	= product.split("_");
	
	String seatNo 		= chkSeats[1];
	String productCd	= products[0];
	String productNm 	= products[1];
	String productAmt	= products[2];
	
	
	System.out.println("centerNo : " + centerNo);
	System.out.println("chkRoom : " + chkRoom);
	System.out.println("seatNo : " + seatNo);
	System.out.println("productCd : " + productCd);
	System.out.println("productNm : " + productNm);
	System.out.println("productAmt : " + productAmt);
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
.section {width:90%;text-align:center;margin-left:auto;margin-right:auto;}

p {position:relative;width:100%;height:40px;text-align:left;}
label {position:absolute;width:150px;margin-top:7px;}
input[type=text] {position:absolute;width:calc(100% - 162px);right:0;}

.btn {text-align:center;border:0;}

</style>

<script type="text/javascript"> 

window.name = "BTPG_CLIENT";

var width = 330;
var height = 480;
var xpos = (screen.width - width) / 2;
var ypos = (screen.width - height) / 2;
var position = "top=" + ypos + ",left=" + xpos;
var features = position + ", width=320, height=440";

	function on_load() { 
		myform = document.mobileweb_form; 
		/**************************************************************************** 
		OID(상점주문번호)를 랜덤하게 생성시키는 루틴
		상점에서 각 거래건마다 부여하는 고유의 주문번호가 있다면 이 루틴은 필요없고, 
		해당 값을 P_OID에 세팅해서 사용하면 된다.
		****************************************************************************/ 
		curr_date = new Date(); 
		year = curr_date.getYear(); 
		month = curr_date.getMonth(); 
		day = curr_date.getDay(); 
		hours = curr_date.getHours(); 
		mins = curr_date.getMinutes(); 
		secs = curr_date.getSeconds(); 
		myform.P_OID.value = year.toString() + month.toString() + day.toString() + hours.toString() + mins.toString() + secs.toString();
		} 


	function on_pay() { 
		myform = document.mobileweb_form; 
		
	/**************************************************************************** 
	결제수단 action url을 아래와 같이 설정한다
	URL끝에 /를 삭제하면 다음과 같은 오류가 발생한다.
	"일시적인 오류로 결제시도가 정상적으로 처리되지 않았습니다.(MX1002) 자세한 사항은 이니시스(1588-4954)로 문의해주세요."
	****************************************************************************/ 
		if(myform.P_GOPAYMETHOD.value == "CARD") {
			myform.action = "https://mobile.inicis.com/smart/wcard/"; //신용카드
			}
		else {
			myform.action = "https://mobile.inicis.com/smart/wcard/"; // 엉뚱한 값이 들어오면 카드가 기본이 되게 함
			}
		
		myform.P_RETURN_URL.value = myform.P_RETURN_URL.value + "?P_OID=" + myform.P_OID.value; // 계좌이체 결제시 P_RETURN_URL로 P_OID값 전송(GET방식 호출)
		// myform.target = "_self"; // 주석 혹은 제거 시 self 로 지정됨
		myform.submit(); 
		}
	
	$(document).ready(function(){
		
		on_load();
		
	});
	
</script> 

<div class='back'></div>
<div class='section'>

<!--utf-8환경의 경우 accept-charset="euc-kr" 반드시 설정이 되셔야 한글이 깨지지 않습니다. -->

<form name="mobileweb_form" method="post" accept-charset="euc-kr">

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
	<input type="hidden" name="P_NEXT_URL" value="http://가맹점 Next_url"> 

	<!-- ISP, 가상계좌(입금), 계좌이체, kpay, 삼성월렛 필수항목 - 이 URL로 결제결과 정보가 리턴됨 -->
	<input type="hidden" name="P_NOTI_URL" value="http://가맹점 Noti_url"> 
	
	<!-- ISP 필수항목 - ISP, 계좌이체, 삼성월렛, kpay 동작이 완료된 후 이 URL이 화면상에 보여짐 -->
	<input type="hidden" name="P_RETURN_URL" value="http://가맹점 Return_url"> 

	<!-- P_OID 상점주문번호 (상점 임의의 유니크한 번호 설정). 상점 주문번호는 최대 40 BYTE 길이입니다. -->
	<input type="hidden" name="P_OID" value="test_oid_1234"> 

	<!-- P_HPP_METHOD : 컨텐츠 구분. 휴대폰 결제시 필수. 계약된 정보에 따라 입력 필요 1:컨텐츠, 2:실물  -->
	<p><input type="hidden" name="P_HPP_METHOD" value="1"></p>

	<p><label for="P_GOPAYMETHOD">결제수단선택</label><input type="text" id="P_GOPAYMETHOD" name="P_GOPAYMETHOD" value="card"></p>
	<p><label for="P_MID">상점아이디</label><input type="text" id="P_MID" name="P_MID" value="INIpayTest"></p>
	<p><label for="P_GOODS">상품명</label><input type="text" id="P_GOODS" name="P_GOODS" value="<%=productNm %>"></p>
	<p><label for="P_AMT">금액</label><input type="text" id="P_AMT" name="P_AMT" value="<%=productAmt %>"></p> 
	<p><label for="P_UNAME">성명</label><input type="text" id="P_UNAME" name="P_UNAME" value="기술지원"></p>
	<p><label for="P_EMAIL">이메일주소</label><input type="text" id="P_EMAIL" name="P_EMAIL" value="test@test.0rg"></p>
	<p><label for="P_MOBILE">휴대폰번호</label><input type="text" id="P_MOBILE" name="P_MOBILE" value="020-1111-2222"></p> 
	<div class="btn off" onclick="on_pay()">결제</div>
	
</form> 

</div>


<jsp:include page="../inc/Footer.v2.jsp" flush="false">
	<jsp:param name="param" value=""/>
</jsp:include>
