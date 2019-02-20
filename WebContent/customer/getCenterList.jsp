<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import = "kr.co.dw.util.*" %>
<%@ page import = "org.json.simple.JSONObject" %>
<%@ page import = "org.json.simple.JSONArray" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "kr.co.beable.chain.*" %>
<%
	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);

	//페이징 변수
	String strPage		= StrUtil.getParameter(request.getParameter("strPage"), "1");
	String strPageBlock	= StrUtil.getParameter(request.getParameter("strPageBlock"), "10");
	int intPage			= Integer.parseInt(strPage);
	int intPageBlock	= Integer.parseInt(strPageBlock);
	
	//검색조건 변수
	String strSelFg		= StrUtil.getParameter(request.getParameter("strSelFg"), "");
	String strSelVal	= StrUtil.getParameter(request.getParameter("strSelVal"), "");
	
	boolean isSuccess	= true;
	JSONArray resData	= new JSONArray();
	JSONObject json 	= new JSONObject();
	int intTotalCnt 	= 0;
	
	ChainVO.reqCenterListVO req = new ChainVO().new reqCenterListVO();
	req.PAGE		= intPage;
	req.BLOCKSIZE	= intPageBlock; 
	req.SEL_FG		= strSelFg;
	req.SEL_VAL		= strSelVal;
	
	System.out.println("intPage : " + intPage);
	System.out.println("intPageBlock : " + intPageBlock);
	System.out.println("strSelFg : " + strSelFg);
	System.out.println("strSelVal : " + strSelVal);
	
	
	ArrayList<ChainVO.resCenterListVO> arrList	= new ChainBean().FC_LOCATION_LIST_PROC(req);
	
	if (isSuccess) {
		if (arrList != null && arrList.size() > 0) {
			for (int i=0; i<arrList.size(); i++) {
				ChainVO.resCenterListVO VO = (ChainVO.resCenterListVO)arrList.get(i);
				
				if (i == 0)		intTotalCnt = VO.TCNT;
				
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