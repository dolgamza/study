<%@page contentType="text/html;charset=utf-8"%>
<%@ page import = "kr.co.dw.util.*" %>
<%@ page import = "kr.co.dw.des.*" %>
<%@ page import = "org.json.simple.JSONObject" %>
<%@ page import = "org.apache.log4j.Logger" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "kr.co.beable.customer.*" %>
<%
	Logger logger = Logger.getLogger(this.getClass());

	String f_id			= StrUtil.nvl(request.getParameter("f_id"));
	String f_pw			= StrUtil.nvl(request.getParameter("f_pw"));
	
	boolean vResult		= false;
	String vResMsg		= "";
	String vResUrl		= "";
	JSONObject json 	= new JSONObject();
	
	if(f_id.trim().length() < 1 || f_pw.trim().length() < 1) {
		json.put("isSuccess", false);
		json.put("resMsg", "패스워드 정보가 올바르지 않습니다.");
		out.println(json.toJSONString());
		
		logger.debug("f_pw Length is zero");
		if(true) {return;}
	}
	
	//User Password Encryption
	DESCrypto enc			= new DESCrypto();			//암호화 모듈
	String encFpw			= enc.encrypt(f_pw);		//암호화된 패스워드 셋팅
	
	System.out.println("f_id : " + f_id);
	System.out.println("encFpw : " + encFpw);
	
	int intResult = new MemberBean().CM_LOGIN_PWD_CHANGE_PROC(f_id, encFpw);
	
	if (0 == intResult) {
		vResult		= true;
		vResMsg		= "패스워드가 수정 되었습니다.";
		vResUrl		= request.getContextPath()+"/membership/login.jsp";
		
		logger.debug("Reg Success");
	} else {
		vResult		= false;
		vResMsg		= "패스워드 수정 중 오류가 발생했습니다.<br>시스템 관리자에게 문의하세요.";
		
		logger.debug("Reg Error");
	}
	
	json.put("isSuccess"	, vResult);
	json.put("resMsg"		, vResMsg);
	json.put("resUrl"		, vResUrl);
	
	//System.out.println(json.toJSONString());
	out.println(json.toJSONString());
%>