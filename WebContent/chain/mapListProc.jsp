<%@page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "kr.co.beable.chain.*" %>
<%@ page import = "kr.co.dw.util.*" %>
<%@ page import = "org.json.simple.JSONObject" %>
<%@ page import = "org.json.simple.JSONArray" %>
<%@ page import = "java.util.ArrayList" %>
<%

	//페이징 변수
	String strPage		= StrUtil.getParameter(request.getParameter("strPage"), "1");
	String strPageBlock	= StrUtil.getParameter(request.getParameter("strPageBlock"), "10");
	int intPage			= Integer.parseInt(strPage);
	int intPageBlock	= Integer.parseInt(strPageBlock);

	String strFcNm 		= request.getParameter("strFcNm");

	boolean isSuccess	= true;
	JSONArray resData	= new JSONArray();
	JSONObject json 	= new JSONObject();
	int intTotalCnt 	= 0;
	
	CenterVO.reqLocationMapVO req = new CenterVO().new reqLocationMapVO();
	req.PAGE		= intPage;
	req.BLOCKSIZE	= intPageBlock;
	req.SEL_FG		= strSelFg;
	req.SEL_VAL		= strSelVal;
	
	ArrayList<ChainVO.reqLocationMapVO> arr = new ChainBean().FC_LOCATION_MAP_PROC("", strFcNm);
	if(arr != null && arr.size() > 0){
		ChainVO.reqLocationMapVO vo = (ChainVO.reqLocationMapVO)arr.get(0);
		
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