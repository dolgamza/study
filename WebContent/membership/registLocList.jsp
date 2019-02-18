<%@page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "kr.co.beable.chain.*" %>
<%
	String strSido          	= request.getParameter("p_sidoCode");
	String strStoreFieldName 	= request.getParameter("p_pos");

	//PARAM : X 본사제외
	ArrayList<ChainVO.resLocationMapVO> arrMap = new ChainBean().FC_LOCATION_MAP_PROC(strSido, "", "X");
	
	System.out.println(arrMap.size());
	
	
	if(arrMap != null && arrMap.size() > 0){
%>
	var sel = document.getElementById("<%=strStoreFieldName %>");
	sel.length = <%=arrMap.size() %>;
	
<%
	
	for(int i=0; i<arrMap.size(); i++){
		ChainVO.resLocationMapVO vo = arrMap.get(i);
%>
		sel.options[<%=i+1 %>] = new Option("<%=vo.STORE_NM %>");
		sel.options[<%=i+1 %>].value = "<%=vo.STORE_NO %>";
<%
	}
} else {
%>
	$("#<%=strStoreFieldName %> option").remove();
<%
}
%>
