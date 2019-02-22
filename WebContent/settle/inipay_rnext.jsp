<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "java.io.*" %>
<%@ page import = "java.util.HashMap"%>
<%@ page import = "java.util.ArrayList"%>
<%@ page import = "kr.co.dw.util.*" %>
<%@ page import = "org.apache.commons.httpclient.*" %>
<%@ page import = "org.apache.commons.httpclient.methods.*" %>
<%@ page import = "org.apache.commons.httpclient.methods.GetMethod" %> 
<%@ page import = "org.apache.commons.httpclient.params.HttpMethodParams" %>
<%@ page import = "org.json.JSONArray" %>
<%@ page import = "org.json.XML" %>
<%@ page import = "org.json.JSONObject" %>
<%@ page import = "kr.co.beable.settle.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%
	/////////////////////////////////////////////////////////////////////////////
	///// 1. ���� �ʱ�ȭ �� POST ������ ����                                 ////
	/////////////////////////////////////////////////////////////////////////////
	request.setCharacterEncoding("euc-kr");

	String P_STATUS		= StrUtil.nvl(request.getParameter("P_STATUS"));			// ���� ����
	String P_RMESG1		= StrUtil.nvl(request.getParameter("P_RMESG1"));			// ���� ��� �޽���
	String P_TID		= StrUtil.nvl(request.getParameter("P_TID"));				// ���� �ŷ���ȣ
	String P_REQ_URL	= StrUtil.nvl(request.getParameter("P_REQ_URL"));			// ������û URL
	String P_NOTI		= StrUtil.nvl(request.getParameter("P_NOTI"));				// ��Ÿ�ֹ�����
	
	/////////////////////////////////////////////////////////////////////////////
	///// 2. ���� ���̵� ���� :                                              ////
	/////    ������û ���������� ����� MID���� �����ϰ� �����ؾ� ��...      ////
	/////////////////////////////////////////////////////////////////////////////
	String P_MID = "INIpayTest";  
	

if(P_STATUS.equals("01")) {
	// ��������� ������ ���
	System.out.println("Auth Fail : "+P_RMESG1);
	
	String strResultNoti	= StrUtil.nvl(P_NOTI);			//PG���� ���� - �ֹ����� (centerNo=centerNo��|cardNo=cardNo��|chkRoom=chkRoom��|chkSeat=chkSeat|product=product|eMail=eMail|mobileNo=mobileNo)
	
	//P_NOTI ��
	//centerNo		-> 0
	//cardNo		-> 1
	//rfidNo		-> 2
	//cardType		-> 3
	//chkRoom		-> 4
	//product		-> 5
	//chkSeat		-> 6
	//reserveYmd	-> 7
	//reserveTime	-> 8
	//eMail			-> 9
	//mobileNo		-> 10
	//payMethod		-> 11
	String[] arrNoti = strResultNoti.split("[|]");
	
	String strStoreNo		= StrUtil.nvl(arrNoti[0].substring(arrNoti[0].indexOf("=")+1), "0");	//��������ȣ
	String strCardNo		= StrUtil.nvl(arrNoti[1].substring(arrNoti[1].indexOf("=")+1), "0");	//ī���ȣ
	String strRfidNo		= StrUtil.nvl(arrNoti[2].substring(arrNoti[2].indexOf("=")+1));			//RFID ��ȣ
	String strCardType		= StrUtil.nvl(arrNoti[3].substring(arrNoti[3].indexOf("=")+1));			//ȸ������
	String strRoomCd		= StrUtil.nvl(arrNoti[4].substring(arrNoti[4].indexOf("=")+1));			//�뱸��
	String strProduct		= StrUtil.nvl(arrNoti[5].substring(arrNoti[5].indexOf("=")+1));			//��ǰ�ڵ�_��ǰ��_�ݾ�_�̿�ð�_���屸��
	String strChkSeat		= StrUtil.nvl(arrNoti[6].substring(arrNoti[6].indexOf("=")+1));			//�¼������ڵ�_�¼���ȣ
	String strReserveYmd	= StrUtil.nvl(arrNoti[7].substring(arrNoti[7].indexOf("=")+1));			//�̿�����
	String strReserveTime	= StrUtil.nvl(arrNoti[8].substring(arrNoti[8].indexOf("=")+1));			//�̿�ð�-�ú�(00:00)
	String strEMail			= StrUtil.nvl(arrNoti[9].substring(arrNoti[9].indexOf("=")+1));			//�̿����̸����ּ�
	String strUsrPhoneNo	= StrUtil.nvl(arrNoti[10].substring(arrNoti[10].indexOf("=")+1));		//�̿�����ȭ��ȣ
	String strPayMethod		= StrUtil.nvl(arrNoti[11].substring(arrNoti[11].indexOf("=")+1));		//���Ҽ���(CARD, MEMB)
	
	String strParam	= "centerNo="+strStoreNo+"&cardNo="+strCardNo+"&rfidNo="+strRfidNo+"&cardType="+strCardType+"&chkRoom="+strRoomCd+"&product="+URLEncoder.encode(strProduct, "UTF-8")+"&chkSeat="+strChkSeat;
		   strParam	= "&reserveYmd="+strReserveYmd+"&reserveTime="+strReserveTime+"&eMail="+strEMail+"&mobileNo="+strUsrPhoneNo+"&payMethod="+strPayMethod;
	out.println("<script>");
	out.println("	alert('�������еǾ����ϴ�. ������ �ٽ� �������ּ���.');");
	out.println("	location.href = 'inipay.jsp?"+strParam+"';");
	out.println("</script>");
	return;
} else {
	// ��������� ������ ���

	/////////////////////////////////////////////////////////////////////////////
	///// 3. ���ο�û :                                                      ////
	/////    �������� ������ P_REQ_URL�� ���ο�û�� ��...                    ////
	///// 
	/////////////////////////////////////////////////////////////////////////////

	// ���ο�û�� ������
	P_REQ_URL = P_REQ_URL + "?P_TID=" + P_TID + "&P_MID=" + P_MID;

	// Create an instance of HttpClient.
	HttpClient client = new HttpClient();

	// Create a method instance.
	GetMethod method = new GetMethod(P_REQ_URL);
	
	// Provide custom retry handler is necessary
	method.getParams().setParameter(HttpMethodParams.RETRY_HANDLER, new DefaultHttpMethodRetryHandler(3, false));

	ArrayList<HashMap<String, String>> arrList = new ArrayList<HashMap<String, String>>();
	try {
		// Execute the method.
		int statusCode = client.executeMethod(method);

		if (statusCode != HttpStatus.SC_OK) {
			//System.err.println("Method failed: " + method.getStatusLine());
			System.out.println("Method failed: " + method.getStatusLine());
			
			//PG���� ���� - �ֹ����� 
			//(centerNo=centerNo��|cardNo=cardNo��|rfidNo=rfidNo��|cardType=cardType��|chkRoom=chkRoom��|product=product��|chkSeat=chkSeat��|eMail=eMail��|mobileNo=mobileNo��)
			String strResultNoti	= StrUtil.nvl(P_NOTI);
			
			//P_NOTI ��
			//centerNo		-> 0
			//cardNo		-> 1
			//rfidNo		-> 2
			//cardType		-> 3
			//chkRoom		-> 4
			//product		-> 5
			//chkSeat		-> 6
			//reserveYmd	-> 7
			//reserveTime	-> 8
			//eMail			-> 9
			//mobileNo		-> 10
			//payMethod		-> 11
			String[] arrNoti = strResultNoti.split("[|]");
			
			String strStoreNo		= StrUtil.nvl(arrNoti[0].substring(arrNoti[0].indexOf("=")+1), "0");	//��������ȣ
			String strCardNo		= StrUtil.nvl(arrNoti[1].substring(arrNoti[1].indexOf("=")+1), "0");	//ī���ȣ
			String strRfidNo		= StrUtil.nvl(arrNoti[2].substring(arrNoti[2].indexOf("=")+1));			//RFID ��ȣ
			String strCardType		= StrUtil.nvl(arrNoti[3].substring(arrNoti[3].indexOf("=")+1));			//ȸ������
			String strRoomCd		= StrUtil.nvl(arrNoti[4].substring(arrNoti[4].indexOf("=")+1));			//�뱸��
			String strProduct		= StrUtil.nvl(arrNoti[5].substring(arrNoti[5].indexOf("=")+1));			//��ǰ�ڵ�_��ǰ��_�ݾ�_�̿�ð�_���屸��
			String strChkSeat		= StrUtil.nvl(arrNoti[6].substring(arrNoti[6].indexOf("=")+1));			//�¼������ڵ�_�¼���ȣ
			String strReserveYmd	= StrUtil.nvl(arrNoti[7].substring(arrNoti[7].indexOf("=")+1));			//�̿�����
			String strReserveTime	= StrUtil.nvl(arrNoti[8].substring(arrNoti[8].indexOf("=")+1));			//�̿�ð�-�ú�(00:00)
			String strEMail			= StrUtil.nvl(arrNoti[9].substring(arrNoti[9].indexOf("=")+1));			//�̿����̸����ּ�
			String strUsrPhoneNo	= StrUtil.nvl(arrNoti[10].substring(arrNoti[10].indexOf("=")+1));		//�̿�����ȭ��ȣ
			String strPayMethod		= StrUtil.nvl(arrNoti[11].substring(arrNoti[11].indexOf("=")+1));		//���Ҽ���(CARD, MEMB)
			
			String strParam	= "centerNo="+strStoreNo+"&cardNo="+strCardNo+"&rfidNo="+strRfidNo+"&cardType="+strCardType+"&chkRoom="+strRoomCd+"&product="+URLEncoder.encode(strProduct, "UTF-8")+"&chkSeat="+strChkSeat;
				   strParam	= "&reserveYmd="+strReserveYmd+"&reserveTime="+strReserveTime+"&eMail="+strEMail+"&mobileNo="+strUsrPhoneNo+"&payMethod="+strPayMethod;
			out.println("<script>");
			out.println("	alert('�������еǾ����ϴ�. ������ �ٽ� �������ּ���.');");
			out.println("	location.href = 'inipay.jsp?"+strParam+"';");
			out.println("</script>");
			
			return;
		}

		// Read the response body.
		byte[] responseBody		= method.getResponseBody();				//���ΰ�� �Ľ�
		String[] values			= new String(responseBody).split("&"); 	//���ΰ��
		
		if (values.length > 0) {
			HashMap<String, String> map = new HashMap<String, String>();
			for(int x = 0; x < values.length; x++ ) {
				
				// ���ΰ���� �Ľ̰� �߶� hashmap�� ����
				int idx = values[x].indexOf("=");
				String strKey	= values[x].substring(0, idx);
				String strValue	= StrUtil.nvl(values[x].substring(idx+1));
				out.print(values[x]+", strKey:"+strKey+", strValue:"+strValue);  // ���ΰ���� ���
				map.put(strKey, strValue);
			}
			arrList.add(map);
		}
	} catch (HttpException e) {
		////System.err.println("Fatal protocol violation: " + e.getMessage());
		out.print("Fatal protocol violation: " + e.getMessage());
		e.printStackTrace();
	} catch (IOException e) {
		////System.err.println("Fatal transport error: " + e.getMessage());
		out.print("Fatal transport error: " + e.getMessage());
		e.printStackTrace();
	} finally {
		// Release the connection.
		method.releaseConnection();
	}
	
	//out.print("<br>���ΰ�� ����---------------------------------------------------------------------------<br>");
	
	if (arrList != null && arrList.size() > 0) {
		HashMap<String, String> mapResult = (HashMap<String, String>)arrList.get(0);
		
		String strResultNoti	= StrUtil.nvl(mapResult.containsKey("P_NOTI") ? mapResult.get("P_NOTI").toString() : "");		//PG���� - �ֹ����� (centerNo=centerNo��|cardNo=cardNo��|chkRoom=chkRoom��|chkSeat=chkSeat|product=product|eMail=eMail|mobileNo=mobileNo)
		String strResultStatus	= StrUtil.nvl(mapResult.containsKey("P_STATUS") ? mapResult.get("P_STATUS").toString() : "");	//PG���� - �ŷ����� (����:00, ����:00 �̿� ����)
		String strResultRmesg	= StrUtil.nvl(mapResult.containsKey("P_RMESG1") ? mapResult.get("P_RMESG1").toString() : "");	//PG���� - �޼���1 (���� ��� �޽���)
		
		//P_NOTI�� ����������, �̿�����ȭ��ȣ, ī���ȣ�� ����־� �ش簪�� ���� ��� ����� ����.
		if (strResultNoti != null && !"".equals(strResultNoti)) {
			//P_NOTI ��
			//centerNo		-> 0
			//cardNo		-> 1
			//rfidNo		-> 2
			//cardType		-> 3
			//chkRoom		-> 4
			//product		-> 5
			//chkSeat		-> 6
			//reserveYmd	-> 7
			//reserveTime	-> 8
			//eMail			-> 9
			//mobileNo		-> 10
			//payMethod		-> 11
			String[] arrNoti = strResultNoti.split("[|]");
			
			String strStoreNo		= StrUtil.nvl(arrNoti[0].substring(arrNoti[0].indexOf("=")+1), "0");	//��������ȣ
			String strCardNo		= StrUtil.nvl(arrNoti[1].substring(arrNoti[1].indexOf("=")+1), "0");	//ī���ȣ
			String strRfidNo		= StrUtil.nvl(arrNoti[2].substring(arrNoti[2].indexOf("=")+1));			//RFID ��ȣ
			String strCardType		= StrUtil.nvl(arrNoti[3].substring(arrNoti[3].indexOf("=")+1));			//ȸ������
			String strRoomCd		= StrUtil.nvl(arrNoti[4].substring(arrNoti[4].indexOf("=")+1));			//�뱸��
			String strProduct		= StrUtil.nvl(arrNoti[5].substring(arrNoti[5].indexOf("=")+1));			//��ǰ�ڵ�_��ǰ��_�ݾ�_�̿�ð�_���屸��
			String strChkSeat		= StrUtil.nvl(arrNoti[6].substring(arrNoti[6].indexOf("=")+1));			//�¼������ڵ�_�¼���ȣ
			String strReserveYmd	= StrUtil.nvl(arrNoti[7].substring(arrNoti[7].indexOf("=")+1));			//�̿�����
			String strReserveTime	= StrUtil.nvl(arrNoti[8].substring(arrNoti[8].indexOf("=")+1));			//�̿�ð�-�ú�(00:00)
			String strEMail			= StrUtil.nvl(arrNoti[9].substring(arrNoti[9].indexOf("=")+1));			//�̿����̸����ּ�
			String strUsrPhoneNo	= StrUtil.nvl(arrNoti[10].substring(arrNoti[10].indexOf("=")+1));		//�̿�����ȭ��ȣ
			String strPayMethod		= StrUtil.nvl(arrNoti[11].substring(arrNoti[11].indexOf("=")+1));		//���Ҽ���(CARD, MEMB)
			
			//�������� �Է°� �߰�
			mapResult.put("P_EMAIL", strEMail);			//�̸����ּ�
			
			//hashmap -> json -> xml
			JSONObject jsonData		= new JSONObject(mapResult);
			JSONArray jsonArr		= new JSONArray();
			JSONObject jsonResult	= new JSONObject();
			
			jsonArr.put(jsonData);	
			jsonResult.put("data", jsonArr);
			
			String resultXml = XML.toString(jsonResult);
			
			System.out.println("resultXml : " + resultXml);
			
			//PG_SETTLE_TB ��� ���� ����
			InipayVO.reqPgSettleVO reqInipayVO = new InipayVO().new reqPgSettleVO();
			reqInipayVO.STORE_NO		= Integer.parseInt(strStoreNo);
			reqInipayVO.USR_PHONE_NO	= strUsrPhoneNo;
			reqInipayVO.CARD_NO			= Integer.parseInt(strCardNo);
			reqInipayVO.RFID			= strRfidNo;
			reqInipayVO.CARD_TYPE		= strCardType;
			reqInipayVO.DATA_XML		= resultXml;
			
			//PG_SETTLE_TB ���
			int intPgSettleSeq = 0;
			intPgSettleSeq = new InipayBean().PG_SETTLE_INFO_INS_PROC(reqInipayVO);
			
			//PG_SETTLE_TB ��� ���� �� SM_SETTLE_TB�� ���
			if (intPgSettleSeq > 0) {
				String strResultAuthDt		= StrUtil.nvl(mapResult.containsKey("P_AUTH_DT") ? mapResult.get("P_AUTH_DT").toString() : "");		//PG���� - �������� (YYYYmmddHHmmss)
				String strResultAmt			= StrUtil.nvl(mapResult.containsKey("P_AMT") ? mapResult.get("P_AMT").toString() : "", "0");		//PG���� - �ŷ��ݾ�
				String strResultType		= StrUtil.nvl(mapResult.containsKey("P_TYPE") ? mapResult.get("P_TYPE").toString() : "");			//PG���� - ���Ҽ���
				String strResultSrcCode		= StrUtil.nvl(mapResult.containsKey("P_SRC_CODE") ? mapResult.get("P_SRC_CODE").toString() : "");		//PG���� - �ۿ�����������
				
				String[] arrChkSeats 	= strChkSeat.split("_");
				String[] arrProducts 	= strProduct.split("_");
				
				String strSeatNo 		= StrUtil.nvl(arrChkSeats[0], "0");		//�¼���ȣ
				String strPrdCd			= StrUtil.nvl(arrProducts[1], "0");		//��ǰ�ڵ�
				String strPrice			= StrUtil.nvl(arrProducts[2], "0");		//�Ǹűݾ�
				String strPrdTime		= StrUtil.nvl(arrProducts[3], "0");		//�̿�ð�
				String strDelayYn		= StrUtil.nvl(arrProducts[4], "N");		//���屸��
				
				//���������ڵ�
				String strMethodCd = "";
				if ("CARD".equals(strResultType)) {
					if ("O".equals(strResultSrcCode)) {
						//īī�������� ���
						strMethodCd = "PM005";
					} else {
						//�ۿ������ΰ� īī������ ������ ��� �׳� ī�������
						strMethodCd = "PM001";
					}
				} else if ("BANK".equals(strResultType)) {
					//������ü
					strMethodCd = "PM002";
				} else if ("VBANK".equals(strResultType)) {
					//��������Ա�
					strMethodCd = "PM004";
				} else if ("MOBILE".equals(strResultType)) {
					//�޴���
					strMethodCd = "PM003";
				}
				
				//�������������ڵ�
				//����:00, ����:00 �̿� ����
				String strStatusCd = "";
				if ("00".equals(strResultStatus)) {
					strStatusCd = "PS007";
				} else {
					strStatusCd = "PS008";
				}
				
				//SM_SETTLE_TB�� ��� ���� ����
				InipayVO.reqSmSettleVO reqSettleVO = new InipayVO().new reqSmSettleVO();
				reqSettleVO.STORE_NO		= Integer.parseInt(strStoreNo);
				reqSettleVO.SEAT_NO			= Integer.parseInt(strSeatNo);
				reqSettleVO.ROOM_CD			= strRoomCd;
				reqSettleVO.PRD_CD			= Integer.parseInt(strPrdCd);
				reqSettleVO.USR_PHONE_NO	= strUsrPhoneNo.replace("-", "");
				reqSettleVO.CARD_NO			= Integer.parseInt(strCardNo);
				reqSettleVO.PRICE			= strPrice;
				reqSettleVO.PG_NO			= Integer.toString(intPgSettleSeq);
				reqSettleVO.PAY_AMT			= strResultAmt;
				reqSettleVO.METHOD_CD		= strMethodCd;
				reqSettleVO.STATUS_CD		= strStatusCd;
				reqSettleVO.PAY_DT			= strResultAuthDt;
				
				//SM_SETTLE_TB�� ���
				int intSettleResult = 0;
				intSettleResult = new InipayBean().SM_SETTLE_INS_PROC(reqSettleVO);
				
				//���� ���� �� LocalDatabase ó��
				if ("00".equals(strResultStatus)) {
					//����, �¼���ȣ, ��, ��ǰ���� LocalDataBase�� ���� ���� ��������
					InipayVO.reqSmProductSeatVO reqSmProductSeatVO = new InipayVO().new reqSmProductSeatVO();
					reqSmProductSeatVO.STORE_NO		= Integer.parseInt(strStoreNo);
					reqSmProductSeatVO.SEAT_NO		= Integer.parseInt(strSeatNo);
					reqSmProductSeatVO.ROOM_CD		= strRoomCd;
					reqSmProductSeatVO.PRD_CD		= Integer.parseInt(strPrdCd);
					
					ArrayList<InipayVO.resSmProductSeatVO> arrProdSeatInfo = new InipayBean().SM_PRODUCT_SEAT_INFO_PROC(reqSmProductSeatVO);
					
					if (arrProdSeatInfo != null && arrProdSeatInfo.size() > 0) {
						InipayVO.resSmProductSeatVO prodSeatInfoVO = (InipayVO.resSmProductSeatVO)arrProdSeatInfo.get(0);
						String strInfoPrdMatchingCd		= StrUtil.nvl(prodSeatInfoVO.PRD_MATCHING_CD);
						String strInfMethod				= StrUtil.nvl(prodSeatInfoVO.METHOD_NM);
						int intInfMemCnt				= prodSeatInfoVO.MEM_CNT;
						
						String strCashGubun	= ("CARD".equals(strMethodCd)) ? strMethodCd : "CARD";
						String strReceipt	= "INIPAY"+DateUtil.getCurrentDateTime();
						
						//ȸ����/���α��� ��� IUD_REFILL ���ó��
						boolean blIns	= false;
						int intSel		= -1;
						if ("MEMB".equals(strPayMethod)) {
							//IUD_REFILL ���
							System.out.println(strStoreNo+"^"+strRfidNo+"^"+strReceipt+"^"+strResultAmt+"^"+strCashGubun+"^"+strCardType+"^"+strPrdTime+"^"+strUsrPhoneNo.replace("-", ""));
							InipayVO.reqIudRefillVO reqIudRefillVO = new InipayVO().new reqIudRefillVO();
							reqIudRefillVO.STORE_NO		= strStoreNo;
							reqIudRefillVO.RFID			= strRfidNo;
							reqIudRefillVO.RECEIPT		= strReceipt;
							reqIudRefillVO.CASH			= strResultAmt;
							reqIudRefillVO.CASHGUBUN	= strCashGubun;
							reqIudRefillVO.METHOD		= strCardType;
							reqIudRefillVO.TMR			= Integer.parseInt(strPrdTime);
							reqIudRefillVO.HP			= strUsrPhoneNo.replace("-", "");
							
							blIns = new InipayBean().IUD_REFILL_INS_PROC(reqIudRefillVO);
							System.out.println("blIns:"+blIns);
							
							//��Ͽ��� üũ
							intSel = new InipayBean().RFIDREFILL_SEL_PROC(reqIudRefillVO);
							System.out.println("intSel:"+intSel);
							
							if (intSel == 0) {
								System.out.println(">>>>>>>>>���Ͽ���");
								//��ϵ� ������ ���� ��� ����ó��
								//blIns = new InipayBean().IUD_REFILL_INS_PROC(reqIudRefillVO);
								//System.out.println("blIns:"+blIns);
							}
						} else {
							
							//���弱�� �� ������ �б�ó���ؾ���. �۾� ������.......
							if (!"Y".equals(strDelayYn)) {
								InipayVO.reqIudRecordVO reqIudRecordVO = new InipayVO().new reqIudRecordVO();
								reqIudRecordVO.STORE_NO		= strStoreNo;
								reqIudRecordVO.RECEIPT		= strReceipt;
								reqIudRecordVO.SEAT			= strSeatNo;
								reqIudRecordVO.RFID			= strRfidNo;
								reqIudRecordVO.FEE			= strResultAmt;
								reqIudRecordVO.CASHERTYPE	= strCashGubun;
								reqIudRecordVO.TMR			= Integer.parseInt(strPrdTime);
								reqIudRecordVO.HP			= strUsrPhoneNo.replace("-", "");
								reqIudRecordVO.ROOMTMR		= ("S".equals(strRoomCd)) ? strReserveTime : "";
								reqIudRecordVO.MEMCNT		= intInfMemCnt;
								
								blIns = new InipayBean().IUD_RECORD_INS_PROC(reqIudRecordVO);
								System.out.println("blIns:"+blIns);
								
								//��Ͽ��� üũ
								intSel = new InipayBean().RECORD_SEL_PROC(reqIudRecordVO);
								System.out.println("intSel:"+intSel);
								
								if (intSel == 0) {
									System.out.println(">>>>>>>>>���Ͽ���");
									//��ϵ� ������ ���� ��� ����ó��
									//blIns = new InipayBean().IUD_RECORD_INS_PROC(reqIudRecordVO);
									//System.out.println("blIns:"+blIns);
								}
							} else {
							
								//����� ó���� �κ�
								InipayVO.reqIudDelayVO reqIudDelayVO = new InipayVO().new reqIudDelayVO();
								reqIudDelayVO.STORE_NO		= strStoreNo;
								reqIudDelayVO.RFID			= strRfidNo;
								reqIudDelayVO.SEAT			= Integer.parseInt(strSeatNo);
								reqIudDelayVO.TMR			= Integer.parseInt(strPrdTime);
								reqIudDelayVO.CASH			= 0;
								reqIudDelayVO.CARD			= Integer.parseInt(strResultAmt);
								reqIudDelayVO.POINT			= 0;
								reqIudDelayVO.RFIDFEE		= 0;
								
								blIns = new InipayBean().IUD_DELAY_UPD_PROC(reqIudDelayVO);
								System.out.println("blIns:"+blIns);
							
							}
						}
					}
				}
			}
			
			//�����Ϸ� �� �����Ϸ� �������� �̵�
			if (!"00".equals(strResultStatus)) {
				// ��������� ������ ��� ����ȭ������ �̵�
				System.out.println("Pay Fail : "+strResultRmesg);
				String strParam	= "centerNo="+strStoreNo+"&cardNo="+strCardNo+"&rfidNo="+strRfidNo+"&cardType="+strCardType+"&chkRoom="+strRoomCd+"&product="+URLEncoder.encode(strProduct, "UTF-8")+"&chkSeat="+strChkSeat;
					   strParam	= "&reserveYmd="+strReserveYmd+"&reserveTime="+strReserveTime+"&eMail="+strEMail+"&mobileNo="+strUsrPhoneNo+"&payMethod="+strPayMethod;
				out.println("<script>");
				out.println("	alert('�������еǾ����ϴ�. ������ �ٽ� �������ּ���.');");
				out.println("	location.href = 'inipay.jsp?"+strParam+"';");
				out.println("</script>");
				
				//response.sendRedirect("inipay_test.jsp?"+strParam);
				return;
			} else {
				//���� ���� �� �����Ϸ� �������� �̵�
				response.sendRedirect("settleEnd.jsp");
			}
		}
	}
}



%>


