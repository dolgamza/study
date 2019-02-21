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
	String strMyGubun	= StrUtil.getParameter(request.getParameter("strMyGubun"), "OK");
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
.chain_search {margin-bottom:8px;} /* background:url('../images/m.png') no-repeat;background-position:calc(100% - 10px);} */

div.list {width:90%;}
.section table {width:100%;margin:2px;table-layout:fixed;}
.section td {background-color:white;border-top:1px solid #ccc;}
.section td.pic {width:150px;height:150px;padding:0;text-align:left;vertical-align:top;}
.section td img {width:100%;height:100%;}
.section td a {color:#80191f;}
.section td.chains {text-align:left;color:#000;vertical-align:center;}
.section td.chains img {position:absolute;margin-top:0px;} 
.section td.nw {width:200px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;word-wrap:normal;}

/* pagination */ 
#pagination {position:relative;width:90%;height:40px;padding-top:15px;font-size:0.9em;text-align:left;}
#pagination #paging {display:inline-block;position:absolute;}
#pagination #paging .btn {border-radius:3px;padding:4px 6px;vertical-align:middle;color:#000;background-color:#fff;margin-right:3px;}
#pagination #paging .btn:hover {color:#fff;background-color:#000;}
#pagination #paging .on {background-color:#80191f;color:#fff;}

/* responsive web */
@media only screen and (max-width : 1040px) {
.s {font-size:0.75em;}
.section td.chains img {margin-top:-3px;} 
}

</style>

<link rel="stylesheet" href="${pageContext.request.contextPath}/js/alertify.css?0.5" type="text/css" media="screen">
<script src="${pageContext.request.contextPath}/js/alertify.js" type="text/javascript"></script>
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
	$("#strMyGubun").val("NO");
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

function fnCardchk(strStNo, strCardNo){
	
	$("#store_no").val(strStNo);
	$("#card_no").val(strCardNo);
	
	$.post("${pageContext.request.contextPath}/settle/setCardUsingChk.jsp", $("#frmSearch").serialize(), function(data){
		var json = JSON.parse($.trim(data));
		
		if(json.isSuccess) {
			if("Y" == json.resData[0].RESULT){
				location.href = json.resUrl;	
			} else {
				alertify.alert(json.resMsg);
			}
		} else {
			alertify.alert(json.resMsg);
		}
	})
	.error(function(){  
		alertify.alert("로그인 중 오류가 발생했습니다.\n시스템 관리자에게 문의하세요.");
	});
}

function fnMakList(intCurrentPage, intTotalRowNum, jsonList) {
	
	var nextUrl;
	var modifyUrl;
	
	/* 화면 페이징 구현 */
	fnMakPaging(intCurrentPage, intTotalRowNum, $("#strPageBlock").val(), 10, "goPage");
	
	/* 화면 리스트 구현 */
	var listHtml = '<table >';
	if(jsonList != '' && jsonList.length > 0) {
		listHtml += '';
		for (var i = 0; i < jsonList.length; i++) {
			
			if('OK' == jsonList[i].USR_CODE) {
				nextUrl		= '<a href="javascript:fnCardchk(\''+jsonList[i].STORE_NO+'\',\''+jsonList[i].CARD_NO+'\')">';
				modifyUrl 	= '<a href="javascript:cardModify(\'M\',\''+jsonList[i].STORE_NO+'\',\''+jsonList[i].STORE_NM+'\');">&nbsp;<img src="../images/center/card_modify.png" style="width:90px;height:21px"/></a>';
			} else {
				nextUrl 	= '<a href="javascript:msg();">'; 
				modifyUrl 	= '<a href="javascript:cardModify(\'I\',\''+jsonList[i].STORE_NO+'\',\''+jsonList[i].STORE_NM+'\');">&nbsp;<img src="../images/center/card_write.png" style="width:90px;height:21px" /></a>';
			}
			
			listHtml += '<tr>';
			listHtml += '	<td rowspan="4" class="pic"><img src="${pageContext.request.contextPath}'+jsonList[i].IMG_URL+'"></td>';
			listHtml += '	<td class="chains">'+nextUrl+jsonList[i].STORE_NM+'</a></td>';
			listHtml += '</tr>';
			listHtml += '<tr>';
			listHtml += '	<td class="chains nw s">'+jsonList[i].ADDR+'</td>';
			listHtml += '</tr>';
			listHtml += '<tr>';
			listHtml += '	<td class="chains s">'+jsonList[i].PHONE_NO+'</td>';
			listHtml += '</tr>';
			listHtml += '<tr>';
			listHtml += '	<td class="chains s">'+jsonList[i].SET_MSG+modifyUrl+'</td>';
			listHtml += '</tr>';
		}  
	} else {
		listHtml += '<tr><td style="height:150px;">검색 결과가 없습니다.</td></tr>';
	}
	
	listHtml += '</table>';
	
	$(".list").html(listHtml);
}

function msg(){
	alertify.alert('카드번호 등록 후 사용해 주세요.');
}

function cardModify(gubun, store_no, store_nm) {
	
	frm = document.frmSearch;
	
	$("#gubun").val(gubun);
	$("#store_no").val(store_no);
	$("#store_nm").val(store_nm);
	
	frm.target = "_self";
	frm.action = "../membership/cardModify.jsp";
	frm.submit();
	
}
</script>

<div class='back' onclick='goBack();'>&lt;</div>
<div class='section'>
   	<div class='title'>센터 검색</div>	

	<form name="frmSearch" id="frmSearch" method="post">
	<input type="hidden" name="gubun" id="gubun">
	<input type="hidden" name="store_no" id="store_no">
	<input type="hidden" name="store_nm" id="store_nm">
	<input type="hidden" name="card_no" id="card_no">
	<input type="hidden" name="strPage" id="strPage">
	<input type="hidden" name="strPageBlock" id="strPageBlock" value="5">
	<input type="hidden" name="strMyGubun" id="strMyGubun">
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

