<%@page contentType="text/html;charset=utf-8"%>
<%@ page import = "org.apache.log4j.Logger" %>
<%@ page import = "java.util.*" %>
<%@ page import = "kr.co.dw.util.*" %>
<%@ page import = "org.json.simple.JSONObject" %>
<%@ page import = "kr.co.beable.customer.*" %>
<%@ page import = "kr.co.dw.des.*" %>
<%@ page import = "kr.co.beable.inf.*" %>
<%
	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);


	Logger logger = Logger.getLogger(this.getClass());

	String strF_id 		= request.getParameter("f_id");
	String strStoreNo	= request.getParameter("franchise");
	
	System.out.println("strF_id : " + strF_id);
	System.out.println("strStoreNo : " + strStoreNo);
	
	int result	 		= new LocalDatabaseBean().CM_STORE_MAKE_CERTIFICATION_PROC(strF_id, strStoreNo);
	
	boolean vResult		= false;
	String vResMsg		= "";
	String vResFid		= strF_id;
	JSONObject json 	= new JSONObject();
	
	if (0 == result) {
		vResult		= true;
		vResMsg		= "인증번호를 전송하였습니다.";
		logger.debug("Reg Success");
	} else {
		vResult		= false;
		vResMsg		= "인증번호 전송 중 오류가 발생했습니다.<br>시스템 관리자에게 문의하세요.";
		
		logger.debug("Reg Error");
	}
	
	json.put("isSuccess"	, vResult);
	json.put("resMsg"		, vResMsg);
	json.put("ResFid"		, vResFid);
	
	out.println(json.toJSONString());
%>