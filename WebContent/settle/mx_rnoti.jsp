<%@ page  contentType="text/html; charset=euc-kr" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.util.Calendar" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.sql.SQLException" %>


<%



/*******************************************************************************
' FILE NAME : mx_rnoti.jsp
' FILE DESCRIPTION :
' �̴Ͻý� smart phone ���� ��� ���� ������ ����
' ������� : ts@inicis.com
' HISTORY 
' 2010. 02. 25 �����ۼ� 
' 2010  06. 23 WEB ����� ������� ���� ������� ä�� ��� ���� ó�� �߰�(APP ����� �ش� ����!!)
' 2017. 09. 18 ���� IP �߰�
' WEB ����� ��� �̹� P_NEXT_URL ���� ä�� ����� ���� �Ͽ����Ƿ�, 
' �̴Ͻý����� �����ϴ� ������� ä�� ��� ������ ���� �Ͻñ� �ٶ��ϴ�.

'*******************************************************************************/


// �̴Ͻý� NOTI �������� ���� Value
//  P_TID	�ŷ���ȣ
//  P_MID	�������̵�
//  P_AUTH_DT	��������
//  P_STATUS	�ŷ����� (00:����, 01:����)
//  P_TYPE	���Ҽ���
//  P_OID	�����ֹ���ȣ
//  P_FN_CD1	�������ڵ�1
//  P_FN_CD2	�������ڵ�2
//  P_FN_NM	������� (�����, ī����, ������)
//  P_AMT	�ŷ��ݾ�
//  P_UNAME	����������
//  P_RMESG1	����ڵ�
//  P_RMESG2	����޽���
//  P_NOTI	��Ƽ�޽���(�������� �ø� �޽���)
//  P_AUTH_NO	���ι�ȣ

String addr = request.getRemoteAddr().toString();
if("118.129.210.25".equals(addr) || "211.219.96.165".equals(addr) || "118.129.210.24".equals(addr) || "192.168.187.140".equals(addr) || "172.20.22.40".equals(addr) || "127.0.0.1".equals(addr) || "183.109.71.153".equals(addr) || "39.115.212.9".equals(addr) ) //PG���� ���´��� IP�� üũ  118.129.210.24, 192.168.187.140, 172.20.22.40, 127.0.0.1�� �系 ��Ʈ������ �׽�Ʈ�ϱ� ���� �뵵��
{
//**********************************************************************************
//�̺κп� �α����� ��θ� �������ּ���.	
String file_path = "C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\webapps\\ROOT\\company\\inicis\\test_logic\\mx\\jsp\\euckr\\log";  //�α׸� ����� ���͸�
//**********************************************************************************


	P_TID			= request.getParameter("P_TID") + "";   
	P_MID	    	= request.getParameter("P_MID") + "";   
	P_AUTH_DT   	= request.getParameter("P_AUTH_DT") + ""; 
	P_STATUS      	= request.getParameter("P_STATUS") + "";  
	P_TYPE       	= request.getParameter("P_TYPE") + "";    
	P_OID		 	= request.getParameter("P_OID") + "";     
	P_FN_CD1    	= request.getParameter("P_FN_CD1") + "";  
	P_FN_CD2    	= request.getParameter("P_FN_CD2") + "";  
	P_FN_NM     	= request.getParameter("P_FN_NM") + "";   
	P_UNAME     	= request.getParameter("P_UNAME") + "";   
	P_AMT       	= request.getParameter("P_AMT") + "";     
	P_RMESG1      	= request.getParameter("P_RMESG1") + "";  
	P_RMESG2    	= request.getParameter("P_RMESG2") + "";  
	P_NOTI			= request.getParameter("P_NOTI") + "";    
	P_AUTH_NO      	= request.getParameter("P_AUTH_NO") + ""; 

	P_CARD_ISSUER_CODE		= request.getParameter("P_CARD_ISSUER_CODE") + ""; 
	P_CARD_NUM				= request.getParameter("P_CARD_NUM") + ""; 

	/***********************************************************************************
	 ����ó���� ���� �α� ���
	 ������ ���� �����ͺ��̽��� ��� ���������� ���� �����ÿ��� "OK"�� �̴Ͻý��� ���нô� "FAIL" ��
	 �����ϼž��մϴ�. �Ʒ� ���ǿ� �����ͺ��̽� ������ �޴� FLAG ������ ��������
	 (����) OK�� �������� �����ø� �̴Ͻý� ���� ������ "OK"�� �����Ҷ����� ��� �������� �õ��մϴ�
	 ��Ÿ �ٸ� ������ out.println(response.write)�� ���� �����ñ� �ٶ��ϴ�
	***********************************************************************************/
	writeLog(file_path);
	//���� �ҽ��� 91���� �ٷ� ���� �־��ִ� ���̴�. �������� ��ġ��Ų ���� ������� ä���� ���� 
	//��Ƽ �������� ���������� �����ϴ��� �׽�Ʈ�ϱ� �����̴�.
	




	try
	{	
		//WEB ����� ��� ������� ä�� ��� ���� ó��
		//(APP ����� ��� �ش� ������ ���� �Ǵ� �ּ� ó�� �Ͻñ� �ٶ��ϴ�.)		
		/*
		if(P_TYPE.equals("VBANK"))	//���������� ��������̸�
		{
		  if(!P_STATUS.equals("02"))	//�Ա��뺸 "02" �� �ƴϸ�(������� ä�� : 00 �Ǵ� 01 ���)
		  {
		     out.print("OK");
		     return;		  	 
		  }
		
		}	
		*/
/* ������ DB ���̺�
create database mobile;
use mobile;
create table mx(
	no_id int(10) not null auto_increment primary key,
	dt_input date,
	tm_input time,
	P_TID char(40) ,
	P_MID char(10) ,
	P_AUTH_DT char(14), 
	P_STATUS char(4),    
	P_TYPE varchar(10),      
	P_OID varchar(100),	
	P_FN_CD1 varchar(4),
	P_FN_CD2 varchar(10),
	P_FN_NM varchar(50),
	P_UNAME varchar(30),
	P_AMT varchar(8),    
	P_RMESG1 varchar(500),
	P_RMESG2 varchar(500),
	P_NOTI varchar(1024),	
	P_AUTH_NO varchar(30),
	P_CARD_ISSUER_CODE varchar(4),
	P_CARD_NUM varchar(16)
);
*/
		System.out.println("Inserting values in Mysql database table!");
		Connection con = null;
		String url = "jdbc:mysql://localhost:3306/";
		String db = "mobile";
		String driver = "com.mysql.jdbc.Driver";
		try{
		  Class.forName(driver);
		  con = DriverManager.getConnection(url+db,"test","0000");
		  try{
			Statement st = con.createStatement();

			String sql = "INSERT INTO mx ";
			sql += "(P_TID,P_MID,P_AUTH_DT,P_STATUS,P_TYPE,P_OID,P_FN_CD1,P_FN_CD2,P_FN_NM,P_UNAME,P_AMT,P_RMESG1,P_RMESG2,P_NOTI,P_AUTH_NO,P_CARD_ISSUER_CODE,P_CARD_NUM) " ;
			sql += "VALUES ";
			sql += "(";
			sql += "'" + P_TID + "'" + ",";
			sql += "'" + P_MID + "'" + ",";
			sql += "'" + P_AUTH_DT + "'" + ",";
			sql += "'" + P_STATUS + "'" + ",";
			sql += "'" + P_TYPE + "'" + ",";
			sql += "'" + P_OID + "'" + ",";
			sql += "'" + P_FN_CD1 + "'" + ",";
			sql += "'" + P_FN_CD2 + "'" + ",";
			sql += "'" + P_FN_NM + "'" + ",";
			sql += "'" + P_UNAME + "'" + ",";
			sql += "'" + P_AMT + "'" + ",";
			sql += "'" + P_RMESG1 + "'" + ",";
			sql += "'" + P_RMESG2 + "'" + ",";
			sql += "'" + P_NOTI + "'" + ",";
			sql += "'" + P_AUTH_NO + "'" + ",";
			sql += "'" + P_CARD_ISSUER_CODE + "'" + ",";
			sql += "'" + P_CARD_NUM + "'";
			sql += ")";

			int val = st.executeUpdate(sql);
		   // System.out.println("1 row affected");
			// out.print("1 row affected");
			out.print("OK"); // ����� ������ ������ - �� �޽����� �Ա��뺸 OK�޽���
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
  	  

	    
	}
	catch(Exception e)
	{
		out.print(e.getMessage());
	}


}	
%>



<%!

   	//�̴Ͻý� NOTI �������� ���� Value
	String  P_TID;			// �ŷ���ȣ
	String  P_MID;			// �������̵�
	String  P_AUTH_DT;		// ��������
	String  P_STATUS;		// �ŷ����� (00:����, 01:����)
	String  P_TYPE;			// ���Ҽ���
	String  P_OID;			// �����ֹ���ȣ
	String  P_FN_CD1;		// �������ڵ�1
	String  P_FN_CD2;		// �������ڵ�2
	String  P_FN_NM;		// ������� (�����, ī����, ������)
	String  P_AMT;			// �ŷ��ݾ�
	String  P_UNAME;		// ����������
	String  P_RMESG1;		// ����ڵ�
	String  P_RMESG2;		// ����޽���
	String  P_NOTI;			// ��Ƽ�޽���(�������� �ø� �޽���)
	String  P_AUTH_NO;		// ���ι�ȣ

	String  P_CARD_ISSUER_CODE;	// �߱޻��ڵ�
	String  P_CARD_NUM;			// ī���ȣ


    private String getDate()
    {
    	Calendar calendar = Calendar.getInstance();
    	
    	StringBuffer times = new StringBuffer();
        times.append(Integer.toString(calendar.get(Calendar.YEAR)));
		if((calendar.get(Calendar.MONTH)+1)<10)
        { 
            times.append("0"); 
        }
		times.append(Integer.toString(calendar.get(Calendar.MONTH)+1));
		if((calendar.get(Calendar.DATE))<10) 
        {
            times.append("0");	
        } 
		times.append(Integer.toString(calendar.get(Calendar.DATE)));
    	
    	return times.toString();
    }
    
    private String getTime()
    {
    	Calendar calendar = Calendar.getInstance();
    	
    	StringBuffer times = new StringBuffer();

    	times.append("[");
    	if((calendar.get(Calendar.HOUR_OF_DAY))<10) 
        { 
            times.append("0"); 
        } 
 		times.append(Integer.toString(calendar.get(Calendar.HOUR_OF_DAY)));
 		times.append(":");
 		if((calendar.get(Calendar.MINUTE))<10) 
        { 
            times.append("0"); 
        }
 		times.append(Integer.toString(calendar.get(Calendar.MINUTE)));
 		times.append(":");
 		if((calendar.get(Calendar.SECOND))<10) 
        { 
            times.append("0"); 
        }
 		times.append(Integer.toString(calendar.get(Calendar.SECOND)));
 		times.append("]");
 		
 		return times.toString();
    }

    private void writeLog(String file_path) throws Exception
    {

        File file = new File(file_path);
        file.createNewFile();

        FileWriter file2 = new FileWriter(file_path+"/noti_input_"+getDate()+".log", true);


        file2.write("\n************************************************\n");
        file2.write("PageCall time : " 	+ getTime());
        file2.write("\n P_TID : " 	+ P_TID);
		file2.write("\n P_MID : " 	+ P_MID);
		file2.write("\n P_AUTH_DT : " 	+ P_AUTH_DT);
		file2.write("\n P_STATUS : " 	+ P_STATUS);
		file2.write("\n P_TYPE : " 	+ P_TYPE);
		file2.write("\n P_OID : " 	+ P_OID);
		file2.write("\n P_FN_CD1 : " 	+ P_FN_CD1);
		file2.write("\n P_FN_CD2 : " 	+ P_FN_CD2);
		file2.write("\n P_FN_NM : " 	+ P_FN_NM);
		file2.write("\n P_AMT : " 	+ P_AMT);
		file2.write("\n P_UNAME : " 	+ P_UNAME);
		file2.write("\n P_RMESG1 : " 	+ P_RMESG1);
		file2.write("\n P_RMESG2 : " 	+ P_RMESG2);
		file2.write("\n P_NOTI : " 	+ P_NOTI);	
		file2.write("\n P_AUTH_NO : " +	 P_AUTH_NO);	
		file2.write("\n P_CARD_ISSUER_CODE : " +	 P_CARD_ISSUER_CODE);	
		file2.write("\n P_CARD_NUM : " +	 P_CARD_NUM);	
        file2.write("\n************************************************");
		file2.write("\r\n\r\n");
        file2.close();

    }
%>

