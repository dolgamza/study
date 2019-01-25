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

<link rel='stylesheet' href='price.css?3' />
<script type="text/javascript" src="price.js?1" ></script>

<div class='back' onclick='goBack();'>&lt;</div>
<div class='section'>
   		<div class='title'>이용권 결제</div>	
		<div class='subtitle'>_ [캠퍼스룸] 이용권 선택</div>
		<div class='choice'>
			<ul>
			<li class='btn title'>당일권<br/>&nbsp;</li><!--  
			--><li class='btn hide'>&nbsp;<br/>&nbsp;</li><!--
			--><li class='btn hide'>&nbsp;<br/>&nbsp;</li><!--
			--><li class='btn off'>2시간<br/>3,500원</li><!--  
			--><li class='btn off'>4시간<br/>6,000원</li><!--  
			--><li class='btn off'>6시간<br/>8,000원</li><!--  
			--><li class='btn off'>8시간<br/>10,000원</li><!--  
			--><li class='btn off'>당일권<br/>12,000원</li><!--  
			--><li class='btn off'>연장(1시간)<br/>1,500원</li>
			</ul>
			<ul>
			<li class='btn title'>4주권<br/>&nbsp;</li><!--  
			--><li class='btn off'>4주 이용권<br/>160,000원</li>
			</ul>
			<ul>
			<li class='btn title'>시간권<br/>&nbsp;</li><!--  
			--><li class='btn off'>50시간권<br/>80,000원</li><!--  
			--><li class='btn off'>100시간권<br/>150,000원</li><!--  
			--><li class='btn hide'>&nbsp;<br/>&nbsp;</li><!--
			--><li class='btn off'>150시간권<br/>210,000원</li><!--  
			--><li class='btn off'>200시간권<br/>260,000원</li>
			</ul>
			<ul>
			<li class='btn title'>금액권<br/>&nbsp;</li><!--  
			--><li class='btn off'>5만원권<br/>50,000원</li><!--  
			--><li class='btn off'>10만원권<br/>100,000원</li><!--
			--><li class='btn hide'>&nbsp;<br/>&nbsp;</li><!--  
			--><li class='btn off'>15만원권<br/>150,000원</li><!--  
			--><li class='btn off'>20만원권<br/>200,000원</li>
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

