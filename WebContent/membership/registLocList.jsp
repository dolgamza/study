<%@page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "kr.co.beable.chain.*" %>
<%
	String strSido          	= request.getParameter("p_sidoCode");
	String strStoreFieldName 	= request.getParameter("p_pos");
	System.out.println("strSido : " + strSido);
	System.out.println("strSido : " + strSido);
	System.out.println("strSido : " + strSido);
	ArrayList<ChainVO.resLocationMapVO> arrMap = new ChainBean().FC_LOCATION_MAP_PROC(strSido, "");
	if(arrMap != null && arrMap.size() > 0){
%>
	var sel = document.getElementById("<%=strStoreFieldName %>");
	sel.length = <%=arrMap.size() %>;
<%

	for(int i=0; i<arrMap.size(); i++){
		ChainVO.resLocationMapVO vo = arrMap.get(i);
%>
		sel.options[<%=i %>] = new Option("<%=vo.STORE_NM %>");
		sel.options[<%=i %>].value = "<%=vo.STORE_NO %>";
<%
	}
} else {
%>
	$("#<%=strStoreFieldName %> option").remove();
<%
}
%>
