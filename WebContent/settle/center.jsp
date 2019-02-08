<%@page contentType="text/html;charset=utf-8"%>
<%@ page import = "kr.co.dw.util.*" %>
<%@ include file = "/membership/loginSess.jsp" %>
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
%>
<jsp:include page="../inc/Header.v2.jsp" flush="false">
	<jsp:param name="title" value="<%=java.net.URLEncoder.encode(strTitle, java.nio.charset.StandardCharsets.UTF_8.toString())%>"/>
	<jsp:param name="location" value="<%=java.net.URLEncoder.encode(strLocation, java.nio.charset.StandardCharsets.UTF_8.toString()) %>"/>
</jsp:include>

<style>
body {color:#777;}
.rooptop {position:relative;}
.footer {display:none;}

a {text-decoration:none;color:#000;}
a:visited {color:#555;}
a:hover {color:#80191f;}

.back {position:absolute;color:#80191f;font-size:1.4em;top:73px;left:20px;cursor:pointer;}

.section div {width:90%;margin-left:auto;margin-right:auto;margin-bottom:5px;}
.section div.title {margin-top:20px;text-align:center;color:#80191f;font-size:1.4em;margin-bottom:50px;}
.section div.subtitle {margin-top:20px;text-align:left;color:#80191f;font-size:1em;margin-bottom:10px;}

select.fa {width:calc(30% - 17px);}
input.fb {width:calc(50% - 0px);margin:5px;}
input.fc {width:calc(20% - 27px);background-color:#80191f;text-align:center;color:white;padding-right:10px;cursor:pointer;}
.chain_search {margin-bottom:8px;background:url('../images/m.png') no-repeat;background-position:calc(100% - 10px);}

div.list {width:90%;}
.section table {width:100%;margin:2px;}
.section td {background-color:white;border-top:1px solid #ccc;}
.section td.pic {width:160px;height:160px;padding:0;text-align:left;vertical-align:top;}
.section td img {width:100%;height:100%;}
.section td a {color:#80191f;}
.section .chains {text-align:left;color:#000;}

/* responsive web */
@media only screen and (max-width : 1040px) {
.section td.pic {width:120px;height:120px;}
}

/* pagination */ 
#pagination {position:relative;width:90%;height:40px;padding-top:15px;font-size:0.9em;text-align:left;}
#pagination #paging {display:inline-block;position:absolute;}
#pagination #paging .btn {border-radius:14px;padding:4px 10px;vertical-align:middle;color:#000;background-color:#fff;}
#pagination #paging .btn:hover {color:#fff;background-color:#000;}
#pagination #paging .on {background-color:#eee;color:#555;}
</style>

<script src="../js/paging.js" type="text/javascript"></script>
<script type="text/javascript">
$(function(){
	$(window).on("load",function() {
		goPage(1);
	});
});

function goBack() {
	location.href='../customer/';
}

function search() {
	goPage(1);
}

function goPage(i) {
	
	//페이지번호 셋팅
	$("#strPage").val(i);
	
	//리스트 가져오기
	$.post("./centerAjax.jsp", $("#frmSearch").serialize(), function(data){
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
			listHtml += '	<td rowspan="3" class="pic"><img src=""></td>';
			listHtml += '	<td class="chains"><a href="center_detail.jsp?strFcNo='+jsonList[i].STORE_NO+'">'+jsonList[i].STORE_NM+'</a></td>';
			listHtml += '</tr>';
			listHtml += '<tr>';
			listHtml += '	<td class="chains">'+jsonList[i].ADDR+'</td>';
			listHtml += '</tr>';
			listHtml += '<tr>';
			listHtml += '	<td class="chains">'+jsonList[i].PHONE_NO+'</td>';
			listHtml += '</tr>';
		}
	} else {
		listHtml += '<tr><td style="height:150px;">검색 결과가 없습니다.</td></tr>';
	}
	
	listHtml += '</table>';
	
	$(".list").html(listHtml);
}
</script>

<div class='back' onclick='goBack();'>&lt;</div>
<div class='section'>
   	<div class='title'>센터 검색</div>	

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
		<div class='list'></div>
		<div id="pagination"></div>
</div>


<jsp:include page="../inc/Footer.v2.jsp" flush="false">
	<jsp:param name="param" value=""/>
</jsp:include>

