<%@page contentType="text/html;charset=utf-8"%>
<%@ page import = "kr.co.dw.util.*" %>
<%@ page import = "org.json.simple.JSONObject" %>
<%@ page import = "org.json.simple.JSONArray" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "kr.co.beable.settle.*" %>
<%@ page import = "org.apache.log4j.Logger" %>
<%@ include file = "/membership/loginSess.jsp" %>
<%
	Logger logger = Logger.getLogger(this.getClass());

	System.out.println("1111111111111111111111111111111");

	int intRtn				= -1;

	String paramSeqNo		= StrUtil.getParameter(request.getParameter("paramSeqNo"), "");
	String seat				= StrUtil.getParameter(request.getParameter("seat"), "");
	String strReserveYmd	= StrUtil.replaceString(StrUtil.getParameter(request.getParameter("strReserveYmd"), ""), "/", "-");
	String strev_hh			= StrUtil.getParameter(request.getParameter("strev_hh"), "");
	String strev_mm			= StrUtil.getParameter(request.getParameter("strev_mm"), "");
	String use_time			= StrUtil.getParameter(request.getParameter("use_time"), "");
	String tot_amt			= StrUtil.getParameter(request.getParameter("tot_amt"), "");
	
	String strStaryYmd		= strReserveYmd + " " + strev_hh + ":" + strev_mm + ":" + "000";
	
	System.out.println("paramSeqNo : " + paramSeqNo);
	System.out.println("seat : " + seat);
	System.out.println("strReserveYmd : " + strReserveYmd);
	System.out.println("strev_hh : " + strev_hh);
	System.out.println("strev_mm : " + strev_mm);
	System.out.println("use_time : " + use_time);
	System.out.println("tot_amt : " + tot_amt);
	
	System.out.println("strStaryYmd : " + strStaryYmd);
	if(true) return;
	
	boolean vResult		= false;
	String vResMsg		= "";
	String vResUrl		= "";
	JSONArray resData	= new JSONArray();
	JSONObject json 	= new JSONObject();
	
	//TM_GET_USING_CHK
	//intRtn = new LocalSeatBean().getUsingStudyRoom(paramSeqNo, seat, strReserveYmd, ); 
	
	/*
	if(null != arr && arr.size() > 0) {
		
		LocalDatabaseInfoVO VO = (LocalDatabaseInfoVO)arr.get(0);
		
		
		
		JSONObject jsonData	= new JSONObject();
		jsonData.put("RESULT"  , VO.RESULT);
		jsonData.put("MSG"     , VO.MSG);
		jsonData.put("RFID"    , VO.RFID);
		jsonData.put("CASH"    , VO.CASH);
		jsonData.put("SD"      , StrUtil.nvl(VO.SD, ""));
		jsonData.put("ED"      , StrUtil.nvl(VO.ED, ""));
		jsonData.put("SIZE"    , VO.SIZE);
		jsonData.put("HP"      , VO.HP);
		jsonData.put("POINT"   , VO.POINT);
		jsonData.put("RFIDINFO", VO.RFIDINFO);
		
		resData.add(jsonData);
		
		vResult		= true;
		if("Y".equalsIgnoreCase(VO.RESULT)){
			vResUrl		= request.getContextPath()+"/settle/center_detail.jsp?strFcNo="+store_no+"&strCardNo="+card_no+"&strRfid="+VO.RFID;	
		} else {
			vResMsg		= "유효하지 않은 카드입니다.<br>카드번호를 확인해주시기 바랍니다.";
		}
		logger.debug("OK");
	} else {
		vResult		= false;
		vResMsg		= "유효하지 않은 카드입니다.<br>카드번호를 확인해주시기 바랍니다.";
		
		logger.debug("NO");
	}
	
	json.put("isSuccess"	, vResult);
	json.put("resMsg"		, vResMsg);
	json.put("resUrl"		, vResUrl);
	json.put("resData"		, resData);
	
	//System.out.println(json.toJSONString());
	out.println(json.toJSONString());
	*/
	
	out.println(json.toJSONString());
	
%>