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
	
	String strTitle 		= "좌석 선택";
	String strLocation 		= "";
	
	String paramSeqNo 		= StrUtil.nvl(request.getParameter("paramSeqNo"), "");	//가맹점 번호
	String paramCardNo 		= StrUtil.nvl(request.getParameter("paramCardNo"), "");	//카드번호
	String paramroomType 	= StrUtil.nvl(request.getParameter("paramroomType"), "");	//룸타입
	
	System.out.println("paramSeqNo : " + paramSeqNo);
	System.out.println("paramCardNo : " + paramCardNo);
	
	ArrayList<SeatVO> arr	= new SeatBean().CM_SEATS_PROC(paramSeqNo); // 해당지점좌석배치표 조회
	ArrayList<LocalSeatVO> arrOcc = new LocalSeatBean().getSeats(paramSeqNo); // 좌석이용현황 조회
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

<script>

var room = -1;
var seatTypeAndNo = "";

function next() {
	if (room>-1 && seatTypeAndNo!="") {
		
		var frm = document.frmSettle;
			frm.target = "_self";
			frm.action = 'price_'+room+'.jsp';
			frm.submit();
			
	} else {
		alert('choice room and seat!');
	}
}

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
			console.log("t : " + t); // <--------------------------- seat type and number
			console.log("seatTypeAndNo : " + seatTypeAndNo); // <--------------------------- seat type and number
			
			$("#seat td.seat").removeClass("on");
			$(this).addClass("on");
			$("#next").removeClass("off");
		}
	});

	$(".back").click(function(){
		location.href="price_0_List.jsp?centerNo="+<%=paramSeqNo %>+"&cardNo="+<%=paramCardNo %>;
	});
	
});

</script>
<form name='frmSettle' id='frmSettle' method='post'>
<input type='hidden' name='centerNo' id='centerNo' value='<%=paramSeqNo %>' />
<input type='hidden' name='chkRoom' id='chkRoom' />
<input type='hidden' name='chkSeat' id='chkSeat' />
</form>
<div class='back' onclick='goBack();'>&lt;</div>
<div class='section'>
   		<div class='title'>좌석 선택</div>	
		<div class='subtitle'>이용하실 좌석 선택</div>
		<div id='seat'>
		
		</div>
		<div id="next" class='btn off' onclick='next();'>다음</div>
</div>

<jsp:include page="../inc/Footer.v2.jsp" flush="false">
	<jsp:param name="param" value=""/>
</jsp:include>

