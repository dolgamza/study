<%@page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "kr.co.dw.util.*" %>
<%@ page import = "kr.co.beable.chain.ProductVO" %>
<%@ page import = "kr.co.beable.chain.ProductBean" %>
<%@ include file = "/membership/loginSess.jsp" %>
<%
	request.setCharacterEncoding("utf-8");

	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
	
	String strTitle 	= "";
	String strLocation 	= "";
	
	String now_date		= DwUtil.addDashYMD(DateUtil.getCurrentDate(), "/");
	
	String centerNo 	= StrUtil.nvl(request.getParameter("paramSeqNo"), "1");	
	String cardNo 		= StrUtil.nvl(request.getParameter("paramCardNo"), "");
	String rfidNo 		= StrUtil.nvl(request.getParameter("paramRfid"), "");	
	String product 		= StrUtil.nvl(request.getParameter("product"), "");
	
	String[] products 	= product.split("_");
	
	String productCd	= products[0];
	String productNm 	= products[1];
	String productAmt	= products[2];
	
	System.out.println(productAmt);
	
	System.out.println("centerNo : " + centerNo);
	System.out.println("cardNo : " + cardNo);
	System.out.println("rfidNo : " + rfidNo);
	System.out.println("product : " + product);
	 
	System.out.println(DwUtil.addDashYMD(DateUtil.getCurrentDate(), "/"));
	
	StringBuffer sb = new StringBuffer();
	ArrayList<ProductVO> arr = new ProductBean().PM_ROOM_LIST_PROC(Integer.parseInt(centerNo), Integer.parseInt(productCd));
	if (arr!=null && arr.size()>0) {
		int j = 0;
		sb.append("<ul><!-- \n");
		for (int i=0; i<arr.size(); i++) {
			ProductVO vo = arr.get(i);
			
			sb.append("--><li class='btn off' product='"+ productCd +"_"+ productNm +"_"+ productAmt +"' seat='"+vo.SEAT_NO+"'>"+ vo.SEAT_NM +"<br/></li><!-- \n");
		}
		sb.append("--></ul>");
		  
	}
	
%>
<jsp:include page="../inc/Header.v2.jsp" flush="false">
	<jsp:param name="title" value="<%=java.net.URLEncoder.encode(strTitle, java.nio.charset.StandardCharsets.UTF_8.toString())%>"/>
	<jsp:param name="location" value="<%=java.net.URLEncoder.encode(strLocation, java.nio.charset.StandardCharsets.UTF_8.toString()) %>"/>
</jsp:include>
<link rel='stylesheet' href='price.css?1' />
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
<script src="http://code.jquery.com/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="price.js?20190220" ></script>
<script>
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
		
		product = $(this).attr("product");
		seat 	= $(this).attr("seat");
		
		$("#product").val(product);
		$("#seat").val(seat);
		
		$(".choice li").addClass("off");
		$(".choice li").eq(t).removeClass("off");
		
		goPage();
		
		$(".hide").show();
		
	});
});

function goPage() {
	//리스트 가져오기
	$.post("./roomSelectAjax.jsp", $("#frmPrice").serialize(), function(data){
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
	
	var sd = new Date();
	
	var se_mm = Math.ceil(sd.getMinutes() / 5) * 5;
	
	$("#strev_hh").val(sd.getHours());
	$("#strev_mm").val(se_mm);
	
	setUseAmt(60);
	
}

function setUseAmt(time){
	var useAmt = (<%=productAmt %> * time / 60);
	$("#tot_amt").val(useAmt);
}
</script>
<div class='back' onclick='goBack();'>&lt;</div>
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
		
		<form name='frmPrice' id='frmPrice' method='post'> 
		<div class='subtitle hide'>* 스터디룸 예약하기</div>
		<input type='hidden' name='paramSeqNo' id='centerNo' value='<%=centerNo %>' />
		<input type='hidden' name='paramCardNo' id='cardNo' value='<%=cardNo %>' />
		<input type='hidden' name='paramRfid' id='rfidNo' value='<%=rfidNo %>' />
		<input type='hidden' name='product' id='product' /> 
		<input type='hidden' name='seat' id='seat' />
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
<script>
function chkRoomTime() {
	if (typeof product == "undefined") { 
		alert('이용권을 석택하세요.')
	} else {
		$.post("./setRoomUseChk.jsp", $("#frmPrice").serialize(), function(data){
			var json = JSON.parse($.trim(data));
			if(json.isSuccess) {
				alert("111");
			} else {
				alert("111222");
			}
			/*
			var json = JSON.parse($.trim(data));
			
			if(json.isSuccess) {
				if("Y" == json.resData[0].RESULT){
					location.href = json.resUrl;	
				} else {
					alertify.alert(json.resMsg);
				}
			} else {
				alertify.alert(json.resMsg);
			}
			*/
		})
		.error(function(){  
			alertify.alert("로그인 중 오류가 발생했습니다.\n시스템 관리자에게 문의하세요.");
		});
	}
}

function goBack() {
	location.href='categoryList.jsp?paramSeqNo=<%=centerNo %>&paramCardNo=<%=cardNo %>&paramRfid=<%=rfidNo %>';
}
</script>

<jsp:include page="../inc/Footer.v2.jsp" flush="false">
	<jsp:param name="param" value=""/>
</jsp:include>

