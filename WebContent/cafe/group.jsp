<%@page contentType="text/html;charset=utf-8"%>
<%
String strTitle = "비에이블";
String strLocation = String.format("<a href='%s/'>홈</a> / <a href=%s/cafe/'>홈비에이블스터디카페</a> / <a href='$s/cafe/'>소개</a>", application.getContextPath(), application.getContextPath(), application.getContextPath());
%>
<jsp:include page="../inc/Header.jsp" flush="false">
	<jsp:param name="title" value="<%=java.net.URLEncoder.encode(strTitle, java.nio.charset.StandardCharsets.UTF_8.toString())%>"/>
	<jsp:param name="location" value="<%=java.net.URLEncoder.encode(strLocation, java.nio.charset.StandardCharsets.UTF_8.toString()) %>"/>
</jsp:include>

	<div id="articlecontent">

		<div id="comment">체계적인 인력 구성으로 고객의 만족을 높입니다.</div>
	
		

	</div>


<jsp:include page="../inc/Footer.jsp" flush="false">
	<jsp:param name="enableLocation" value="1"/>
	<jsp:param name="enableScrollEvent" value="1"/>
</jsp:include>
