<%@page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "kr.co.dw.util.*" %>
<%@ page import = "kr.co.beable.customer.*" %>
<%
	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
	
	String strTitle 	= "";
	String strLocation 	= "";
	
	String strPage		= StrUtil.getParameter(request.getParameter("strPage"), "1");
	String strPageBlock	= StrUtil.getParameter(request.getParameter("strPageBlock"), "10");
	int intPage			= Integer.parseInt(strPage);
	int intPageBlock	= Integer.parseInt(strPageBlock);
	
	String strSelFg		= StrUtil.getParameter(request.getParameter("strSelFg"), "FC_NAME");
	String strSelVal	= StrUtil.getParameter(request.getParameter("strSelVal"), "");

	String code			= StrUtil.getParameter(request.getParameter("code"), "");
%>
<jsp:include page="../inc/Header.v2.jsp" flush="false">
	<jsp:param name="title" value="<%=java.net.URLEncoder.encode(strTitle, java.nio.charset.StandardCharsets.UTF_8.toString())%>"/>
	<jsp:param name="location" value="<%=java.net.URLEncoder.encode(strLocation, java.nio.charset.StandardCharsets.UTF_8.toString()) %>"/>
</jsp:include>
<link rel='stylesheet' href='customer.css?<%= (new java.util.Date()).toLocaleString()%>' />
<link rel="stylesheet" href="${pageContext.request.contextPath}/js/alertify.css?0.5" type="text/css" media="screen">
<script src="${pageContext.request.contextPath}/js/alertify.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/paging.js" type="text/javascript"></script>
<script type="text/javascript">
$(function(){
	$(window).on("load",function() {
		goPage(1);
	});
});

function search() {
	goPage(1);
}

function goPage(i) {
	
	//페이지번호 셋팅
	$("#strPage").val(i);
	
	//리스트 가져오기
	$.post("./getCenterList.jsp", $("#frmSearch").serialize(), function(data){
		var json = JSON.parse($.trim(data));
		if(json.isSuccess) {
			fnMakList(i, json.intTotalCnt, json.resData);
		} else {
			fnMakList(1, 0, "");
		}
	})
	.error(function(){
		fnMakList(1, 0, "");
	});
}

function fnMakList(intCurrentPage, intTotalRowNum, jsonList) {
	/* 화면 페이징 구현 */
	fnMakPaging(intCurrentPage, intTotalRowNum, $("#strPageBlock").val(), 10, "goPage");
	
	/* 화면 리스트 구현 */
	var listHtml = '<table>';
	if(jsonList != '' && jsonList.length > 0) {
		listHtml += '';
		for (var i = 0; i < jsonList.length; i++) {
			listHtml += '<tr>';
			listHtml += '   <td rowspan="4" class="pic"><img src="${pageContext.request.contextPath}'+jsonList[i].IMG_URL+'"></td>';
			listHtml += '	<td colspan="2" class="nm">'+jsonList[i].STORE_NM+'</td>';
			listHtml += '</tr>';
			listHtml += '<tr>';
			listHtml += '	<th>주소</th>';
			listHtml += '	<td class="detail">'+jsonList[i].ADDR+'</td>';
			listHtml += '</tr>';
			listHtml += '<tr>';
			listHtml += '	<th>전화번호</th>';
			listHtml += '	<td class="detail">'+jsonList[i].PHONE_NO+'</td>';
			listHtml += '</tr>';
			listHtml += '<tr>';
			listHtml += '	<th>홈페이지</th>';
			listHtml += '	<td class="detail homepage">'+jsonList[i].WEB_URL+'</td>';
			listHtml += '</tr>';
		}
	} else {
		listHtml += '<tr><td style="height:150px;">검색 결과가 없습니다.</td></tr>';
	}
	
	listHtml += '</table>';
	
	$(".list").html(listHtml);
}
</script>
<div id="fullpage">
	<div class='section bg'></div>
	<div class="section main-section-2">
    	<div class='slideup'>
    		<img src='../images/main/logo4sub.png' class='subheading_img'/>
    		<div class='subheading'>이용수칙 및 방법</div>
    		<div>&nbsp;<br/>&nbsp;</div>
    		<div class='title'>_키오스크 이용방법</div>
    		<div class='detail nbgfont'>
    			<div style='padding:10px 0 20px 0;text-align:left;font-size:0.8em;font-weight:bold;'><font color='#80191f'>★</font> 1~2시간 이용하셔도 회원카드는 발급받으셔야 합니다.</div>
    			<ol style="margin-left:-20px;">
   					<li>회원권(4주), 금액권, 시간권을 구매 후 좌석을 선택해주세요.</li>
   					<li>퇴실(좌석 반납)은 다른 이용객을 위한 배려입니다.</li>
   					<li>재방문 예정이시면 카드를 반납하지 않으셔도 됩니다.</li>
   					<li>이용 시간을 확인하시고, 연장 시 이용 시간 내에 진행해 주세요.</li>
   				</ol>
    		</div>
    	</div>	
	</div>
	<div class="section main-section-3">
		<div class='slide kiosk'>
			<ul>
		   		<li>
		   			<div>
		   				<span>1</span>
		   				<span>회원카드발급</span><br/>
		   				<img src='../images/customer/k_01.png'>
		   				<div class='nbgfont'>[회원카드 발급] 버튼을 터치하여 카드를 발급받습니다.<br>* 50,000원권 불가</div>
		   			</div>
		   		</li>
		   		<li>
		   			<div>
		   				<span>2</span>
		   				<span>이용공간선택</span><br/>
		   				<img src='../images/customer/k_02.png'>
		   				<div class='nbgfont'>1인석과 스터디룸 중 이용할 공간을 선택합니다.</div>
		   			</div>
		   		</li>
		   		<li>
		   			<div>
		   				<span>3</span>
		   				<span>회원카드터치</span><br/>
		   				<img src='../images/customer/k_03.png'>
		   				<div class='nbgfont'>카드리더기에 회원카드를 터치합니다. 절대 신용카드 투입구에 넣지 마세요.</div>
		   			</div>
		   		</li>
		   		<li>
		   			<div>
		   				<span>4</span>
		   				<span>전화번호입력</span><br/>
		   				<img src='../images/customer/k_04.png'>
		   				<div class='nbgfont'>전화번호를 통해 입출입문자, 퇴실 알림 문자 발송, 다양한 이벤트 및 이용객과의 소통을 위해 필요한 절차입니다.</div>
		   			</div>
		   		</li>
		   		<li>
		   			<div>
		   				<span>5</span>
		   				<span>좌석선택</span><br/>
		   				<img src='../images/customer/k_05.png'>
		   				<div class='nbgfont'>이용하실 좌석을 선택하세요. 커피잔은 이미 좌석 이용 중입니다. 이용 시간 내에 횟수 제한 없이 이동이 가능합니다.</div>
		   			</div>
		   		</li>
		   		<li>
		   			<div>
		   				<span>6</span>
		   				<span>결제방법선택</span><br/>
		   				<img src='../images/customer/k_06.png'>
		   				<div class='nbgfont'>결제방법을 선택하세요. 할인권/회원권을 이용 시 해당 버튼을 터치하세요.</div>
		   			</div>
		   		</li>
	   		</ul>
   		</div>
	</div>
	<div class="section main-section-4">
   		<div class='title'>_스터디룸 이용방법</div>
   		<div class='slide studyroom'>
			<ul>
		   		<li>
		   			<div>
		   				<span>1</span>
		   				<span>스터디룸 선택</span><br/>
		   				<img src='../images/customer/k_01.png'>
		   				<div class='nbgfont'>스터디룸을 터치합니다. 한 분만 카드를 발급합니다. 전화번호를 입력합니다.</div>
		   			</div>
		   		</li>
		   		<li>
		   			<div>
		   				<span>2</span>
		   				<span>공간 선택</span><br/>
		   				<img src='../images/customer/k_05.png'>
		   				<div class='nbgfont'>이용하실 스터디룸을 선택 후 의자 버튼을 터치합니다.</div>
		   			</div>
		   		</li>
		   		<li>
		   			<div>
		   				<span>3</span>
		   				<span>시간 선택</span><br/>
		   				<img src='../images/customer/sr_03.png'>
		   				<div class='nbgfont'>당일 방문 이용에서 시작 시간 및 이용 시간을 설정합니다.</div>
		   			</div>
		   		</li>
		   	</ul>
	   	</div>
	</div>
	<div class="section main-section-5">
		<img src='../images/main/logo4sub.png' class='subheading_img'/>
   		<div class='subheading'>센터찾기</div>
		<div class='all'>
   			<div class='title'>_전체센터</div>
   			<div class="search_list" tabindex="1">
	   			<div class='list_center'>
		   			<table>
		   				<%
		   				ArrayList<CenterVO.resCenterAllVO> arrList = new CenterBean().CM_ALL_STORE_LIST_PROC();
		   				if (arrList != null && arrList.size() > 0) {
		   					for (int i=0; i<arrList.size(); i++) {
		   						CenterVO.resCenterAllVO vo = (CenterVO.resCenterAllVO)arrList.get(i);
		   						
		   						out.println("<tr>");
		   						if("0".equals(vo.LOC_SEQ)){
		   							out.println("<td colspan='2'>"+ vo.STORE_NM +"</td>");	
		   						} else {
		   							out.println("<th>"+ vo.SIGUGUN_NM +"</th>");
			   						out.println("<td class='chains'>"+ vo.STORE_NM +"</td>");
		   						}
		   						out.println("</tr>");
		   						
		   					}
		   				} else {
		   					out.println("<tr>");
		   					out.println("<td colspan='2'>센터가 없습니다.</td>");
		   					out.println("</tr>");
		   				}
		   				%>
		   			</table>
		   		</div>
	   		</div>
   		</div>
   		<div class='search'>
			<div>
				<form name="frmSearch" id="frmSearch" method="post">
					<input type="hidden" name="strPage" id="strPage">
					<input type="hidden" name="strPageBlock" id="strPageBlock" value="5">
					<div>
						<span>
							<label for='strSelFg'></label>
							<select name='strSelFg' id='strSelFg' class='fa'>
								<option value="FC_NAME" <%if("FC_NAME".equals(strSelFg)){ out.println("selected");} %>>센터명</option>
								<option value="FC_TELN" <%if("FC_TELN".equals(strSelFg)){ out.println("selected");} %>>연락처</option>
								<option value="FC_ADDR" <%if("FC_ADDR".equals(strSelFg)){ out.println("selected");} %>>주소</option>
							</select></span><!-- 
						--><span><input type='text' name='strSelVal' id='strSelVal' class='fb chain_search' placeholder="검색어를 입력하세요."></span><!--
						--><span><input type='text' value='검색' class='fc' onclick='search();'></span>
					</div>
				</form>
			</div>
			<div class='list'></div>
			<div id="pagination"></div>
   		</div>
	</div>
</div>

<!-- slide show event -->
<script src='onloaded.js?<%= (new java.util.Date()).toLocaleString()%>'></script>

<jsp:include page="../inc/Footer.v2.jsp" flush="false">
	<jsp:param name="param" value=""/>
</jsp:include>

