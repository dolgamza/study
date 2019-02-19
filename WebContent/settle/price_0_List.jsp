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
	
	String strcardNo 	= StrUtil.nvl(request.getParameter("cardNo"), "");
	String centerNo 	= StrUtil.nvl(request.getParameter("centerNo"), "1");	//가맹점 번호
	String chkRoom 		= "C";													//ROOM_CD

	System.out.println("centerNo : " + centerNo);
	System.out.println("strcardNo : " + strcardNo);


	StringBuffer sb = new StringBuffer();
	String strPrdGrpCd = "";
	ArrayList<ProductVO> arr = new ProductBean().PM_PRODUCT_LIST_PROC(centerNo, chkRoom, "A");
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

<link rel='stylesheet' href='price.css?0.3' />
<style>
.btn.title {background-color:transparent;border:1px solid transparent;background-image:url('../images/settle/<%=strPrdGrpCd%>.png');background-size:contain;background-repeat: no-repeat;}
</style>
<script type="text/javascript" src="price.js?3" ></script>

<div class='back' onclick='goBack();'>&lt;</div>
<div class='section'>
   		<div class='title'>캠퍼스룸 이용권 결제</div>	
		<div class='subtitle'></div>
		<div class='choice'>

<%=sb.toString() %>

		</div>

		<div class="btn" onclick="complete('<%=centerNo %>', '<%=strcardNo %>', '<%=chkRoom %>');">선택완료</div>
</div>
<form name='frmPrice' id='frmPrice' method='post'>
<input type='text' name='centerNo' id='centerNo' value='<%=centerNo %>' />
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
function settle(){
	var frm = document.frmPrice;
	frm.target = "_self";
	frm.action = "inipay.jsp"
	frm.submit();
}

function cancel(){
	location.href='seat.jsp?paramSeqNo=<%=centerNo %>';
}


function goBack() {
	location.href='categoryList.jsp?paramSeqNo=<%=centerNo %>';
}
</script>

<jsp:include page="../inc/Footer.v2.jsp" flush="false">
	<jsp:param name="param" value=""/>
</jsp:include>

