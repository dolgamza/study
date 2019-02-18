<%@page contentType="text/html;charset=utf-8"%>
<%@ page import = "kr.co.dw.util.*" %>
<%@ page import = "org.json.simple.JSONObject" %>
<%@ page import = "org.json.simple.JSONArray" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "kr.co.beable.chain.*" %>
<%@ include file = "/membership/loginSess.jsp" %>
<%
	//페이징 변수
	String strPage		= StrUtil.getParameter(request.getParameter("strPage"), "1");
	String strPageBlock	= StrUtil.getParameter(request.getParameter("strPageBlock"), "10");
	int intPage			= Integer.parseInt(strPage);
	int intPageBlock	= Integer.parseInt(strPageBlock);
	
	//검색조건 변수
	String strSelFg		= StrUtil.getParameter(request.getParameter("strSelFg"), "");
	String strSelVal	= StrUtil.getParameter(request.getParameter("strSelVal"), "");
	String strMyGubun	= StrUtil.getParameter(request.getParameter("strMyGubun"), "OK");
	
	System.out.println("strMyGubun : " + strMyGubun);
	System.out.println("strMyGubun : " + strMyGubun);
	
	boolean isSuccess	= true;
	JSONArray resData	= new JSONArray();
	JSONObject json 	= new JSONObject();
	int intTotalCnt 	= 0;
	
	ChainVO.reqCenterListVO req = new ChainVO().new reqCenterListVO();
	req.PAGE			= intPage;
	req.BLOCKSIZE		= intPageBlock; 
	req.SEL_FG			= strSelFg;
	req.SEL_VAL			= strSelVal;
	req.USR_PHONE_NO 	= sessUsrPhoneNo;
	req.MY_GUBUN		= strMyGubun;
	ArrayList<ChainVO.resCenterListVO> arrList	= new ChainBean().FC_STORE_SELECT_LIST_PROC(req);
	
	String setMsg		= "";
	
	if (isSuccess) {
		if (arrList != null && arrList.size() > 0) {
			for (int i=0; i<arrList.size(); i++) {
				ChainVO.resCenterListVO VO = (ChainVO.resCenterListVO)arrList.get(i);
				
				if (i == 0)		intTotalCnt = VO.TCNT;
				
				if(!"".equals(VO.USR_PHONE_NO)) { setMsg = "<font color='red'>(카드번호 : "+VO.CARD_NO+")</font>"; }
				else { setMsg = ""; }
				
				JSONObject jsonData		= new JSONObject();
				jsonData.put("RN"			, VO.RN);
				jsonData.put("STORE_NO"		, VO.STORE_NO);
				jsonData.put("STORE_NM"		, VO.STORE_NM);
				jsonData.put("PHONE_NO"		, VO.PHONE_NO);
				jsonData.put("ADDR"			, VO.ADDR);
				jsonData.put("ZIP_CODE"		, VO.ZIP_CODE);
				jsonData.put("COORDINATE"	, VO.COORDINATE);
				jsonData.put("WEB_URL"		, VO.WEB_URL);
				jsonData.put("IMG_URL"		, VO.IMG_URL);
				jsonData.put("USR_PHONE_NO"	, VO.USR_PHONE_NO);
				jsonData.put("CARD_NO"		, VO.CARD_NO);
				jsonData.put("USR_MSG"		, VO.USR_MSG);
				jsonData.put("SET_MSG"		, setMsg);
				jsonData.put("USR_CODE"		, VO.USR_CODE);
				 
				System.out.println(VO.USR_CODE);
				
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