<%@page contentType="text/html;charset=utf-8"%>
<%@ page import = "kr.co.dw.util.*" %>
<%@ page import = "org.json.simple.JSONObject" %>
<%@ page import = "org.apache.log4j.Logger" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "kr.co.beable.customer.*" %>
<%
	Logger logger = Logger.getLogger(this.getClass());

	String f_id			= StrUtil.nvl(request.getParameter("f_id"));
	
	boolean vResult		= false;
	String vResMsg		= "";
	String vResUrl		= "";
	JSONObject json 	= new JSONObject();
	
	if(f_id.trim().length() < 1) {
		json.put("isSuccess", false);
		json.put("resMsg", "아이다가 올바르지 않습니다.");
		out.println(json.toJSONString());
		
		logger.debug("f_id, f_pw Length is zero");
		if(true) {return;}
	}
	
	MemberVO.reqLoginVO req	= new MemberVO().new reqLoginVO();
	req.USR_PHONE_NO		= f_id;  
	req.USR_PW				= "";
	req.GUBUN				= "B";		//*** 로그인시 A / V 패스워드 찾기 시 B ***
	
	ArrayList<MemberVO.resLoginListVO> arr = new MemberBean().CM_USER_LOGIN_PROC(req);
	if(null != arr && arr.size() > 0) {
		vResult		= true;
		vResMsg		= "정상적으로 로그인되었습니다.";
		vResUrl		= request.getContextPath()+"/membership/selfCheck.jsp";
		
		logger.debug("Login Success");
	} else {
		vResult		= false;
		vResMsg		= "로그인 정보가 올바르지 않습니다.";
		
		logger.debug("Login Fail");
	}
	
	json.put("isSuccess"	, vResult);
	json.put("resMsg"		, vResMsg);
	json.put("resUrl"		, vResUrl);
	
	//System.out.println(json.toJSONString());
	out.println(json.toJSONString());
%>