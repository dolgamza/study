<%@page contentType="text/html;charset=utf-8"%>
<%@ page import = "kr.co.dw.util.*" %>
<%@ page import = "org.json.simple.JSONObject" %>
<%@ page import = "org.json.simple.JSONArray" %>
<%@ page import = "org.apache.log4j.Logger" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "kr.co.beable.inf.*" %>
<%
	Logger logger = Logger.getLogger(this.getClass());

	String store_no		= StrUtil.nvl(request.getParameter("store_no"));
	String card_no		= StrUtil.nvl(request.getParameter("card_no"));
	
	boolean vResult		= false;
	String vResMsg		= "";
	String vResUrl		= "";
	JSONArray resData	= new JSONArray();
	JSONObject json 	= new JSONObject();
	
	ArrayList<LocalDatabaseInfoVO> arr = new LocalDatabaseBean().CM_USER_CARD_CHK_PROC(store_no, card_no);
	
	if(null != arr && arr.size() > 0) {
		
		LocalDatabaseInfoVO VO = (LocalDatabaseInfoVO)arr.get(0);
		
		/*
		System.out.println("RESULT : " + VO.RESULT);
		System.out.println("MSG : " + VO.MSG);
		System.out.println("RFID : " + VO.RFID);
		System.out.println("CASH : " + VO.CASH);
		System.out.println("SD : " + VO.SD);
		System.out.println("ED : " + VO.ED);
		System.out.println("SIZE : " + VO.SIZE);
		System.out.println("HP : " + VO.HP);
		System.out.println("POINT : " + VO.POINT);
		System.out.println("RFIDINFO : " + VO.RFIDINFO);
		*/
		
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
%>