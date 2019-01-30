<%@page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "kr.co.dw.util.*" %>
<%@ page import = "kr.co.beable.inf.*" %>
<%
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);
// curl http://localhost:8080/beable/inf/?aaa

LocalDatabaseVO vo 	= new LocalDatabaseVO();
vo.strStoreKey		= StrUtil.nvl(request.getQueryString(), "0");
vo.strServer		= request.getRemoteAddr();

int isSuccess = new LocalDatabaseBean().CM_STORE_SERVER_INS_PROC(vo);
%>
<%=isSuccess%>