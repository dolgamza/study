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
	
	request.setCharacterEncoding("utf-8");
	
	String strTitle 	= "";
	String strLocation 	= "";
	
	String now_date		= DwUtil.addDashYMD(DateUtil.getCurrentDate(), "/");
	
	String centerNo 	   = StrUtil.nvl(request.getParameter("centerNo"), "1");	
	String cardNo 		   = StrUtil.nvl(request.getParameter("cardNo"), "");
	String rfidNo 		   = StrUtil.nvl(request.getParameter("rfidNo"), "");
	String cardType   	   = StrUtil.nvl(request.getParameter("cardType"), "");
	String chkRoom 		   = StrUtil.nvl(request.getParameter("chkRoom"), "");
	String short_product   = StrUtil.nvl(request.getParameter("product"), "");
	String delayYN 		   = StrUtil.nvl(request.getParameter("delayYN"), "");
	
	String[] products 	= short_product.split("_");
	
	String productCd	= products[0];
	String productNm 	= products[1];
	String productAmt	= products[2];
	
	StringBuffer sb = new StringBuffer();
	ArrayList<ProductVO> arr = new ProductBean().PM_ROOM_LIST_PROC(Integer.parseInt(centerNo), Integer.parseInt(productCd));
	if (arr!=null && arr.size()>0) {
		int j = 0;
		sb.append("<ul><!-- \n");
		for (int i=0; i<arr.size(); i++) {
			ProductVO vo = arr.get(i);
			
			sb.append("--><li class='btn off' short_product='"+ productCd +"_"+ productNm +"' seat='"+vo.SEAT_CD+"_"+vo.SEAT_NO+"'>"+ vo.SEAT_NM +"<br/></li><!-- \n");
		}
		sb.append("--></ul>");
	}
%>
<jsp:include page="../inc/Header.v2.jsp" flush="false">
	<jsp:param name="title" value="<%=java.net.URLEncoder.encode(strTitle, java.nio.charset.StandardCharsets.UTF_8.toString())%>"/>
	<jsp:param name="location" value="<%=java.net.URLEncoder.encode(strLocation, java.nio.charset.StandardCharsets.UTF_8.toString()) %>"/>
</jsp:include>
<link rel='stylesheet' href='price.css?<%=DateUtil.getCurrentDateTimeMilli() %>' />
<link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
<style>

input, select, label {font-size:0.75em;}

.status {padding:0;height:auto;display:none;position:relative;}
table {width:100%;padding:0;margin:0;}

input.fc {width:60px;background-color:#80191f;text-align:center;color:white;padding-right:2px;cursor:pointer;}

.ui-datepicker{ font-size: 12px; width: 230px; }
.ui-datepicker select.ui-datepicker-month{ width:35%; font-size: 11px; }
.ui-datepicker select.ui-datepicker-year{ width:45%; font-size: 11px; }

.hide {display:none;}
.frm {text-align:left;}
.frm label {width:80px;display:inline-block}
.frm input, .frm select {margin-left:2px;}

</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/js/alertify.css?<%=DateUtil.getCurrentDateTimeMilli() %>" type="text/css" media="screen">
<script src="${pageContext.request.contextPath}/js/alertify.js" type="text/javascript"></script>
<script src="http://code.jquery.com/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<script>
var seatTypeAndNo = "";

$(document).ready(function() {
	
	setNowTime();
	
	$( "#strStartYmd, #strReserveYmd" ).datepicker({
        monthNamesShort: ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'],
        dayNamesMin:["월","화","수","목","금","토","일"],
        showMonthAfterYear: true,
        changeMonth: true,
        changeYear: true,
        dateFormat:"yy/mm/dd"
	});
	
	$(".choice li").click(function() {
		//초기화
		$(".status").html("");
		
		t = $(".choice li").index(this);
		
		short_product 	= $(this).attr("short_product");
		seatTypeAndNo 	= $(this).attr("seat");
		
		$("#short_product").val(short_product);
		$("#chkSeat").val(seatTypeAndNo);
		
		$(".choice li").addClass("off");
		$(".choice li").eq(t).removeClass("off");
		
		goPage();
		
		$(".hide").show();
	});
	
	$(".back").click(function(){
		var frm = document.frmSettle;
			frm.target = "_self";
			frm.action = 'price_1_List.jsp';
			frm.submit();
	});
});

function goPage() {
	//리스트 가져오기
	$.post("./roomSelectAjax.jsp", $("#frmSettle").serialize(), function(data){
		var json = JSON.parse($.trim(data));
		if(json.isSuccess) {
			fnMakList(json.resData);
		} else {
			fnMakList("");
		}
	})
	.error(function(){
		fnMakList("");
	});

}

function fnMakList(jsonList) {
	
	var nextUrl;
	var modifyUrl;
	
	/* 화면 리스트 구현 */
	var listHtml = '<table>';
	if(jsonList != '' && jsonList.length > 0) {
		listHtml += '';
		for (var i = 0; i < jsonList.length; i++) {
			listHtml += '<tr>';
			listHtml += '	<td>예약자</td>';
			listHtml += '	<td>이용시간</td>';
			listHtml += '	<td>예약번호</td>';
			listHtml += '</tr>';
			listHtml += '<tr>';
			listHtml += '	<td>'+jsonList[i].RESERVATION_NAME+'</td>';
			listHtml += '	<td>'+jsonList[i].RESERVATION_TIME+'</td>';
			listHtml += '	<td>'+jsonList[i].RESERVATION+'</td>';
			listHtml += '</tr>';
		}  
	} else {
		listHtml += '<tr><td style="height:60px;">예약 내역이 없습니다.</td></tr>';
	}
	
	listHtml += '</table>';
	
	$(".status").html(listHtml);
}

function setNowTime() {
	
	var sd 		= new Date();
	var se_mm 	= Math.ceil(sd.getMinutes() / 5) * 5;
	var hh;
	
	if(sd.getHours() < 10){
		hh = "0" + sd.getHours();
	} else {
		hh = sd.getHours();
	}
	
	$("#strev_hh").val(hh);
	$("#strev_mm").val(se_mm);
	  
	setUseAmt(60);
	
}

function setUseAmt(time){
	
	var timeHH = time / 60;
	var useAmt = (<%=productAmt %> * time / 60);
	var strProduct = '<%=productCd %>_<%=productNm %>_'+useAmt+'_'+timeHH+'_<%=delayYN %>';   
	
	$("#tot_amt").val(useAmt);
	$("#product").val(strProduct);
}

function chkRoomTime() {
	if (seatTypeAndNo!="") { 
		$.post("./setRoomUseChk.jsp", $("#frmSettle").serialize(), function(data){
			var json = JSON.parse($.trim(data));
			if(json.isSuccess) {
				complete();
			} else {
				alertify.alert("이미 예약된 일정입니다.");
			}
		})
		.error(function(){  
			alertify.alert("다시 한번 시도해주세요.");
		});
	} else {
		alertify.alert("스터디룸을 선택하세요.");
	}
}

function complete() {
	var maskHeight = $(document).height();
    var maskWidth = $(window).width();  
    $('#mask').css({'width':maskWidth,'height':maskHeight});  
     	$('#mask').fadeIn(300);      
     	$('#mask').fadeTo("slow",0.7);
     	$(".pop").show();
     	$("html, body").scrollTop(0);
    $(".pop .settle").click(function() {
    	var frm = document.frmSettle;
 		frm.target = "_self";
 		frm.action = 'inipay.jsp';
 		frm.submit();
    });
    $(".pop .cancel").click(function() {
    	$('#mask').hide();  
		$(".pop").hide();
    });
}

</script>
<div class='back'>&lt;</div>
<div class='section'>
   		<div class='title'>스터디룸 이용권 결제</div>	
		<div class='subtitle'>* 스터디룸을 선택하세요.</div>
		<div class='choice'>
		<%=sb.toString() %>
		</div>
		<div class='txt_reservation subtitle hide'>* 예약현황</div>
		<div class='hide frm'> 
			<label>이용일자</label><input type='text' id="strStartYmd" name='strStartYmd' maxlength='10' style='width:120px' value='' readOnly>
			<a onclick='goPage();$(".status").show();' class='btn' style='padding:7px 10px;'>검색</a>
		</div>
		<div class='status'></div>
		
		<form name='frmSettle' id='frmSettle' method='post'> 
		<div class='subtitle hide'>* 스터디룸 예약하기</div>
		<input type='text' name='centerNo' id='centerNo' value='<%=centerNo %>' />
		<input type='text' name='cardNo' id='cardNo' value='<%=cardNo %>' />
		<input type='text' name='chkRoom' id='chkRoom' value='<%=chkRoom %>' />
		<input type='text' name='rfidNo' id='rfidNo' value='<%=rfidNo %>' />
		<input type='text' name='cardType' id='cardType' value='<%=cardType %>' />
		<input type='text' name='product' id='product' /> 
		<input type='text' name='chkSeat' id='chkSeat' />
		<div class='hide frm'>
			<label>이용일자</label>
			<input type='text' id="strReserveYmd" name='strReserveYmd' maxlength='10' style='width:120px' value='<%=now_date %>' readOnly>
		</div>
		<div class='hide frm'>
			<label>시작시간</label>
			<select name='strev_hh' id='strev_hh' style="width:100px;">
				<option value='01'>01</option>
				<option value='02'>02</option>
				<option value='03'>03</option>
				<option value='04'>04</option>
				<option value='05'>05</option>
				<option value='06'>06</option>
				<option value='07'>07</option>
				<option value='08'>08</option>
				<option value='09'>09</option>
				<option value='10'>10</option>
				<option value='11'>11</option>
				<option value='12'>12</option>
				<option value='13'>13</option>
				<option value='14'>14</option>
				<option value='15'>15</option>
				<option value='16'>16</option>
				<option value='17'>17</option>
				<option value='18'>18</option>
				<option value='19'>19</option>
				<option value='20'>20</option>
				<option value='21'>21</option>
				<option value='22'>22</option>
				<option value='23'>23</option>
				<option value='00'>00</option>
			</select>
			<select name='strev_mm' id='strev_mm' style="width:100px;">
				<option value='00'>00</option>
				<option value='05'>05</option>
				<option value='10'>10</option>
				<option value='15'>15</option>
				<option value='20'>20</option>
				<option value='25'>25</option>
				<option value='30'>30</option>
				<option value='35'>35</option>
				<option value='40'>40</option>
				<option value='45'>45</option>
				<option value='50'>50</option>
				<option value='55'>55</option>
			</select>
		</div>
		<div class='hide frm'>
			<label>이용시간</label>
			<select id='use_time' name='use_time' style="width:100px;" onchange="javascript:setUseAmt(this.value);">
				<option value='60'>01:00</option>
				<option value='90'>01:30</option>
				<option value='120'>02:00</option>
				<option value='150'>02:30</option>
				<option value='180'>03:00</option>
				<option value='210'>03:30</option>
				<option value='240'>04:00</option>
				<option value='270'>04:30</option>
				<option value='300'>05:00</option>
				<option value='330'>05:30</option>
				<option value='360'>06:00</option>
				<option value='390'>06:30</option>
				<option value='420'>07:00</option>
			</select>
		</div>
		<div class='hide frm'>
			<label>이용금액</label>
			<input type="text" name="tot_amt" id="tot_amt"  style="width:100px;" />
		</div>
		</form>
		<div class='btn' onclick='chkRoomTime();'>선택완료</div>
</div>
<!-- popup> -->
<div id="mask"></div>
<div class='pop'>
	<div class='txt'>모든 이용권은 <strong>결제한 즉시</strong><br/>이용시간으로 측정됩니다.</div>
	<div class='btn'>
		<span class='settle'>결제</span>
		<span class='cancel'>취소</span>
	</div>
</div>
<!-- >popup -->
<jsp:include page="../inc/Footer.v2.jsp" flush="false">
	<jsp:param name="param" value=""/>
</jsp:include>

