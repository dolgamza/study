<%@page contentType="text/html;charset=utf-8"%>
<%@ page import = "kr.co.dw.util.*" %>
<%@ page import = "kr.co.dw.des.*" %>
<%@ page import = "org.json.simple.JSONObject" %>
<%@ page import = "org.apache.log4j.Logger" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "kr.co.beable.customer.*" %>
<%@ include file = "/membership/loginSess.jsp" %>
<%
	Logger logger = Logger.getLogger(this.getClass());

	String strGubun			= StrUtil.nvl(request.getParameter("strGubun"));
	String strStoreNo		= StrUtil.nvl(request.getParameter("strStoreNo"));
	String strFcardno		= StrUtil.nvl(request.getParameter("f_cardno"));
	String msg				= "";
	
	if("M".equalsIgnoreCase(strGubun)) { msg = "변경"; }
	else { msg = "등록"; }
	
	boolean vResult		= false;
	String vResMsg		= "";
	String vResUrl		= "";
	JSONObject json 	= new JSONObject();
	
	System.out.println("strGubun : " + strGubun);
	System.out.println("strStoreNo : " + strStoreNo);
	
	int intResult = new MemberBean().CM_CARDNO_CHANGE_PROC(strStoreNo, sessUsrPhoneNo, strFcardno, strGubun);
	
	if (0 == intResult) {
		vResult		= true;
		vResMsg		= "카드번호를 "+msg+" 하였습니다.";
		vResUrl		= request.getContextPath()+"/settle/center.jsp";
		
		logger.debug("mod Success");
	} else {
		vResult		= false;
		vResMsg		= "카드번호 수정 중 오류가 발생했습니다.<br>시스템 관리자에게 문의하세요.";
		
		logger.debug("Reg Error");
	}
	
	json.put("isSuccess"	, vResult);
	json.put("resMsg"		, vResMsg);
	json.put("resUrl"		, vResUrl);
	
	//System.out.println(json.toJSONString());
	out.println(json.toJSONString());
%>