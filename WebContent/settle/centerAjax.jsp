<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import = "kr.co.dw.util.*" %>
<%@ page import = "org.json.simple.JSONObject" %>
<%@ page import = "org.json.simple.JSONArray" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "kr.co.beable.center.*" %>
<%
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
	
	CenterVO.reqLocationMapVO req = new CenterVO().new reqLocationMapVO();
	req.PAGE		= intPage;
	req.BLOCKSIZE	= intPageBlock;
	req.SEL_FG		= strSelFg;
	req.SEL_VAL		= strSelVal;
	
	ArrayList<CenterVO.resLocationMapVO> arrList	= new CenterBean().FC_LOCATION_LIST_PROC(req);
	
	if (isSuccess) {
		if (arrList != null && arrList.size() > 0) {
			for (int i=0; i<arrList.size(); i++) {
				CenterVO.resLocationMapVO VO = (CenterVO.resLocationMapVO)arrList.get(i);
				
				if (i == 0)		intTotalCnt = VO.TCNT;
				
				JSONObject jsonData		= new JSONObject();
				jsonData.put("RN"				, VO.RN);
				jsonData.put("FC_NO"			, VO.FC_NO);
				jsonData.put("FC_NM"			, VO.FC_NM);
				jsonData.put("FC_MAIN_TEL_NO"	, VO.FC_MAIN_TEL_NO);
				jsonData.put("FC_ADDR"			, VO.FC_ADDR);
				jsonData.put("FC_ZIP_CODE"		, VO.FC_ZIP_CODE);
				jsonData.put("FC_COORDINATE"	, VO.FC_COORDINATE);
				jsonData.put("FC_HOMEPAGE"		, VO.FC_HOMEPAGE);
				jsonData.put("FC_THUMBNAIL"		, VO.FC_THUMBNAIL);
				
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