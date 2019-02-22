<%@page contentType="text/html;charset=utf-8"%>
<%@ page import = "kr.co.dw.util.*" %>
<%@ page import = "org.json.simple.JSONObject" %>
<%@ page import = "org.json.simple.JSONArray" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "kr.co.beable.settle.*" %>
<%@ include file = "/membership/loginSess.jsp" %>
<%
	//페이징 변수
	String strPage		= StrUtil.getParameter(request.getParameter("strPage"), "1");
	String strPageBlock	= StrUtil.getParameter(request.getParameter("strPageBlock"), "10");
	int intPage			= Integer.parseInt(strPage);
	int intPageBlock	= Integer.parseInt(strPageBlock);
	
	//검색조건 변수
	String strSelFg		= StrUtil.getParameter(request.getParameter("strSelFg"), "");
	String strSelVal	= "";
	if ("FC_MTHD".equals(strSelFg)) {
		//결제수단 검색시
		strSelVal = StrUtil.getParameter(request.getParameter("strSelVal_1"), "");
	} else if ("FC_STAT".equals(strSelFg)) {
		//결제상태 검색시
		strSelVal = StrUtil.getParameter(request.getParameter("strSelVal_2"), "");
	} else {
		strSelVal = StrUtil.getParameter(request.getParameter("strSelVal_0"), "");
	}
	
	boolean isSuccess	= true;
	JSONArray resData	= new JSONArray();
	JSONObject json 	= new JSONObject();
	int intTotalCnt 	= 0;
	
	SettleVO.reqSettleListVO req = new SettleVO().new reqSettleListVO();
	req.PAGE			= intPage;
	req.BLOCKSIZE		= intPageBlock; 
	req.USR_PHONE_NO 	= sessUsrPhoneNo;
	req.SEL_FG			= strSelFg;
	req.SEL_VAL			= strSelVal;
	
	ArrayList<SettleVO.resSettleListVO> arrList	= new SettleBean().SM_SETTLE_LIST_PROC(req);
	
	String setMsg		= "";
	
	if (isSuccess) {
		if (arrList != null && arrList.size() > 0) {
			for (int i=0; i<arrList.size(); i++) {
				SettleVO.resSettleListVO VO = (SettleVO.resSettleListVO)arrList.get(i);
				
				if (i == 0)		intTotalCnt = VO.TCNT;
				
				JSONObject jsonData		= new JSONObject();
				jsonData.put("RN"				, VO.RN);
				jsonData.put("STORE_NO"			, VO.STORE_NO);
				jsonData.put("STORE_NM"			, VO.STORE_NM);
				jsonData.put("USR_PHONE_NO"		, VO.USR_PHONE_NO);
				jsonData.put("STR_USR_PHONE_NO"	, DwUtil.addDashPhoneNumber(VO.USR_PHONE_NO));
				jsonData.put("CARD_NO"			, VO.CARD_NO);
				jsonData.put("PRD_GRP_CD"		, VO.PRD_GRP_CD);
				jsonData.put("PRD_GRP_NM"		, VO.PRD_GRP_NM);
				jsonData.put("PRD_CD"			, VO.PRD_CD);
				jsonData.put("PRD_NM"			, VO.PRD_NM);
				jsonData.put("STR_PRD_NM"		, "["+VO.PRD_GRP_NM+"] " + VO.PRD_NM);
				jsonData.put("ROOM_CD"			, VO.ROOM_CD);
				jsonData.put("ROOM_NM"			, VO.ROOM_NM);
				jsonData.put("SEAT_NO"			, VO.SEAT_NO);
				jsonData.put("SEAT_NM"			, VO.SEAT_NM);
				jsonData.put("STR_SEAT_NM"		, ("S".equals(VO.ROOM_CD)) ? VO.SEAT_NM : VO.SEAT_NO);
				jsonData.put("PAY_AMT"			, VO.PAY_AMT);
				jsonData.put("STR_PAY_AMT"		, CurrencyUtil.getCurrency(VO.PAY_AMT));
				jsonData.put("METHOD_CD"		, VO.METHOD_CD);
				jsonData.put("METHOD_NM"		, VO.METHOD_NM);
				jsonData.put("PAY_DT"			, VO.PAY_DT);
				jsonData.put("PAY_DATE"			, VO.PAY_DATE);
				jsonData.put("STATUS_CD"		, VO.STATUS_CD);
				jsonData.put("STATUS_NM"		, VO.STATUS_NM);
				 
				resData.add(jsonData);
			}
			
		}
		isSuccess = true;
	}
	
	json.put("isSuccess"	, isSuccess);
	json.put("intTotalCnt"	, intTotalCnt);
	json.put("resData"		, resData);
	
	out.println(json.toJSONString());
%>