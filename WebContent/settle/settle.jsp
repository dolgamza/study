<%@page contentType="text/html;charset=utf-8"%>
<%@ page import = "kr.co.dw.util.*" %>
<%@ include file = "/membership/loginSess.jsp" %>
<%
	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
	
	String strTitle 	= "";
	String strLocation 	= "";
	
	String strPage		= StrUtil.nvl(request.getParameter("strPage"), "1");
	String strPageBlock	= StrUtil.nvl(request.getParameter("strPageBlock"), "10");
	int intPage			= Integer.parseInt(strPage);
	int intPageBlock	= Integer.parseInt(strPageBlock);
	
	String strSelFg		= StrUtil.nvl(request.getParameter("strSelFg"), "FC_NAME");
	String strSelVal	= StrUtil.nvl(request.getParameter("strSelVal"));
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
	fnSelFgChange("<%= strSelFg %>","<%= strSelVal %>");
	
	$(window).on("load",function() {
		goPage(1);
	});
});

function fnSelFgChange(selFgVal, selVal) {
	var defaltSelFgVal	= "";
	var defaltSelVal 	= "";
	if (selFgVal != null && selFgVal != "") {
		defaltSelFgVal	= selFgVal;
		defaltSelVal	= selVal;
	} else {
		defaltSelFgVal = $("#strSelFg").val();
		defaltSelVal	= "";
	}
	
	if (defaltSelFgVal == "FC_MTHD") {
		$("#strSelVal_0").val("");
		$("#strSelVal_1").val(defaltSelVal);
		$("#strSelVal_2").val("");
		
		$("#strSelVal_0").hide();
		$("#strSelVal_1").show();
		$("#strSelVal_2").hide();
	} else if (defaltSelFgVal == "FC_STAT") {
		$("#strSelVal_0").val("");
		$("#strSelVal_1").val("");
		$("#strSelVal_2").val(defaltSelVal);
		
		$("#strSelVal_0").hide();
		$("#strSelVal_1").hide();
		$("#strSelVal_2").show();
	} else {
		$("#strSelVal_0").val(defaltSelVal);
		$("#strSelVal_1").val("");
		$("#strSelVal_2").val("");
		
		$("#strSelVal_0").show();
		$("#strSelVal_1").hide();
		$("#strSelVal_2").hide();
	}
}

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
	$.post("./settleAjax.jsp", $("#frmSearch").serialize(), function(data){
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
	
	var nextUrl;
	var modifyUrl;
	
	/* 화면 페이징 구현 */
	fnMakPaging(intCurrentPage, intTotalRowNum, $("#strPageBlock").val(), 10, "goPage");
	
	/* 화면 리스트 구현 */
	var listHtml = '<table>';
	listHtml += '<thead>';
	listHtml += '	<tr>';
	listHtml += '		<th>가맹점 이름</th>';
	listHtml += '		<th>핸드폰번호</th>';
	listHtml += '		<th>가맹점 카드번호</th>';
	listHtml += '		<th>상품</th>';
	listHtml += '		<th>좌석번호</th>';
	listHtml += '		<th>결제금액</th>';
	listHtml += '		<th>결제수단</th>';
	listHtml += '		<th>결제일자</th>';
	listHtml += '		<th>결제상태</th>';
	listHtml += '	</tr>';
	listHtml += '</thead>';
	if(jsonList != '' && jsonList.length > 0) {
		listHtml += '<tbody>';
		for (var i = 0; i < jsonList.length; i++) {
			
			listHtml += '<tr>';
			listHtml += '	<td>'+jsonList[i].STORE_NM+'</td>';
			listHtml += '	<td>'+jsonList[i].STR_USR_PHONE_NO+'</td>';
			listHtml += '	<td>'+jsonList[i].CARD_NO+'</td>';
			listHtml += '	<td>'+jsonList[i].STR_PRD_NM+'</td>';
			listHtml += '	<td>'+jsonList[i].STR_SEAT_NM+'</td>';
			listHtml += '	<td>'+jsonList[i].STR_PAY_AMT+'</td>';
			listHtml += '	<td>'+jsonList[i].METHOD_NM+'</td>';
			listHtml += '	<td>'+jsonList[i].PAY_DT+'</td>';
			listHtml += '	<td>'+jsonList[i].STATUS_NM+'</td>';
			listHtml += '</tr>';
		}
		listHtml += '</tbody>';
	} else {
		listHtml += '<tbody><tr><td style="height:30px;">검색 결과가 없습니다.</td></tr></tbody>';
	}
	
	listHtml += '</table>';
	
	$(".list").html(listHtml);
}
</script>

<div class='back' onclick='goBack();'>&lt;</div>
<div class='section'>
   	<div class='title'>결제내역</div>

	<form name="frmSearch" id="frmSearch" method="post">
		<input type="hidden" name="gubun" id="gubun">
		<input type="hidden" name="store_no" id="store_no">
		<input type="hidden" name="store_nm" id="store_nm">
		<input type="hidden" name="strPage" id="strPage">
		<input type="hidden" name="strPageBlock" id="strPageBlock" value="10">
		<div>
			<span>
				<label for='strSelFg'></label>
				<select name='strSelFg' id='strSelFg' class='fa' onChange="fnSelFgChange()">
					<option value="FC_NAME" <%if("FC_NAME".equals(strSelFg)){ out.println("selected");} %>>센터명</option>
					<option value="FC_CARD" <%if("FC_CARD".equals(strSelFg)){ out.println("selected");} %>>카드번호</option>
					<option value="FC_PROD" <%if("FC_PROD".equals(strSelFg)){ out.println("selected");} %>>상품</option>
					<option value="FC_MTHD" <%if("FC_MTHD".equals(strSelFg)){ out.println("selected");} %>>결제수단</option>
					<option value="FC_STAT" <%if("FC_STAT".equals(strSelFg)){ out.println("selected");} %>>결제상태</option>
				</select>
			</span>
			<span>
				<input type='text' name='strSelVal_0' id='strSelVal_0' value="<%= strSelVal %>" class='fb chain_search' placeholder="검색어를 입력하세요.">
				<select name='strSelVal_1' id='strSelVal_1' class='fa' style="display:none">
					<option value="" <%if("".equals(strSelFg)){ out.println("selected");} %>>전체</option>
					<option value="PS007" <%if("PS007".equals(strSelFg)){ out.println("selected");} %>>결제완료</option>
					<option value="PS008" <%if("PS008".equals(strSelFg)){ out.println("selected");} %>>결제실패</option>
				</select>
				<select name='strSelVal_2' id='strSelVal_2' class='fa' style="display:none">
					<option value="" <%if("".equals(strSelFg)){ out.println("selected");} %>>전체</option>
					<option value="PM001" <%if("PM001".equals(strSelFg)){ out.println("selected");} %>>카드결제</option>
					<option value="PM005" <%if("PM005".equals(strSelFg)){ out.println("selected");} %>>카카오페이결제</option>
				</select>
			</span>
			<span><input type='text' value='검색' class='fc' onclick='search();'></span>
		</div>
	</form>
		<div class='list'></div>
		<div id="pagination"></div>
</div>


<jsp:include page="../inc/Footer.v2.jsp" flush="false">
	<jsp:param name="param" value=""/>
</jsp:include>

