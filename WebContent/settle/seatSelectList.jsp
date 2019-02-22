<%@page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "kr.co.dw.util.*" %>
<%@ page import = "kr.co.beable.chain.SeatVO" %>
<%@ page import = "kr.co.beable.chain.SeatBean" %>
<%@ page import = "kr.co.beable.settle.LocalSeatVO" %>
<%@ page import = "kr.co.beable.settle.LocalSeatBean" %>
<%@ include file = "/membership/loginSess.jsp" %>
<%
	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
	
	request.setCharacterEncoding("utf-8");
	
	String strTitle 		= "좌석 선택";
	String strLocation 		= "";
	
	String centerNo 		= StrUtil.nvl(request.getParameter("centerNo"), "");		//가맹점 번호
	String cardNo 			= StrUtil.nvl(request.getParameter("cardNo"), "");		//카드번호
	String rfidNo 			= StrUtil.nvl(request.getParameter("rfidNo"), "");		//RFID
	String cardType 		= StrUtil.nvl(request.getParameter("cardType"), "");	//RFID
	String chkRoom 			= StrUtil.nvl(request.getParameter("chkRoom"), "");			//룸타입
	String product 			= StrUtil.nvl(request.getParameter("product"), "");			//PRD_CD _ PRD_NM _ PRICE _ PRD_TIME _ DELAY_YN
	
	System.out.println("centerNo 	: " + centerNo);
	System.out.println("cardNo : " + cardNo);
	System.out.println("rfidNo 	: " + rfidNo);
	System.out.println("chkRoom 	: " + chkRoom);
	System.out.println("product 	: " + product);
	
	ArrayList<SeatVO> arr	= new SeatBean().CM_SEATS_PROC(centerNo); // 해당지점좌석배치표 조회
	ArrayList<LocalSeatVO> arrOcc = new LocalSeatBean().getSeats(centerNo); // 좌석이용현황 조회
	String strCampusRoom	= "";
	
	if (arr!=null && arr.size()>0) {
		for (int i=0; i<arr.size(); i++) {
			SeatVO vo = arr.get(i);
			if (vo.ROOM_CD.equals("C")) {
				strCampusRoom += vo.SEAT;
			}
		}
		strCampusRoom = strCampusRoom.substring(0, strCampusRoom.length()-1);
	}
	/* 좌석이용현황을 조회하여 이용중인 좌석에 X를 추가한다. */
	if (strCampusRoom.length()>0 && arrOcc!=null && arrOcc.size()>0) {
		for (int i=0; i<arrOcc.size(); i++) {
			LocalSeatVO vo = arrOcc.get(i);
			if (vo.USING.equals("Y")) {
				String s = "_" + vo.SEAT + "'";
				strCampusRoom = strCampusRoom.replaceAll(s, " X"+s);
			}
		}
	}
	System.out.println(strCampusRoom);
	
%>
<jsp:include page="../inc/Header.v2.jsp" flush="false">
	<jsp:param name="title" value="<%=java.net.URLEncoder.encode(strTitle, java.nio.charset.StandardCharsets.UTF_8.toString())%>"/>
	<jsp:param name="location" value="<%=java.net.URLEncoder.encode(strLocation, java.nio.charset.StandardCharsets.UTF_8.toString()) %>"/>
</jsp:include>

<link rel='stylesheet' href='price.css?5' />
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
.choice {text-align:left;padding:15px 0;}
.section div > span {padding:10px;font-size:0.8em; }
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
#seat td.X {background-color:#ccc;color:#aaa;cursor:default;}
#seat td.on {background-color:#80191f;border:1px solid #80191f;color:#fff;}
</style>

<link rel="stylesheet" href="${pageContext.request.contextPath}/js/alertify.css?<%=DateUtil.getCurrentDateTimeMilli() %>" type="text/css" media="screen">
<script src="${pageContext.request.contextPath}/js/alertify.js" type="text/javascript"></script>
<script>
var seatTypeAndNo = "";

$(document).ready(function() {
	
	initSeat();
	
	/* initialize campus room */
	function initSeat() {
		var table = "<table>";
		/* todo : create data */
		var seats =[<%=strCampusRoom%>];
		for (var i=0; i<seats.length;i++) {
			table += "<tr>";
			for (var j=0;j<seats[i].length;j++) {
				if (seats[i][j].indexOf("_") < 0) table += "<td class='cell"+seats[i][j]+"'></td>"; 
				else {
					no = seats[i][j].split("_");
					table += "<td class='cell seat "+no[0]+"' seatno='"+seats[i][j]+"'>" +  no[1] +"</td>";
				}
			}
			table += "</tr>";
		}
		table += "</table>";		
		$("#seat").html(table);
	}
	
	/* choice seat */
	$(document).on("click", "#seat td.seat", function(e) {
		
		if (!$(e.target).hasClass("X")) {
			var t = $("#seat td.seat").index(this);
			seatTypeAndNo = $(this).attr("seatno");
			
			$("#chkSeat").val(seatTypeAndNo);
			console.log("t : " + t); // 						<--------------------------- seat type and number
			console.log("seatTypeAndNo : " + seatTypeAndNo); // <--------------------------- seat type and number
			
			$("#seat td.seat").removeClass("on");
			$(this).addClass("on");
			$("#next").removeClass("off");
		}
	});

	$(".back").click(function(){
		var frm = document.frmSettle;
			frm.target = "_self";
			frm.action = 'price_0_List.jsp';
			frm.submit();
	});
	
});

function complete() {
	if (seatTypeAndNo!="") {
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
  	} else {
  		alertify.alert("좌석을 선택하세요.");
   }
}

</script>
<form name='frmSettle' id='frmSettle' method='post'>
<input type='text' name='centerNo' id='centerNo' value='<%=centerNo %>' />
<input type='text' name='cardNo' id='cardNo' value='<%=chkRoom %>' />
<input type='text' name='rfidNo' id='rfidNo' value='<%=rfidNo %>' />
<input type='text' name='cardType' id='cardType' value='<%=cardType %>' />
<input type='text' name='chkRoom' id='chkRoom' value='<%=chkRoom %>' />
<input type='text' name='product' id='product' value='<%=product %>' />
<input type='text' name='chkSeat' id='chkSeat' />
</form>
<div class='back'>&lt;</div>
<div class='section'>
   		<div class='title'>좌석 선택</div>	
		<div class='subtitle'>이용하실 좌석 선택</div>
		<div id='seat'>
		
		</div>
		<div id="next" class='btn off' onclick='complete();'>다음</div>
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

