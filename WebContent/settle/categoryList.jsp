<%@page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "kr.co.dw.util.*" %>
<%@ page import = "kr.co.beable.chain.SeatVO" %>
<%@ page import = "kr.co.beable.chain.SeatBean" %>
<%@ include file = "/membership/loginSess.jsp" %>
<%
	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
	
	request.setCharacterEncoding("utf-8");
	
	String strTitle 	= "";
	String strLocation 	= "";
	
	String centerNo 	= StrUtil.nvl(request.getParameter("centerNo"), "");	//가맹점 번호
	String cardNo 		= StrUtil.nvl(request.getParameter("cardNo"), "");	//카드번호
	String rfidNo 		= StrUtil.nvl(request.getParameter("rfidNo"), "");	//RFID 번호
	String cardType 	= StrUtil.nvl(request.getParameter("cardType"), "");	//RFID 번호
	
	System.out.println("centerNo : " + centerNo);
	System.out.println("cardNo : " + cardNo);
	System.out.println("rfidNo : " + rfidNo);
	System.out.println("cardType : " + cardType);
	
	
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

/* room */
.choice1 {text-align:left;padding:15px 0;}
.choice2 {text-align:left;padding:15px 0;}
.section div > span {padding:10px;font-size:0.8em; }
.btn {display:inline-block;width:130px;}
.btn.off {border:1px solid #999;background-color:#999;}

/* seat */
#seat table {width:100%;border-spacing:2px;border-collapse:separate;margin-top:0;margin-bottom:30px;}
#seat td {border:1px solid #aaa;background-color:white;width:1%;padding:10px 0;}
#seat td.cell-1 {border:0;}
#seat td.cell0 {background-color:#fafafa;}
#seat td.seat {cursor:pointer;}
#seat td.I {background-color:#fee;}
#seat td.F {background-color:#efe;}
#seat td.N {background-color:#eef;}
#seat td.S {background-color:#fee;}
#seat td.on {background-color:#80191f;border:1px solid #80191f;color:#fff;}
</style>
<script>

$(document).ready(function() {

	$(".choice1 .btn").click(function() {
		
		room = $(this).index();
		
		$("#chkRoom").val(room);
		
		$(".choice1 .btn").addClass("off");
		$(".choice1 .btn").eq(room).removeClass("off");
		$("#next").addClass("off");
		if (room==0) { next(0); } // campus room
		else if(room==1) { next(1); } // study room
		
	});
	
	$(".choice2 .btn").click(function() {
		$(".choice2 .btn").addClass("off");
		$(".choice2 .btn").eq(0).removeClass("off");
		$("#next").addClass("off");
		next(2);
	});
	
	$(".back").click(function(){
		var frm = document.frmSettle;
			frm.target = "_self";
			frm.action = 'center_detail.jsp';
			frm.submit();
	});
	
});

function goBack() {
	location.href='./center_detail.jsp?strFcNo=<%=centerNo %>&strCardNo=<%=cardNo %>';
}

function next(roomtype) {
	var frm = document.frmSettle;
		frm.target = "_self";
		frm.action = 'price_'+roomtype+'_List.jsp';
		frm.submit();
}

</script>
<form name='frmSettle' id='frmSettle' method='post'>
<input type='text' name='centerNo' id='centerNo' value=<%=centerNo %> />
<input type='text' name='cardNo' id='cardNo' value=<%=cardNo %> />
<input type='text' name='rfidNo' id='rfidNo' value=<%=rfidNo %> />
<input type='text' name='cardType' id='cardType' value=<%=cardType %> />
<input type='text' name='delayYN' id='delayYN' />
</form>
<div class='back' onclick='goBack();'>&lt;</div>
<div class='section'>
   		<div class='title'>좌석 선택</div>	

		<div class='subtitle'>이용할 공간</div>
		<div class='choice1'>
			<span class='btn off'>CAMPUS ROOM</span>
			<span class='btn off'>STUDY ROOM</span>
		</div>
		<div>&nbsp;</div>
		<div class='subtitle'>회원권 구입</div>
		<div class='choice2'>
			<span class='btn off'>회원권/할인권</span>
		</div>
</div>

<jsp:include page="../inc/Footer.v2.jsp" flush="false">
	<jsp:param name="param" value=""/>
</jsp:include>

