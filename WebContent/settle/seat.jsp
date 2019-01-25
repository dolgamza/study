<%@page contentType="text/html;charset=utf-8"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);

String strTitle = "";
String strLocation = "";
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
#seat td.A {background-color:#fee;}
#seat td.B {background-color:#efe;}
#seat td.C {background-color:#eef;}
#seat td.S {background-color:#fee;}
#seat td.on {background-color:#80191f;border:1px solid #80191f;color:#fff;}
</style>

<script>

var room = -1;
var seatTypeAndNo = "";

function goBack() {
	location.href='center_detail.jsp';
}

function next() {
	if (room>-1 && seatTypeAndNo!="") {
		location.href='price_'+room+'.jsp';
	} else {
		alert('choice room and seat!');
	}
}

$(document).ready(function() {
	
	/* initialize campus room */
	function initSeat() {
		var table = "<table>";
		/* todo : create data */
		var seats =[
			['A_1', 'A_2', 'A_3', 'A_4', '-1', '0', 'A_7', 'A_8', 'A_9', '-1', '-1'],
			['-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', 'A_10'],
			['-1', '-1', '-1', 'C_83', '-1', 'C_82', 'C_81', 'C_80', 'C_79', '-1', 'A_11'],
			['-1', '-1', '-1', 'C_74', '-1', 'C_75', 'C_76', 'C_77', 'C_78', '-1', 'A_12'],
			['-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', 'A_13'],
			['-1', '-1', '-1', '-1', 'C_73', 'C_72', 'C_71', 'C_70', 'C_69', '-1', '0'],
			['-1', '-1', '-1', '-1', 'C_64', '0', 'C_66', 'C_67', 'C_68', '-1', 'A_15'],
			['-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', 'A_16'],
			['-1', '-1', '-1', '-1', 'C_63', 'C_62', 'C_61', 'C_60', 'C_59', '-1', 'A_17'],
			['-1', '-1', '-1', '-1', 'C_54', '0', 'C_56', 'C_57', 'C_58', '-1', 'A_18'],
			['A_47', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', 'A_19'],
			['A_48', '-1', 'B_45', 'B_44', '-1', '0', 'B_32', '-1', 'B_31', '-1', 'A_20'],
			['A_49', '-1', 'B_46', 'B_45', '-1', 'B_42', 'B_33', '-1', 'B_30', '-1', 'A_21'],
			['A_50', '-1', 'B_47', 'B_46', '-1', 'B_41', 'B_34', '-1', 'B_29', '-1', '0'],
			['-1', '-1', '-1', '-1', '-1', 'B_40', 'B_35', '-1', 'B_28', '-1', 'A_23'],
			['-1', '-1', '-1', '-1', '-1', 'B_39', 'B_36', '-1', 'B_27', '-1', 'A_24'],
			['-1', '-1', '-1', '-1', '-1', 'B_38', 'B_37', '-1', 'B_26', '-1', 'A_25']
		];
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
	
	/* initialize study room */
	function initStudyRoom() {
		
		seatTypeAndNo = "";
		
		/* todo : create data */
		var seats =['S_1_6인실A', 'S_2_6인실B', 'S_3_4인실A', 'S_4_4인실B'];
	
		var table = "<table>";
		table += "<tr>";
		for (var i=0; i<seats.length;i++) {
			no = seats[i].split("_");
			table += "<td class='cell seat "+no[0]+"' seatno='"+no[0]+"_"+no[1]+"'>" +  no[2] +"</td>";
		}
		table += "</tr>";
		table += "</table>";
		$("#seat").html(table);
	}
	
	/* choice seat */
	$(document).on("click", "#seat td.seat", function() {
		var t = $("#seat td.seat").index(this);
		seatTypeAndNo = $(this).attr("seatno");
		console.log(seatTypeAndNo); // <--------------------------- seat type and number
		$("#seat td.seat").removeClass("on");
		$(this).addClass("on");
		$("#next").removeClass("off");
	});

	/* choice room */
	$(".choice span").click(function() {
		room = $(this).index();
		$(".choice span").addClass("off");
		$(".choice span").eq(room).removeClass("off");
		$("#next").addClass("off");
		if (room==0) { initSeat(); } // campus room
		else { initStudyRoom(); } // study room
	});
	
});

</script>

<div class='back' onclick='goBack();'>&lt;</div>
<div class='section'>
   		<div class='title'>좌석 선택</div>	

		<div class='subtitle'>이용하실 룸 선택</div>

		<div class='choice'>
			<span class='btn off'>CAMPUS ROOM</span>
			<span class='btn off'>STUDY ROOM</span>
		</div>

		<div class='subtitle'>이용하실 좌석 선택</div>

		<div id='seat'>

		</div>

		<div id="next" class='btn off' onclick='next();'>다음</div>
</div>

<jsp:include page="../inc/Footer.v2.jsp" flush="false">
	<jsp:param name="param" value=""/>
</jsp:include>

