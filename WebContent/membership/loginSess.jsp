<%@page contentType="text/html;charset=utf-8"%>
<%@ page import = "kr.co.dw.util.*" %>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%
	String sessUsrPhoneNo	= StrUtil.nvl((String) session.getAttribute("SESS_USR_PHONE_NO"));
	//String sessStoreNo		= StrUtil.nvl((String) session.getAttribute("SESS_STORE_NO"));
	//String sessCardNO		= StrUtil.nvl((String) session.getAttribute("SESS_CARD_NO"));
	
	String strDateTime		= DateTimeUtil.getCurrentDate("") + DateTimeUtil.getCurrentTime().replaceAll(":", "");
	SimpleDateFormat df		= new SimpleDateFormat("yyyyMMddHHmmss");
	
	long seLstTime	= Long.parseLong(df.format(new Date(session.getLastAccessedTime())));
	int  seMaxTime	= session.getMaxInactiveInterval();
	int  seUseTime	= (int)(Long.parseLong(strDateTime) - seLstTime);
	
	if("".equals(StrUtil.nvl(sessUsrPhoneNo)) || seUseTime > seMaxTime) {
		session.invalidate();
	
		//세션종료 로그인페이지 이동 자바스크립트
		out.println("<script type=\"text/javascript\">");
		out.println("location.href=\""+request.getContextPath() +"/membership/login.jsp\"");
		out.println("</script>");
		if(true) { return; }
	}
%>