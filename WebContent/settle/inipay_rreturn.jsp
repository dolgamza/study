<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="java.io.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.sql.SQLException" %>
<%
	/////////////////////////////////////////////////////////////////////////////
	///// 1. GET�� �ޱ�                                                      ////
	/////////////////////////////////////////////////////////////////////////////
	request.setCharacterEncoding("euc-kr");
	String oid = request.getParameter("P_OID");			// ������û ���������� ������ �ֹ���ȣ

%>


<HTML>
 <HEAD>
  <TITLE>INIpay Mobile WEB example</TITLE>
  <META http-equiv="Expires" content="0"/> 
  <META NAME="Author" CONTENT="yw0399">
  <META http-equiv="Content-Type" content="text/html; charset=euc-kr"> 
  <META NAME="Keywords" CONTENT="INICIS MOBILE">
  <META NAME="Description" CONTENT="�̴����� ����� WEB��� P_RETURN_URL ������">
  <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
	<style>
	<!--
	body  {font-family:malgun gothic, ���� ���, ����; color:white; font-size:10pt;}
	table {font-family:malgun gothic, ���� ���, ����;}
	-->
	</style>
 </HEAD>

 <BODY bgcolor="#573296">
<%
out.print("[P_RETURN_URL]<br><br>");
out.print("GET���� ������ �� = " + oid + "<br>");

	//oid�� ������ P_NOTI_URL���� ó����(DB�� �Էµ�) �����͸� �����ͼ� �����ش�.
	//P_NOTI_URL�� ���� ȣ��ǰ�,  P_RETURN_URL�� ȣ��Ǵ� ���̶� �Ϲ����� ���� ������ ������,
	//P_NOTI_URL�� ó���� �����Ǵ� ��찡 �߻��ϸ�, �� �������� ȣ��Ǵ� ������ ����DB�� �����Ͱ� 
	//�������� ���� �� ����. ���� select ����� ���ٰ� ������ ���� �����Ͱ� ���� ���� �ƴ�

	//String SQL_QUERY = "select * from �������̺� where oid = 'oid' ";
	//���� ����
	//if(��������� ������) {
	//	���� ���
	//}
	//else if(��������� ������) {
	//  ó������ ���ɼ� ��� / ���� ���������� ���������� �ٽ� Ȯ���Ͻñ� �ٶ��ϴ�.
	//}

/*
		Connection con = null;
		String url = "jdbc:mysql://localhost:3306/";
		String db = "mobile";
		String driver = "com.mysql.jdbc.Driver";
		try{
		  Class.forName(driver);
		  con = DriverManager.getConnection(url+db,"test","0000");
		  try{
			Statement st = con.createStatement();


			String sql = "select * from mx where P_OID='" + oid + "'";
			ResultSet rs = st.executeQuery(sql);
			while(rs.next()) {
				int uid = rs.getInt("no_id");
				String P_TID = rs.getString("P_TID");
				String P_MID = rs.getString("P_MID");
				String P_AUTH_DT = rs.getString("P_AUTH_DT");
				String P_STATUS = rs.getString("P_STATUS");
				String P_TYPE = rs.getString("P_TYPE");
				String P_OID = rs.getString("P_OID");
				String P_FN_CD1 = rs.getString("P_FN_CD1");
				String P_FN_CD2 = rs.getString("P_FN_CD2");
				String P_FN_NM = rs.getString("P_FN_NM");
				String P_UNAME = rs.getString("P_UNAME");
				String P_AMT = rs.getString("P_AMT");
				String P_RMESG1 = rs.getString("P_RMESG1");
				String P_RMESG2 = rs.getString("P_RMESG2");
				String P_NOTI = rs.getString("P_NOTI");
				String P_AUTH_NO = rs.getString("P_AUTH_NO");
				String P_CARD_ISSUER_CODE = rs.getString("P_CARD_ISSUER_CODE");
				String P_CARD_NUM = rs.getString("P_CARD_NUM");
				out.print("P_TID = " + P_TID + "<br>");
				out.print("P_MID = " + P_MID + "<br>");
				out.print("P_AUTH_DT = " + P_AUTH_DT + "<br>");
				out.print("P_STATUS = " + P_STATUS + "<br>");
				out.print("P_TYPE = " + P_TYPE + "<br>");
				out.print("P_OID = " + P_OID + "<br>");
				out.print("P_FN_CD1 = " + P_FN_CD1 + "<br>");
				out.print("P_FN_CD2 = " + P_FN_CD2 + "<br>");
				out.print("P_FN_NM = " + P_FN_NM + "<br>");
				out.print("P_UNAME = " + P_UNAME + "<br>");
				out.print("P_AMT = " + P_AMT + "<br>");
				out.print("P_RMESG1 = " + P_RMESG1 + "<br>");
				out.print("P_RMESG2 = " + P_RMESG2 + "<br>");
				out.print("P_NOTI = " + P_NOTI + "<br>");
				out.print("P_AUTH_NO = " + P_AUTH_NO + "<br>");
				out.print("P_CARD_ISSUER_CODE = " + P_CARD_ISSUER_CODE + "<br>");
				out.print("P_CARD_NUM = " + P_CARD_NUM + "<br>");

			}


		  }
		  catch (SQLException s){
			//System.out.println("SQL statement is not executed!");
			// SQL �Է½� ������ �߻��ϸ�...
			out.print(""+s.toString());
			//out.print("SQL statement is not executed!");
		  }
		}
		catch (Exception e){
		  e.printStackTrace();
		}
*/

%>


<hr>
<p>Have fun!</p>

 </BODY>
</HTML>
