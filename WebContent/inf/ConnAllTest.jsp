<%@page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import="java.sql.*"%>
<%@ page import = "kr.co.dw.util.*" %>
<%@ page import = "kr.co.beable.inf.*" %>
<%
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);

String strStoreNo 	= StrUtil.nvl(request.getParameter("sn"), "4");
String strUrl 		= new LocalDatabaseBean().CM_STORE_DB_CONN_INFO_PROC(strStoreNo);

if (strUrl.length()>10) {
	Connection conn 				= null;
	WrapPreparedStatementUtil ps	= null;
	ResultSet rs					= null;
		
	try {
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		conn = DriverManager.getConnection(strUrl);
		ps = new WrapPreparedStatementUtil(conn, "SELECT CONVERT(VARCHAR, GETDATE(), 112) AS C01;");
		rs = ps.executeQuery();
		while(rs.next()) {
			out.println(strStoreNo + ":" +rs.getString("C01"));
		}
	} catch (Exception e) {
		System.out.println(e.toString());
	} finally {
		rs.close();
		ps.close();
		conn.close();
	}
} else {
	out.println("잘못된 DB연결정보입니다.");
}


%>
