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
	String vIpAddress	= StrUtil.nvl(request.getRemoteHost());
	
	boolean vResult		= false;
	String vResMsg		= "";
	String vResUrl		= "";
	JSONObject json 	= new JSONObject();
	
	if(f_id.trim().length() < 1 || f_pw.trim().length() < 1) {
		json.put("isSuccess", false);
		json.put("resMsg", "로그인 정보가 올바르지 않습니다.");
		out.println(json.toJSONString());
		
		logger.debug("f_id, f_pw Length is zero");
		if(true) {return;}
		//return;
	}
	
	//User Password Encryption
	DESCrypto enc			= new DESCrypto();			//암호화 모듈
	String encFpw			= enc.encrypt(f_pw);		//암호화된 패스워드 셋팅
	
	MemberVO.reqLoginVO req	= new MemberVO().new reqLoginVO();
	req.USR_PHONE_NO		= f_id;  
	req.USR_PW				= encFpw;
	req.GUBUN				= "A";		//*** V 로그인시 A / 패스워드 찾기 시 B ***
	
	System.out.println("encFpw1 : " + req.USR_PHONE_NO);
	System.out.println("encFpw2 : " + req.USR_PW);
	
	ArrayList<MemberVO.resLoginListVO> arr = new MemberBean().CM_USER_LOGIN_PROC(req);
	if(null != arr && arr.size() > 0) {
		MemberVO.resLoginListVO resVO = (MemberVO.resLoginListVO)arr.get(0);
		
		if(f_id.equalsIgnoreCase(resVO.USR_PHONE_NO)){
			
			session.setAttribute("SESS_USR_PHONE_NO"	, resVO.USR_PHONE_NO);
			//session.setAttribute("SESS_MEM_NAME"		, resVO.MEM_NAME);
			session.setAttribute("SESS_STORE_NO"		, resVO.STORE_NO);
			session.setAttribute("SESS_CARD_NO"			, resVO.CARD_NO);
			session.setMaxInactiveInterval(60*60*1); //2hours
			//session.setMaxInactiveInterval(60*60*10); //10hours --테스트때문에 세션시간 증가시킴
			
			MemberVO.reqLoginHistoryVO reqLoginHis	= new MemberVO().new reqLoginHistoryVO();
			reqLoginHis.USR_PHONE_NO			= resVO.USR_PHONE_NO;  
			reqLoginHis.IP_ADDR					= vIpAddress;
			
			boolean loginHisResult = new MemberBean().CM_LOGIN_HIS_PROC(reqLoginHis); //Write History after Login Success
			
			if(loginHisResult){
				vResult		= true;
				vResMsg		= "정상적으로 로그인되었습니다.";
				vResUrl		= request.getContextPath()+"/settle/center.jsp";
				
				logger.debug("Login Success");
			}else{
				vResult		= false;
				vResMsg		= "로그인 중 오류가 발생했습니다.\n시스템 관리자에게 문의하세요.";
				
				logger.debug("Login Error");
			}
			
		}else{
			vResult		= false;
			vResMsg		= "로그인 정보가 올바르지 않습니다.";
			
			logger.debug("Login Fail");
		}
	}else {
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