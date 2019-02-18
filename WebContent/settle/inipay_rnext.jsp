<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="java.io.*" %>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.dw.util.*" %>
<%@page import="org.apache.commons.httpclient.*" %>
<%@page import="org.apache.commons.httpclient.methods.*" %>
<%@page import="org.apache.commons.httpclient.methods.GetMethod" %> 
<%@page import="org.apache.commons.httpclient.params.HttpMethodParams" %>
<%@page import="org.json.JSONArray" %>
<%@page import="org.json.XML" %>
<%@page import="org.json.JSONObject" %>
<%@ page import = "kr.co.beable.settle.*" %>
<%
	/////////////////////////////////////////////////////////////////////////////
	///// 1. 변수 초기화 및 POST 인증값 받음                                 ////
	/////////////////////////////////////////////////////////////////////////////
	request.setCharacterEncoding("euc-kr");

	String P_STATUS		= StrUtil.nvl(request.getParameter("P_STATUS"));			// 인증 상태
	String P_RMESG1		= StrUtil.nvl(request.getParameter("P_RMESG1"));			// 인증 결과 메시지
	String P_TID		= StrUtil.nvl(request.getParameter("P_TID"));				// 인증 거래번호
	String P_REQ_URL	= StrUtil.nvl(request.getParameter("P_REQ_URL"));			// 결제요청 URL
	String P_NOTI		= StrUtil.nvl(request.getParameter("P_NOTI"));				// 기타주문정보
	
	/////////////////////////////////////////////////////////////////////////////
	///// 2. 상점 아이디 설정 :                                              ////
	/////    결제요청 페이지에서 사용한 MID값과 동일하게 세팅해야 함...      ////
	/////////////////////////////////////////////////////////////////////////////
	String P_MID = "INIpayTest";  
	

if(P_STATUS.equals("01")) {
	// 인증결과가 실패일 경우
	out.print("Auth Fail");
	out.print("<br>");	
	out.print(P_RMESG1);
} else {
	// 인증결과가 성공일 경우

	/////////////////////////////////////////////////////////////////////////////
	///// 3. 승인요청 :                                                      ////
	/////    인증값을 가지고 P_REQ_URL로 승인요청을 함...                    ////
	///// 
	/////////////////////////////////////////////////////////////////////////////

	// 승인요청할 데이터
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
			return;
		}

		// Read the response body.
		byte[] responseBody		= method.getResponseBody();				//승인결과 파싱
		String[] values			= new String(responseBody).split("&"); 	//승인결과
		
		if (values.length > 0) {
			HashMap<String, String> map = new HashMap<String, String>();
			for(int x = 0; x < values.length; x++ ) {
				
				// 승인결과를 파싱값 잘라 hashmap에 저장
				int idx = values[x].indexOf("=");
				String strKey	= values[x].substring(0, idx);
				String strValue	= StrUtil.nvl(values[x].substring(idx+1));
				out.print(values[x]+", strKey:"+strKey+", strValue:"+strValue);  // 승인결과를 출력
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
	
	//out.print("<br>승인결과 저장---------------------------------------------------------------------------<br>");
	
	if (arrList != null && arrList.size() > 0) {
		HashMap<String, String> mapResult = (HashMap<String, String>)arrList.get(0);
		
		String strResultNoti	= StrUtil.nvl(mapResult.get("P_NOTI").toString());			//PG수신 - 주문정보 (centerNo=centerNo값|cardNo=cardNo값|chkRoom=chkRoom값|chkSeat=chkSeat|product=product|eMail=eMail|mobileNo=mobileNo)
		String strResultStatus	= StrUtil.nvl(mapResult.get("P_STATUS").toString());	//PG수신 - 거래상태 (성공:00, 실패:00 이외 실패)
		
		//P_NOTI에 가맹점정보, 이용자전화번호, 카드번호가 들어있어 해당값이 없을 경우 등록을 못함.
		if (strResultNoti != null && !"".equals(strResultNoti)) {
			//P_NOTI 값
			//centerNo	-> 0
			//cardNo	-> 1
			//chkRoom	-> 2
			//chkSeat	-> 3
			//product	-> 4
			//eMail		-> 5
			//mobileNo	-> 6
			String[] arrNoti = strResultNoti.split("[|]");
			
			String strStoreNo		= StrUtil.nvl(arrNoti[0].substring(arrNoti[0].indexOf("=")+1), "0");	//가맹점번호
			String strCardNo		= StrUtil.nvl(arrNoti[1].substring(arrNoti[1].indexOf("=")+1), "0");	//카드번호
			String strRoomCd		= StrUtil.nvl(arrNoti[2].substring(arrNoti[2].indexOf("=")+1));			//룸구분
			String strChkSeat		= StrUtil.nvl(arrNoti[3].substring(arrNoti[3].indexOf("=")+1));			//좌석유형코드_좌석번호
			String strProduct		= StrUtil.nvl(arrNoti[4].substring(arrNoti[4].indexOf("=")+1));			//상품코드_상품명_금액
			String strEMail			= StrUtil.nvl(arrNoti[5].substring(arrNoti[5].indexOf("=")+1));			//이용자이메일주소
			String strUsrPhoneNo	= StrUtil.nvl(arrNoti[6].substring(arrNoti[6].indexOf("=")+1));			//이용자전화번호
			
			//결제정보 입력값 추가
			mapResult.put("P_EMAIL", strEMail);		//이메일주소
			mapResult.put("P_MOBILE", strEMail);	//휴대폰번호
			
			//hashmap -> json -> xml
			JSONObject jsonData		= new JSONObject(mapResult);
			JSONArray jsonArr		= new JSONArray();
			JSONObject jsonResult	= new JSONObject();
			
			jsonArr.put(jsonData);	
			jsonResult.put("data", jsonArr);
			
			String resultXml = XML.toString(jsonResult);
			
			System.out.println("resultXml : " + resultXml);
			
			//PG_SETTLE_TB 등록 변수 설정
			InipayVO.reqPgSettleVO reqInipayVO = new InipayVO().new reqPgSettleVO();
			reqInipayVO.STORE_NO		= Integer.parseInt(strStoreNo);
			reqInipayVO.USR_PHONE_NO	= strUsrPhoneNo;
			reqInipayVO.CARD_NO			= Integer.parseInt(strCardNo);
			reqInipayVO.DATA_XML		= resultXml;
			
			//PG_SETTLE_TB 등록
			int intPgSettleSeq = 0;
			intPgSettleSeq = new InipayBean().PG_SETTLE_INFO_INS_PROC(reqInipayVO);
			
			//PG_SETTLE_TB 등록 성공 시 SM_SETTLE_TB에 등록
			if (intPgSettleSeq > 0) {
				String strResultAuthDt		= StrUtil.nvl(mapResult.get("P_AUTH_DT").toString());		//PG수신 - 승인일자 (YYYYmmddHHmmss)
				String strResultAmt			= StrUtil.nvl(mapResult.get("P_AMT").toString(), "0");		//PG수신 - 거래금액
				String strResultType		= StrUtil.nvl(mapResult.get("P_TYPE").toString());			//PG수신 - 지불수단
				String strResultSrcCode		= StrUtil.nvl(mapResult.get("P_SRC_CODE").toString());		//PG수신 - 앱연동결제구분
				
				String[] arrChkSeats 	= strChkSeat.split("_");
				String[] arrProducts 	= strProduct.split("_");
				
				String strSeatNo 		= StrUtil.nvl(arrChkSeats[1], "0");		//좌석번호
				String strPrdCd			= StrUtil.nvl(arrProducts[0], "0");		//상품코드
				String strPrice			= StrUtil.nvl(arrProducts[2], "0");		//판매금액
				
				//결제수단코드
				String strMethodCd = "";
				if ("CARD".equals(strResultType)) {
					if ("O".equals(strResultSrcCode)) {
						//카카오페이일 경우
						strMethodCd = "PM005";
					} else {
						//앱연동여부가 카카오페이 제외일 경우 그냥 카드결제로
						strMethodCd = "PM001";
					}
				} else if ("BANK".equals(strResultType)) {
					//계좌이체
					strMethodCd = "PM002";
				} else if ("VBANK".equals(strResultType)) {
					//가상계좌입금
					strMethodCd = "PM004";
				} else if ("MOBILE".equals(strResultType)) {
					//휴대폰
					strMethodCd = "PM003";
				}
				
				//최종결제상태코드
				//성공:00, 실패:00 이외 실패
				String strStatusCd = "";
				if ("00".equals(strResultStatus)) {
					strStatusCd = "PS007";
				} else {
					strStatusCd = "PS008";
				}
				
				//SM_SETTLE_TB에 등록 변수 설정
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
				
				//SM_SETTLE_TB에 등록
				int intSettleResult = 0;
				intSettleResult = new InipayBean().SM_SETTLE_INS_PROC(reqSettleVO);
			}
		}
	}
}



%>


