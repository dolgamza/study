<%@page contentType="text/html;charset=utf-8"%>
<%@page import = "kr.co.dw.util.*" %>
<%
String strTitle = "비에이블";
String strLocation = String.format("<a href='%s/'>홈</a> / <a href=%s/space/'>공간 디자인</a> / <a href='$s/cafe/'>캠퍼스</a>", application.getContextPath(), application.getContextPath(), application.getContextPath());

System.out.println(application.getContextPath());

//SafeUtil safeUtil = new SafeUtil(request, response);
//String menuToTap = safeUtil.getParamSafe(request.getParameter("menuToTap"), "0", 0);
String menuToTap = StrUtil.nvl(request.getParameter("menuToTap"), "0");
%>
<jsp:include page="../inc/Header.jsp" flush="false">
	<jsp:param name="title" value="<%=java.net.URLEncoder.encode(strTitle, java.nio.charset.StandardCharsets.UTF_8.toString())%>"/>
	<jsp:param name="location" value="<%=java.net.URLEncoder.encode(strLocation, java.nio.charset.StandardCharsets.UTF_8.toString()) %>"/>
</jsp:include>
<script src="<%=application.getContextPath() %>/js/lazyload.min.js"></script>
<script src="<%=application.getContextPath() %>/js/lazyload.js"></script>
	<div id="articlecontent">

		<ul class='tab'>  
			<li>캠퍼스</li>
			<li>스터디룸</li>
			<li>휴게공간</li>
			<li>그외</li>
		</ul>
		<ul class='item_list'></ul>
	</div>
	
	<script type="text/javascript">
	
	$(document).ready(function() {
		
		loadContent(<%=menuToTap %>);
		
		$(".tab li").click(function() {
			$(".tab li").removeClass("selected");
			loadContent($(".tab li").index(this));
		});
		
	});
	
	function loadContent(idx) {
		
		var strhtml = "";
		var tapcd = idx+1;
		
		$.get("${pageContext.request.contextPath}/space/SpImageListProc.jsp?tapCode="+tapcd, function(data){
			var json = JSON.parse($.trim(data));
			
			if(json.resData != null && json.resData.length > 0){
				for(var i=0; i<json.resData.length; i++){
					strhtml += "<li><a href='#'><img data-src='${pageContext.request.contextPath}/images/space/"+json.resData[i].IMG_URL+"'></a><span>"+json.resData[i].IMG_NM+"</span></li>";
				}
				$(".item_list").html(strhtml);
				//lazyload();
			} else {
				$(".addview").hide();
			}
		})
		.error(function(){
			console.log("리스트 생성 중 오류 발생 \n시스템 관리자에게 문의하세요.");
		});
		
		$(".tab li").eq(idx).addClass("selected");
	}
	
	</script>


<jsp:include page="../inc/Footer.jsp" flush="false">
	<jsp:param name="enableLocation" value="1"/>
	<jsp:param name="enableScrollEvent" value="1"/>
</jsp:include>
