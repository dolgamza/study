<%@page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "kr.co.dw.util.*" %>
<%@ page import = "kr.co.beable.chain.ProductVO" %>
<%@ page import = "kr.co.beable.chain.ProductBean" %>
<%@ include file = "/membership/loginSess.jsp" %>
<%
	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
	
	String strTitle 	= "";
	String strLocation 	= "";
	
	
	String centerNo 	= StrUtil.nvl(request.getParameter("centerNo"), "1");	
	String cardNo 		= StrUtil.nvl(request.getParameter("cardNo"), "");
	String rfidNo 		= StrUtil.nvl(request.getParameter("rfidNo"), "1");		
	String chkRoom 		= "S";													

	String strPrdGrpCd = "";
	
	StringBuffer sb = new StringBuffer();
	ArrayList<ProductVO> arr = new ProductBean().PM_PRODUCT_LIST_PROC(centerNo, chkRoom, "C");
	if (arr!=null && arr.size()>0) {
		int j = 0;
		for (int i=0; i<arr.size(); i++) {
			ProductVO vo = arr.get(i);
			if (!strPrdGrpCd.equals(vo.PRD_GRP_CD)) {
				if (i!=0) {
					sb.append("--></ul>\n");
				}
				sb.append("<ul>\n<li class='btn title'>&nbsp;<br/>&nbsp;</li><!-- \n");
				strPrdGrpCd = vo.PRD_GRP_CD;
				j = 1;
			}
			if (j%3 == 0) {
				sb.append("--><li class='btn hide'>&nbsp;<br/>&nbsp;</li><!-- \n");
				j++;
			}
			sb.append("--><li class='btn off' product='"+ vo.PRD_CD +"_"+ vo.PRD_NM +"_"+ vo.PRICE +"'>"+ vo.PRD_NM +"<br/>"+ StrUtil.addComma(vo.PRICE) +"원</li><!-- \n");
			j++;
		}
		sb.append("--></ul>");
	}
%>
<jsp:include page="../inc/Header.v2.jsp" flush="false">
	<jsp:param name="title" value="<%=java.net.URLEncoder.encode(strTitle, java.nio.charset.StandardCharsets.UTF_8.toString())%>"/>
	<jsp:param name="location" value="<%=java.net.URLEncoder.encode(strLocation, java.nio.charset.StandardCharsets.UTF_8.toString()) %>"/>
</jsp:include>

<link rel='stylesheet' href='price.css?6' />
<style>
.choice li.btn {font-size:0.7em;}
</style>
<script src="../js/jquery-ui.js" type="text/javascript"></script>
<script type="text/javascript" src="price.js?20190220" ></script>
<script>
$(document).ready(function() {
	
	$(".choice li").click(function() {
		
		//초기화
		$(".list").html("");
		
		t = $(".choice li").index(this);
		
		product = $(this).attr("product");
		//seat 	= $(this).attr("seat");
		
		$("#product").val(product);
		//$("#seat").val(seat);
		
		$(".choice li").addClass("off");
		$(".choice li").eq(t).removeClass("off");
		
		//goPage();
		
	});
});

</script>
<style>
.btn.title {background-color:transparent;border:1px solid transparent;background-image:url('../images/settle/<%=strPrdGrpCd%>.png');background-size:contain;background-repeat: no-repeat;}
</style>
<div class='back' onclick='goBack();'>&lt;</div>
<div class='section'>
   		<div class='title'>스터디룸 이용권 결제</div>	
		<div class='subtitle'></div>
		<div class='choice'>
		<%=sb.toString() %>
		</div>
		<div class='btn' onclick='setRoom();'>선택완료</div>
</div>
<form name='frmPrice' id='frmPrice' method='post'>
<input type='hidden' name='paramSeqNo' id='paramSeqNo' value='<%=centerNo %>' />
<input type='hidden' name='paramCardNo' id='paramCardNo' value='<%=cardNo %>' />
<input type='hidden' name='paramRfid' id='paramRfid' value='<%=rfidNo %>' />
<input type='hidden' name='product' id='product' />
</form>

<script>

function setRoom() {
	var frm = document.frmPrice;
	
	if (typeof product == "undefined") { 
		alert('이용권을 석택하세요.')
	} else {
		frm.action="roomSelectList.jsp";
		frm.target="_self";
		frm.submit();
	}
}

function goBack() {
	location.href='categoryList.jsp?paramSeqNo=<%=centerNo %>&paramCardNo=<%=cardNo %>&paramRfid=<%=rfidNo %>';
}
</script>

<jsp:include page="../inc/Footer.v2.jsp" flush="false">
	<jsp:param name="param" value=""/>
</jsp:include>

