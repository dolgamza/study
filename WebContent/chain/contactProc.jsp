<%@page contentType="text/html;charset=utf-8"%>
<%@ page import = "kr.co.dw.util.*" %>
<%@ page import = "org.json.simple.JSONObject" %>
<%@ page import = "kr.co.beable.chain.*" %>
<%
	String f_name 			= StrUtil.nvl(request.getParameter("f_name"), "");
	String f_mail 			= StrUtil.nvl(request.getParameter("f_mail"), "");
	String f_mail_domain 	= StrUtil.nvl(request.getParameter("f_mail_domain"), "");
	String f_phone 			= StrUtil.nvl(request.getParameter("f_phone"), "");
	String f_bigo 			= StrUtil.nvl(request.getParameter("f_bigo"), "");
	
	boolean vResult		= false;
	String vResMsg		= "";
	String vResUrl		= "";
	JSONObject json 	= new JSONObject();
	
	ChainVO.reqContactUsVO ContactUsVO = new ChainVO().new reqContactUsVO();
	ContactUsVO.F_NAME	= f_name;
	ContactUsVO.F_MAIL	= f_mail + "@" + f_mail_domain;
	ContactUsVO.F_PHONE	= f_phone;
	ContactUsVO.F_BIGO	= f_bigo;
	
	int intResult = new ChainBean().CONTENT_US_PROC(ContactUsVO);
	
	if (0 == intResult) {
		vResult		= true;
		vResMsg		= "신청 되었습니다.";
		vResUrl		= request.getContextPath()+"/chain";
	} else {
		vResult		= false;
		vResMsg		= "신청 중 오류가 발생했습니다.<br>시스템 관리자에게 문의하세요.";
	}
	System.out.println("vResult : " + vResult);
	System.out.println("vResult : " + vResMsg);
	System.out.println("vResult : " + vResUrl);
	json.put("isSuccess"	, vResult);
	json.put("resMsg"		, vResMsg);
	json.put("resUrl"		, vResUrl);
	
	out.println(json.toJSONString());
%>