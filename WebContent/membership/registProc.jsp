<%@page contentType="text/html;charset=utf-8"%>
<%@ page import = "org.apache.log4j.Logger" %>
<%@ page import = "java.util.*" %>
<%@ page import = "kr.co.dw.util.*" %>
<%@ page import = "org.json.simple.JSONObject" %>
<%@ page import = "kr.co.beable.customer.*" %>
<%@ page import = "kr.co.dw.des.*" %>
<%
	Logger logger = Logger.getLogger(this.getClass());

	String strF_id 		= request.getParameter("f_id");
	String strF_pw 		= request.getParameter("f_pw");
	String strF_ath		= request.getParameter("f_ath");
	String strF_cardno 	= request.getParameter("f_cardno");
	String strFranchise = request.getParameter("franchise");
	
	//logger.debug("회원등록");
	
	boolean vResult		= false;
	String vResMsg		= "";
	String vResUrl		= "";
	JSONObject json 	= new JSONObject();
	
	//가입 중복 체크
	String dupChkMsg = new MemberBean().CM_MEMBER_DUP_CHK_PROC(strFranchise, strF_id, strF_cardno, strF_ath);
	
	if(!"OK".equalsIgnoreCase(dupChkMsg)){
		json.put("isSuccess", false);
		json.put("resMsg", dupChkMsg);
		out.println(json.toJSONString());
		
		logger.debug("Member duplication");
		if(true) {return;}
	}
	
	MemberVO.reqMemberJoinVO reqMemVO = new MemberVO().new reqMemberJoinVO();
	
	reqMemVO.USR_PHONE_NO			  = strF_id;
	reqMemVO.USR_PW					  = DESCrypto.encrypt(strF_pw); 
	reqMemVO.STORE_NO				  = strFranchise;
	reqMemVO.CARD_NO				  = strF_cardno;
	
    String msg = "";
    String url = "";
    
	int intResult = new MemberBean().CM_MEMBER_JOIN_PROC(reqMemVO);
	
	System.out.println("intResult : " + intResult);
	
	if (0 == intResult) {
		vResult		= true;
		vResMsg		= "회원가입 하였습니다.";
		vResUrl		= request.getContextPath()+"/membership/login.jsp";
		
		logger.debug("Reg Success");
	} else {
		vResult		= false;
		vResMsg		= "회원가입 중 오류가 발생했습니다.<br>시스템 관리자에게 문의하세요.";
		
		logger.debug("Reg Error");
	}
	
	json.put("isSuccess"	, vResult);
	json.put("resMsg"		, vResMsg);
	json.put("resUrl"		, vResUrl);
	
	out.println(json.toJSONString());
%>