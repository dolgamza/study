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

<link rel='stylesheet' href='price.css?2' />
<script type="text/javascript" src="price.js?1" ></script>

<div class='back' onclick='goBack();'>&lt;</div>
<div class='section'>
   		<div class='title'>이용권 결제</div>	
		<div class='subtitle'>_ [스터디룸] 이용권 선택</div>
		<div class='choice'>
			<ul>
			<li class='btn title'>이용권<br/>&nbsp;</li><!--  
			--><li class='btn hide'>&nbsp;<br/>&nbsp;</li><!--
			--><li class='btn hide'>&nbsp;<br/>&nbsp;</li><!--
			--><li class='btn off'>2인실(1시간)<br/>5,000원</li><!--  
			--><li class='btn off'>4인실(1시간)<br/>8,000원</li><!--  
			--><li class='btn off'>6인실(1시간)<br/>10,000원</li>
			</ul>
		</div>

		<div class='btn' onclick='complete();'>선택완료</div>
</div>

<!-- popup> -->
<div id="mask"></div>
<div class='pop'>
	모든 이용권은 <strong>결제한 즉시</strong> 이용시간으로 측정됩니다.
	<div>
		<span>결제</span>
		<span>취소</span>
	</div>
</div>
<!-- >popup -->

<jsp:include page="../inc/Footer.v2.jsp" flush="false">
	<jsp:param name="param" value=""/>
</jsp:include>

