<%@page contentType="text/html;charset=utf-8"%>
<%@ page import = "kr.co.dw.util.*" %>
<%@ page import = "org.json.simple.JSONObject" %>
<%@ page import = "org.json.simple.JSONArray" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "kr.co.beable.settle.*" %>
<%@ include file = "/membership/loginSess.jsp" %>
<%
	String paramSeqNo		= StrUtil.getParameter(request.getParameter("paramSeqNo"), "");
	String seat				= StrUtil.getParameter(request.getParameter("seat"), "");
	/*
	String strReserveYmd	= StrUtil.getParameter(request.getParameter("strReserveYmd"), "");
	String strev_hh			= StrUtil.getParameter(request.getParameter("strev_hh"), "");
	String strev_mm			= StrUtil.getParameter(request.getParameter("strev_mm"), "");
	String use_time			= StrUtil.getParameter(request.getParameter("use_time"), "");
	String tot_amt			= StrUtil.getParameter(request.getParameter("tot_amt"), "");
	
	
	System.out.println("paramSeqNo : " + paramSeqNo);
	System.out.println("seat : " + seat);
	System.out.println("strReserveYmd : " + strReserveYmd);
	System.out.println("strev_hh : " + strev_hh);
	System.out.println("strev_mm : " + strev_mm);
	System.out.println("use_time : " + use_time);
	System.out.println("tot_amt : " + tot_amt);
	
	if(true) return;
	
	*/
	boolean isSuccess	= true;
	JSONArray resData	= new JSONArray();
	JSONObject json 	= new JSONObject();
	int intTotalCnt 	= 0;
	
	ArrayList<LocalSeatVO> arrList	= new LocalSeatBean().getReservationStudyRoom(paramSeqNo, seat);
	
	String setMsg		= "";
	
	if (arrList != null && arrList.size() > 0) {
		for (int i=0; i<arrList.size(); i++) {
			
			LocalSeatVO VO = (LocalSeatVO)arrList.get(i);
			
			//if (i == 0)		intTotalCnt = VO.TCNT;
			
			System.out.println(VO.IDX);
			System.out.println(VO.NAME);
			System.out.println(VO.RESERVATION_NAME);
			System.out.println(VO.RESERVATION_TIME);
			System.out.println(VO.CNT);
			System.out.println(VO.RESERVATION_HP);
			System.out.println(VO.RESERVATION);
			System.out.println(VO.SD);
			System.out.println(VO.ED);
			System.out.println(VO.SEAT);
			
			JSONObject jsonData		= new JSONObject();
			jsonData.put("IDX"				, VO.IDX);
			jsonData.put("NAME"				, VO.NAME);
			jsonData.put("RESERVATION_NAME"	, VO.RESERVATION_NAME);
			jsonData.put("RESERVATION_TIME"	, VO.RESERVATION_TIME);
			jsonData.put("CNT"				, VO.CNT);
			jsonData.put("RESERVATION_HP"	, VO.RESERVATION_HP);
			jsonData.put("RESERVATION"		, VO.RESERVATION);
			jsonData.put("HP"				, VO.HP);
			jsonData.put("SD"				, VO.SD);
			jsonData.put("ED"				, VO.ED);
			jsonData.put("SEAT"				, VO.SEAT);
			
			resData.add(jsonData);
		}
		
	}
	isSuccess = true;
	
	json.put("isSuccess"	, isSuccess);
	json.put("intTotalCnt"	, intTotalCnt);
	json.put("resData"		, resData);
	
	out.println(json.toJSONString());
%>