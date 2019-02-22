<%@page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "kr.co.dw.util.*" %>
<%@ page import = "kr.co.beable.customer.*" %>
<%@ include file = "/membership/loginSess.jsp" %>
<%
	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
	
	request.setCharacterEncoding("utf-8");
	
	String strTitle 	= "";
	String strLocation 	= "";
	
	String centerNo 	= StrUtil.nvl(request.getParameter("centerNo"), "");
	String cardNo		= StrUtil.nvl(request.getParameter("cardNo"), "");
	String rfidNo		= StrUtil.nvl(request.getParameter("rfidNo"), "");
	String cardType		= StrUtil.nvl(request.getParameter("cardType"), "");
	
	System.out.println("centerNo : " + centerNo);
	System.out.println("cardNo : " + cardNo);
	System.out.println("rfidNo : " + rfidNo);
	System.out.println("cardType : " + cardType);
	
	CenterVO.resCenterDetailVO vo = null;
	
	ArrayList<CenterVO.resCenterDetailVO> arr = new CenterBean().CM_STORE_DETAIL_PROC(Integer.parseInt(centerNo));
	if(arr != null && arr.size() > 0) {
		vo = (CenterVO.resCenterDetailVO)arr.get(0);
	} else {
		out.println("<script language='javascript'>");
		out.println("location.href='${pageContext.request.contextPath}/settle/center.jsp';");
		out.println("</script>");
	}
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

.space {width:100%;border:1px solid #ccc;}

.section table {width:100%;margin:2px;}
.section th {border-top:2px solid #fff;}
.section td {background-color:white;border-top:2px solid #fff;}
.section td a {color:#80191f;}
.section .chains {text-align:left;color:#000;}

</style>

<script>
$(document).ready(function() {
	
	$(".btn").live("click", function(){
		
		var frm = document.frmCenter;
		
		frm.target = "_self";
		frm.action = "${pageContext.request.contextPath}/settle/categoryList.jsp";
		frm.submit();
	});
	
	$(".back").live("click", function(){
		location.href='${pageContext.request.contextPath}/settle/center.jsp';
	});
	
});
</script>

<div class='back'>&lt;</div>
<div class='section'>
	<div class='title'>센터 검색</div>	
	<div class='subtitle'><%=vo.STORE_NM %></div>
	<div><img src='${pageContext.request.contextPath}<%=vo.IMG_URL %>' class='space'></div>
	<div>
		<table>
			<tr>
				<th>연락처</th>
				<td class='chains'><%=vo.PHONE_NO %></td>
			</tr>
			<tr>
				<th>센터위치</th>
				<td class='chains'><%=vo.ADDR %></td>
			</tr>
		</table>
	</div>

	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dab0208119ff46e1af518efed56ac285"></script>
	<div id="map" style="width:90%;height:450px;border:1px solid #ccc;" tabindex="2"></div>

	<div class='btn'>다음</div>
</div>

<form name="frmCenter" id="frmCenter" method="post">
<%-- <input type="hidden" name="centerNo" id="centerNo" value="<%=centerNo %>" /> --%>
<input type="text" name="centerNo" id="centerNo" value="28" />
<input type="text" name="cardNo" id="cardNo" value="<%=cardNo %>" />
<input type="text" name="rfidNo" id="rfidNo" value="<%=rfidNo %>" />
<input type="text" name="cardType" id="cardType" value="<%=cardType %>" />
</form>

<script>

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
mapOption = { 
    center: new daum.maps.LatLng(<%=vo.COORDINATE %>), // 지도의 중심좌표
    level: 3 // 지도의 확대 레벨
};

var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

//지도, 스카이뷰    
var mapTypeControl = new daum.maps.MapTypeControl();
    map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);

var imageSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png', // 마커이미지의 주소입니다    
imageSize = new daum.maps.Size(24, 35), // 마커이미지의 크기입니다
imageOption = {offset: new daum.maps.Point(13, 40)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imageOption);    	

//마커가 표시될 위치입니다 
var markerPosition  = new daum.maps.LatLng(<%=vo.COORDINATE %>); 

//마커를 생성하고 이미지는 기본 마커 이미지를 사용합니다
var marker = new daum.maps.Marker({
    map: map,
    position: markerPosition,
    image: markerImage
});  

//마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);

map.setDraggable(false);
map.setZoomable(false);
	
</script>

<jsp:include page="../inc/Footer.v2.jsp" flush="false">
	<jsp:param name="param" value=""/>
</jsp:include>

