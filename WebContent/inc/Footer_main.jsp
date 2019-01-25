<%@page contentType="text/html;charset=utf-8"%>
<%
request.setCharacterEncoding("utf-8");
String enableLocation = (request.getParameter("enableLocation")!=null)?request.getParameter("enableLocation"):"1";
String enableScrollEvent = (request.getParameter("enableScrollEvent")!=null)?request.getParameter("enableScrollEvent"):"1";
%>
		<iframe id="actionframe" name="actionframe" title="iframe for actions"></iframe>

		<div id="footer">
			<div id="company">비에이블스터디카페 | 641-81-01148 | 대표 전보익<br/>서울 강서구 양천로 583<br> (염창동, 우림블루나인비즈니스센터) , A동 2210호 <br> ☎ 1544-8306</div>
			<div id="copyright">COPYRIGHT&copy;비에이블코리아(주). ALL RIGHTS RESERVED.</div>
		</div>

</div>
	<!-- end of container -->
	<script type="text/javascript">
	var enableLocation = <%=enableLocation%>;
	var enableScrollEvent = <%=enableScrollEvent%>;
	</script>
	<script src="<%=application.getContextPath()%>/js/Drawer.js" type='text/javascript'></script>
	<script src="<%=application.getContextPath()%>/js/ScrollEvent.js" type='text/javascript'></script>
	<script src="<%=application.getContextPath()%>/js/OnLoaded.js" type='text/javascript'></script>
</body>
</html>