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

		<h1>안녕하세요. 비에이블스터디카페입니다.</h1>
	
		<p>
			비에이블은 소비자의 니즈에 맞는 공간 디자인을 통해 프리미엄 스터디카페의 트렌드를 주도합니다.<br/>
			＂비에이블 스터디카페＂는 비에이블만의 차별화된 컨셉과 디자인으로 업계 최고의 인테리어를 구축하였습니다.
		</p>
		<p>
			비에이블스터디카페는 넓은 공간에서 여러 회원님들이 함께 공동으로 이용하실 수 있는 자유로운 분위기의 캠퍼스존과 
			단체회의, 그룹스터디 등 어떠한 모임이 가능한 스터디룸 
			그리고 잔잔한 음악이 나오고, 간단한 다과, 조용한 대화가 허용되는 휴식공간을 마련했습니다.
		</p>
		<p>
			비에이블 스터디카페는 단순히 공간을 임대하는 것이 아닌 최적의 플랫폼을 지향하며, 고객의 성공을 가능하게 합니다.<br/>
			비에이블스터디카페와 함께 성공을 향한 한걸음 더 나아가십시오.<br/>
			안정적인 수익구조와 간편한 운영관리 시스템을 찾는다면 지금 바로, 비에이블 스터디카페와 함께 하세요.
		</p>

	</div>


<jsp:include page="../inc/Footer.jsp" flush="false">
	<jsp:param name="enableLocation" value="1"/>
	<jsp:param name="enableScrollEvent" value="1"/>
</jsp:include>
