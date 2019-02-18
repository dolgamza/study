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
<link rel='stylesheet' href='customer.css?0.1.0.9' />
<style>

	.section.bg {background-image:url('../images/customer/bg.jpg');height:500px;background-size:cover;}
	.title:before {content:url('../images/customer/ico.png?1');width:32px;height:32px;}

	select.fa {width:calc(30% - 17px);}
	input.fb {width:calc(50% - 0px);margin:5px;}
	input.fc {width:calc(20% - 27px);background-color:#80191f;text-align:center;color:white;padding-right:10px;cursor:pointer;}
	.chain_search {margin-bottom:8px;background:url('../images/m.png') no-repeat;background-position:calc(100% - 10px);}
  
	/* pagination */ 
	#pagination {position:relative;width:90%;height:40px;padding-top:15px;font-size:0.9em;text-align:left;}
	#pagination #paging {display:inline-block;position:absolute;}
	#pagination #paging .btn {border-radius:3px;padding:4px 6px;vertical-align:middle;color:#000;background-color:#fff;margin-right:3px;}
	#pagination #paging .btn:hover {color:#fff;background-color:#000;}
	#pagination #paging .on {background-color:#80191f;color:#fff;}
</style>
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
	$.post("../settle/centerAjax.jsp", $("#frmSearch").serialize(), function(data){
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
			listHtml += '	<td rowspan="4" class="pic underline"><img src=""></td>';
			listHtml += '	<td colspan="2">'+jsonList[i].STORE_NM+'</td>';
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
			listHtml += '	<th class="underline">홈페이지</th>';
			listHtml += '	<td class="detail underline">'+jsonList[i].WEB_URL+'</td>';
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
    		<div class='title'>_키오스크 이용방법</div>
    		<div class='detail'>
    			<div style='padding:10px 0 20px 0;text-align:left;'><font color='#80191f'>★</font> 1~2시간 이용하셔도 회원카드는 발급받으셔야 합니다.</div>
    			<ol style="margin-left:-20px;">
    					<li>4주 회원권, 금액권, 시간권을 구매하셨다면, 구매 후 좌석배정을 받으셔야 합니다.</li>
    					<li>퇴실(좌석반납)은 다른 이용객을 위한 배려입니다.</li>
    					<li>센터를 재방문하실 예정이면 카드를 반납할 필요는 없습니다.</li>
    					<li>이용시간을 확인하시고, 연장하시려면 꼭 이용시간 내에 진행해 주세요.</li>
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
		   				<span>&lt;회원카드 발급 터치&gt;</span><br/>
		   				<img src='../images/customer/k_01.png'>
		   				<div>회원카드발급 버튼을 터치하여 카드를 발급받습니다.</div>
		   			</div>
		   		</li>
		   		<li>
		   			<div>
		   				<span>2</span>
		   				<span>&lt;이용공간의 선택&gt;</span><br/>
		   				<img src='../images/customer/k_02.png'>
		   				<div>회원카드발급 버튼을 터치하여 카드를 발급받습니다.회원카드발급 버튼을 터치하여 카드를 발급받습니다.</div>
		   			</div>
		   		</li>
		   		<li>
		   			<div>
		   				<span>3</span>
		   				<span>&lt;회원카드 터치&gt;</span><br/>
		   				<img src='../images/customer/k_03.png'>
		   				<div>회원카드발급 버튼을 터치하여 카드를 발급받습니다.</div>
		   			</div>
		   		</li>
		   		<li>
		   			<div>
		   				<span>4</span>
		   				<span>&lt;전화번호 입력&gt;</span><br/>
		   				<img src='../images/customer/k_04.png'>
		   				<div>전화번호를 통해 입출입문자, 퇴실알림문자 서비스 발송, 다양한 이벤트 및 연락의 수단 분실시 이용객과의 소통을 위해 필요한 절차입니다.</div>
		   			</div>
		   		</li>
		   		<li>
		   			<div>
		   				<span>5</span>
		   				<span>&lt;좌석 선택&gt;</span><br/>
		   				<img src='../images/customer/k_05.png'>
		   				<div>회원카드발급 버튼을 터치하여 카드를 발급받습니다.</div>
		   			</div>
		   		</li>
		   		<li>
		   			<div>
		   				<span>6</span>
		   				<span>&lt;결제방법 선택&gt;</span><br/>
		   				<img src='../images/customer/k_06.png'>
		   				<div>회원카드발급 버튼을 터치하여 카드를 발급받습니다.</div>
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
		   				<span>&lt;회원카드 발급 터치&gt;</span><br/>
		   				<img src='../images/customer/k_01.png'>
		   				<div>회원카드발급 버튼을 터치하여 카드를 발급받습니다.</div>
		   			</div>
		   		</li>
		   		<li>
		   			<div>
		   				<span>2</span>
		   				<span>&lt;2/4/6인실 선택&gt;</span><br/>
		   				<img src='../images/customer/k_05.png'>
		   				<div>회원카드발급 버튼을 터치하여 카드를 발급받습니다. 회원카드발급 버튼을 터치하여 카드를 발급받습니다. 회원카드발급 버튼을 터치하여 카드를 발급받습니다.</div>
		   			</div>
		   		</li>
		   		<li>
		   			<div>
		   				<span>3</span>
		   				<span>&lt;시간 선택&gt;</span><br/>
		   				<img src='../images/customer/sr_03.png'>
		   				<div>회원카드발급 버튼을 터치하여 카드를 발급받습니다.</div>
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
   			<div style="overflow:auto;width:100%; height:500px;" class="search_list" tabindex="1">
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
<script src='onloaded.js?02'></script>

<jsp:include page="../inc/Footer.v2.jsp" flush="false">
	<jsp:param name="param" value=""/>
</jsp:include>

