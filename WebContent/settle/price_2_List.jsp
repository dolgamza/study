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
	
	request.setCharacterEncoding("utf-8");
	
	String strTitle 	= "";
	String strLocation 	= "";
	
	String centerNo 	= StrUtil.nvl(request.getParameter("centerNo"), "1");	//가맹점 번호
	String strcardNo 	= StrUtil.nvl(request.getParameter("cardNo"), "");
	String rfidNo 		= StrUtil.nvl(request.getParameter("rfidNo"), "");
	String cardType 	= StrUtil.nvl(request.getParameter("cardType"), "");
	String chkRoom 		= "C";													//ROOM_CD
	
	System.out.println("centerNo : " + centerNo);
	
	StringBuffer sb = new StringBuffer();
	ArrayList<ProductVO> arr = new ProductBean().PM_PRODUCT_LIST_PROC(centerNo, chkRoom, "B");
	if (arr!=null && arr.size()>0) {
		String strPrdGrpCd = "";
		
		int j = 0;
		for (int i=0; i<arr.size(); i++) {
			ProductVO vo = arr.get(i);
			if (!strPrdGrpCd.equals(vo.PRD_GRP_CD)) {
				if (i!=0) {
					sb.append("--></ul>\n");
				}
				sb.append("<ul>\n<li class='btn title' style='background-image:url(\"../images/settle/"+ vo.PRD_GRP_CD +".png\");'>&nbsp;<br/>&nbsp;</li><!-- \n");
				strPrdGrpCd = vo.PRD_GRP_CD;
				j = 1;
			}
			if (j%3 == 0) {
				sb.append("--><li class='btn hide'>&nbsp;<br/>&nbsp;</li><!-- \n");
				j++;
			}
			sb.append("--><li class='btn off' product='"+ vo.PRD_CD +"_"+ vo.PRD_NM +"_"+ vo.PRICE +"_"+vo.PRD_TIME+"_"+vo.DELAY_YN+"'>"+ vo.PRD_NM +"<br/>"+ StrUtil.addComma(vo.PRICE) +"원</li><!-- \n");
			j++;
		}
		sb.append("--></ul>");
	}
%>
<jsp:include page="../inc/Header.v2.jsp" flush="false">
	<jsp:param name="title" value="<%=java.net.URLEncoder.encode(strTitle, java.nio.charset.StandardCharsets.UTF_8.toString())%>"/>
	<jsp:param name="location" value="<%=java.net.URLEncoder.encode(strLocation, java.nio.charset.StandardCharsets.UTF_8.toString()) %>"/>
</jsp:include>

<link rel='stylesheet' href='price.css?5' />
<link rel="stylesheet" href="${pageContext.request.contextPath}/js/alertify.css?<%=DateUtil.getCurrentDateTimeMilli() %>" type="text/css" media="screen">
<style>
.btn.title {background-color:transparent;border:1px solid transparent;background-size:contain;background-repeat: no-repeat;}
</style>
<script src="${pageContext.request.contextPath}/js/alertify.js" type="text/javascript"></script>
<script type="text/javascript" src="price.js?2" ></script>

<div class='back'>&lt;</div>
<div class='section'>
   		<div class='title'>이용권 선택</div>	
		<div class='subtitle'>_ [캠퍼스룸] 이용권 선택</div>
		<div class='choice'>
		<%=sb.toString() %>
		</div>

		<div class='btn' onclick='complete();'>선택완료</div>
</div>
<form name='frmPrice' id='frmPrice' method='post'>
<input type='text' name='centerNo' id='centerNo' value='<%=centerNo %>' />
<input type='text' name='cardNo' id='cardNo' value='<%=strcardNo %>' />
<input type='text' name='rfidNo' id='rfidNo' value='<%=rfidNo %>' />
<input type='text' name='cardType' id='cardType' value='<%=cardType %>' />
<input type='text' name='chkRoom' id='chkRoom' value='<%=chkRoom %> '/>
<input type='text' name='product' id='product' />
</form>
<!-- popup> -->
<div id="mask"></div>
<div class='pop'>
	<div class='txt'>모든 이용권은 <strong>결제한 즉시</strong><br/>이용시간으로 측정됩니다.</div>
	<div class='btn'>
		<span class='settle'>결제</span>
		<span class='cancel'>취소</span>
	</div>
</div>
<!-- >popup -->
<script>
var product = "";

$(document).ready(function() {
	
	$(".choice li").click(function() {
		//초기화
		$(".list").html("");
		
		t = $(".choice li").index(this);
		
		product = $(this).attr("product");
		
		$("#product").val(product);
		
		$(".choice li").addClass("off");
		$(".choice li").eq(t).removeClass("off");
	});
	
	$(".back").click(function(){
		var frm = document.frmPrice;
			frm.target = "_self";
			frm.action = 'categoryList.jsp';
			frm.submit();
	});
});

function complete() {
	
	if (product!="") {
		var maskHeight = $(document).height();
	    var maskWidth = $(window).width();  
	    $('#mask').css({'width':maskWidth,'height':maskHeight});  
	     	$('#mask').fadeIn(300);      
	     	$('#mask').fadeTo("slow",0.7);
	     	$(".pop").show();
	     	$("html, body").scrollTop(0);
	    $(".pop .settle").click(function() {
	    	var frm = document.frmSettle;
	 		frm.target = "_self";
	 		frm.action = 'inipay.jsp';
	 		frm.submit();
	    });
	    $(".pop .cancel").click(function() {
	    	$('#mask').hide();  
			$(".pop").hide();
	    });
	} else {
		alertify.alert("이용권을 선택하세요.");
	}
}

</script>

<jsp:include page="../inc/Footer.v2.jsp" flush="false">
	<jsp:param name="param" value=""/>
</jsp:include>

