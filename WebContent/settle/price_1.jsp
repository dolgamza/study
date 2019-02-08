<%@page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "kr.co.dw.util.*" %>
<%@ page import = "kr.co.beable.chain.ProductVO" %>
<%@ page import = "kr.co.beable.chain.ProductBean" %>
<%@ include file = "/membership/loginSess.jsp" %>
<%
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);

String strTitle = "";
String strLocation = "";

String centerNo = StrUtil.nvl(request.getParameter("centerNo"), "1");	//가맹점 번호
String chkRoom 	= "S";													//ROOM_CD
String chkSeat 	= StrUtil.nvl(request.getParameter("chkSeat"), "1");	//SEAT_NO

System.out.println("centerNo : " + centerNo);
System.out.println("chkRoom : " + chkRoom);
System.out.println("chkSeat : " + chkSeat);

StringBuffer sb = new StringBuffer();
ArrayList<ProductVO> arr = new ProductBean().PM_PRODUCT_LIST_PROC(centerNo, chkRoom);
if (arr!=null && arr.size()>0) {
	String strPrdGrpCd = "";
	
	int j = 0;
	for (int i=0; i<arr.size(); i++) {
		ProductVO vo = arr.get(i);
		if (!strPrdGrpCd.equals(vo.PRD_GRP_CD)) {
			if (i!=0) {
				sb.append("--></ul>\n");
			}
			sb.append("<ul>\n<li class='btn title'>"+vo.PRD_GRP_NM+"<br/>&nbsp;</li><!-- \n");
			strPrdGrpCd = vo.PRD_GRP_CD;
			j = 1;
		}
		if (j%3 == 0) {
			sb.append("--><li class='btn hide'>&nbsp;<br/>&nbsp;</li><!-- \n");
			j++;
		}
		sb.append("--><li class='btn off' product='"+ vo.PRD_CD +"_"+ vo.PRD_NM +"_"+ vo.PRICE +"'>"+ vo.PRD_NM +"<br/>"+ StrUtil.addComma(vo.PRICE) +"원</li><!-- \n");
		j++;
	}
	sb.append("--></ul>");
}

%>
<jsp:include page="../inc/Header.v2.jsp" flush="false">
	<jsp:param name="title" value="<%=java.net.URLEncoder.encode(strTitle, java.nio.charset.StandardCharsets.UTF_8.toString())%>"/>
	<jsp:param name="location" value="<%=java.net.URLEncoder.encode(strLocation, java.nio.charset.StandardCharsets.UTF_8.toString()) %>"/>
</jsp:include>

<link rel='stylesheet' href='price.css?2' />
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<script type="text/javascript" src="price.js?1" ></script>
<script src="../js/jquery-ui.js" type="text/javascript"></script>
<div class='back' onclick='goBack();'>&lt;</div>
<div class='section'>
   		<div class='title'>이용권 결제</div>	
		<div class='subtitle'>_ [스터디룸] 이용권 선택</div>
		<div class='choice'>

<%=sb.toString() %>

		</div>
		<div>
			<select id=''>
				<option value='1'>1시간</option>
				<option value='2'>2시간</option>
				<option value='3'>3시간</option>
				<option value='4'>4시간</option>
				<option value='5'>5시간</option>
				<option value='6'>6시간</option>
				<option value='7'>7시간</option>
				<option value='8'>8시간</option>
			</select>
		</div>
		<div style='left:0;'>
		이용일자 : <input type='text' id="strStartYmd" name='strStartYmd' maxlength='10' style='width:100px' value='' readOnly>
		</div>

		<div class='btn' onclick='complete();'>선택완료</div>
</div>

<!-- popup> -->
<div id="mask"></div>
<div class='pop'>
	모든 이용권은 <strong>결제한 즉시</strong> 이용시간으로 측정됩니다.
	<div>
		<span><a href="javascript:inipay_settle()">결제</a></span>
		<span><a href="javascript:cancel();">취소</a></span>
	</div>
</div>
<!-- >popup -->
<script>
$(document).ready(function(){
	$( "#strStartYmd" ).datepicker({
           monthNamesShort: ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'],
           dayNamesMin:["월","화","수","목","금","토","일"],
           showMonthAfterYear: true,
           changeMonth: true,
           changeYear: true,
           dateFormat:"yy/mm/dd"
	});
});

function inipay_settle() {
	$.post("./inipay.jsp", $("#frmEnt").serialize(), function(data){
		var json = JSON.parse($.trim(data));
		if(json.isSuccess) {
			location.href = json.resUrl;
		} else {
			//alertify.alert(json.resMsg);
			alert(json.resMsg);
		}
	})
	.error(function(){
		//alertify.alert("신청서 제출중 오류가 발생하였습니다. \n시스템 관리자에게 문의하세요.");
		alert("신청서 제출중 오류가 발생하였습니다. \n시스템 관리자에게 문의하세요.");
	});
}

function cancel(){
	location.href='seat.jsp?paramSeqNo=<%=centerNo %>';
}

function goBack() {
	location.href='seat.jsp?paramSeqNo=<%=centerNo %>';
}
</script>

<jsp:include page="../inc/Footer.v2.jsp" flush="false">
	<jsp:param name="param" value=""/>
</jsp:include>

