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

		<div id="comment">모두가 이용하는 공간을 만들자.</div>
	
		<p>
		안녕하세요. 비에이블스터디카페 대표 전보익입니다.<br/>
		창업관련 전화만 하루에 몇 십통씩 받습니다.<br/>
		그만큼 무인스터디카페에 대한 관심이 많아진게 사실입니다.<br/>
		</p>
		<p>
		그렇다해도 창업이라는 중대사에 선불리 접근할 수 없겠지요.<br/> 
		저 또한 많은 분들과 현장속에서 새로운 시작에 대한 고민으로 항상 긴장속에 하루를 보냅니다.<br/>
		</p>
		<p>
		작은 인연으로 시작한 여러분과 비에이블과의 소중한 만남<br/> 
		'더' 많이 듣겠습니다.<br/>
		'더' 많이 뛰겠습니다.<br/>
		</p>
		<p>
		Truly, I hope to, I think so too<br/> 
		진실되게 바랍니다.<br/>
		바람을 결과로 보여드리겠습니다.<br/>
		</p>

	</div>


<jsp:include page="../inc/Footer.jsp" flush="false">
	<jsp:param name="enableLocation" value="1"/>
	<jsp:param name="enableScrollEvent" value="1"/>
</jsp:include>
