<%@page contentType="text/html;charset=utf-8"%>
<%@ page import = "kr.co.dw.util.*" %>
<%
	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
	
	String strTitle = "";
	String strLocation = "";
	
	//레알적용시 변경
	String paramFcNo = StrUtil.nvl(request.getParameter("strFcNo"), "1");
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

/**************/

.space {width:100%;border:1px solid #ccc;}


.section table {width:100%;margin:2px;}
.section th {border-top:2px solid #fff;}
.section td {background-color:white;border-top:2px solid #fff;}
.section td a {color:#80191f;}
.section .chains {text-align:left;color:#000;}

</style>

<script>
function goBack() {
	location.href='center.jsp';
}

function next() {
	location.href='seat.jsp?paramSeqNo='+<%=paramFcNo %>;
}

</script>

<div class='back' onclick='goBack();'>&lt;</div>
<div class='section'>
   		<div class='title'>센터 검색</div>	

		<div class='subtitle'>강서센터</div>
		<div><img src='../images/space/bangbae.jpg' class='space'></div>

		<div>
			<table>
			<tr>
				<th>연락처</th>
				<td class='chains'>000-0000-0000</td>
			</tr>
			<tr>
				<th>센터위치</th>
				<td class='chains'>뒤로 돌아 왼쪽</td>
			</tr>
			</table>
		</div>

		<div style='height:150px;border:1px solid #ccc;'>지도</div>

		<div class='btn' onclick='next();'>다음</div>
</div>


<jsp:include page="../inc/Footer.v2.jsp" flush="false">
	<jsp:param name="param" value=""/>
</jsp:include>

