<%@page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "kr.co.beable.chain.*" %>
<%@ page import = "org.json.simple.JSONObject" %>
<%
	String strLocCode = request.getParameter("strLocCode");

	System.out.println("strLocCode : " + strLocCode);

	boolean isSuccess	= false;
	String strCoodinate	= "";

	JSONObject json = new JSONObject();
	
	ArrayList<ChainVO.reqLocationTapVO> arr = new ChainBean().FC_LOCATION_TAP_PROC(strLocCode);
	if(arr != null && arr.size() > 0){
		ChainVO.reqLocationTapVO vo = (ChainVO.reqLocationTapVO)arr.get(0);
		
		isSuccess = true;
		strCoodinate = vo.MM_LOC_COORDINATE;
		
	} else {
		isSuccess = false;
		strCoodinate = "";
	}
	
	json.put("isSuccess", isSuccess);
	json.put("strCoodinate", strCoodinate);
	
	out.println(json.toJSONString());
%>