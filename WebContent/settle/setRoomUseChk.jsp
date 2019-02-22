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

	int intRtn				= -1;

	String paramSeqNo		= StrUtil.getParameter(request.getParameter("centerNo"), "");
	String paramSeat  		= StrUtil.getParameter(request.getParameter("chkSeat"), "");
	
	String[] seats    		= paramSeat.split("_");
   	String seat       		= seats[1];
	String strReserveYmd	= StrUtil.replaceString("/", "", StrUtil.getParameter(request.getParameter("strReserveYmd"), ""));
	String strev_hh			= StrUtil.getParameter(request.getParameter("strev_hh"), "");
	String strev_mm			= StrUtil.getParameter(request.getParameter("strev_mm"), "");
	String use_time			= StrUtil.getParameter(request.getParameter("use_time"), "");
	String tot_amt			= StrUtil.getParameter(request.getParameter("tot_amt"), "");
	
	//String strStaryYmd		= strReserveYmd + " " + strev_hh + ":" + strev_mm + ":" + "000";
	
	String strStaryYmd = DateTimeUtil.getCurrentDateTimeMilli_param(strReserveYmd + strev_hh + strev_mm + "00");
	
	System.out.println("paramSeqNo : " + paramSeqNo);
	System.out.println("seat : " + seat);
	System.out.println("strReserveYmd : " + strReserveYmd);
	System.out.println("strev_hh : " + strev_hh);
	System.out.println("strev_mm : " + strev_mm);
	System.out.println("use_time : " + use_time);
	System.out.println("tot_amt : " + tot_amt);
	System.out.println("strStaryYmd : " + strStaryYmd);
	
	boolean vResult		= false;
	String vResMsg		= "";
	String vResUrl		= "";
	JSONObject json 	= new JSONObject();
	
	//TM_GET_USING_CHK
	intRtn = new LocalSeatBean().getUsingStudyRoom(paramSeqNo, seat, strReserveYmd, Integer.parseInt(use_time)); 
		
	if(intRtn == 0){
		logger.debug("OK");
		vResult		= true;
		vResUrl		= "";//request.getContextPath()+"/settle/center_detail.jsp?strFcNo="+store_no+"&strCardNo="+card_no+"&strRfid="+VO.RFID;	
	} else {
		logger.debug("NO");
		vResMsg		= "유효하지 않은 카드입니다.<br>카드번호를 확인해주시기 바랍니다.";
	}
	
	json.put("isSuccess"	, vResult);
	json.put("resMsg"		, vResMsg);
	json.put("resUrl"		, vResUrl);
	json.put("rtnData"		, intRtn);
	
	//System.out.println(json.toJSONString());
	
	out.println(json.toJSONString());
	
%>