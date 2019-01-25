<%@page contentType="text/html;charset=utf-8"%>
<%@ page import = "kr.co.dw.util.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "kr.co.beable.space.*" %>
<%@ page import = "org.json.JSONArray" %>
<%@ page import = "org.json.JSONObject" %>
<%
	SafeUtil safeUtil 	= new SafeUtil(request, response);
	String tapCode 		= safeUtil.getParamSafe(request.getParameter("tapCode"), "1", 1);
	
	if("Na".equals(tapCode)) tapCode = "1"; 
	ArrayList<SpaceVO> arr 	= new SpaceBean().SP_IMAGE_LIST_PROC(tapCode);
	
	JSONObject jsonResult	= new JSONObject();
	JSONArray jsonArry		= new JSONArray();
	
	if(arr != null && arr.size() > 0){
		for(int i=0; i<arr.size(); i++){
			SpaceVO vo = (SpaceVO)arr.get(i);
			
			JSONObject data = new JSONObject();
			
			data.put("SEQNO", vo.SEQNO);
			data.put("TAP_GUBUN", vo.TAP_GUBUN);
			data.put("IMG_NM", vo.IMG_NM);
			data.put("IMG_URL", vo.IMG_URL);
			data.put("WRITE_DT", vo.WRITE_DT);
			data.put("WRITE_USER", vo.WRITE_USER);
			data.put("MODIFY_DT", vo.MODIFY_DT);
			data.put("MODIFY_USER", vo.MODIFY_USER);
			data.put("USE_YN", vo.USE_YN);
			
			jsonArry.put(data);
			
		}
		
		jsonResult.put("resData", jsonArry);
		
	} else {
		jsonResult.put("resData", "");
	}
	
	out.println(jsonResult.toString());
%>
