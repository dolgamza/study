<%@page contentType="text/html;charset=utf-8"%>

<ul id="nav_menu" class='menu'>
	<li><span>비에이블스터디카페</span>
		<ul>
			<li><a href="<%=application.getContextPath() %>/cafe/introduce.jsp">소개</a></li>
			<li><a href="<%=application.getContextPath() %>/cafe/greeting.jsp">대표 인사말</a></li>
			<li><a href="<%=application.getContextPath() %>/cafe/group.jsp">조직도</a></li>
			<li><a href="<%=application.getContextPath() %>/cafe/location.jsp">오시는 길</a></li>
		</ul>
	</li>
	<li><span>공간디자인</span>
		<ul>
			<li><a href="<%=application.getContextPath() %>/space/space.jsp?menuToTap=0">캠퍼스</a></li>
			<li><a href="<%=application.getContextPath() %>/space/space.jsp?menuToTap=1">스터디룸</a></li>
			<li><a href="<%=application.getContextPath() %>/space/space.jsp?menuToTap=2">휴게공간</a></li>
			<li><a href="<%=application.getContextPath() %>/space/space.jsp?menuToTap=3">그외</a></li>
		</ul>
	</li>
	<li><span>가맹점안내</span>
		<ul>
			<li><a href="">신규오픈가맹점</a></li>
		</ul>
	</li>
 	<li><span>가맹안내</span>
		<ul>
			<li><a href="">창업운영센터</a></li>
			<li><a href="">창업비전</a></li>
			<li><a href="">센터개설 절차</a></li>
			<li><a href="">가맹문의</a></li>
		</ul>
	</li>
</ul>