package kr.co.dw.util;

public class DwUtil {
	private DwUtil() { }
	
	/**
	 * Phone Number To Array.
	 * 
	 * @param strPhoneNumber
	 * @return
	 */
	public static String[] getPhoneNumberArray(String strPhoneNumber) {
		String[] arr = new String[3];
		if (strPhoneNumber!=null && strPhoneNumber.trim().length()>8) {
			arr[0] = (strPhoneNumber.substring(0,2).equals("02")) ? strPhoneNumber.substring(0,2) : strPhoneNumber.substring(0,3); 
			arr[2] = strPhoneNumber.substring(strPhoneNumber.length()-4, strPhoneNumber.length());
			arr[1] = "";
			for (int i=arr[0].length(); i<strPhoneNumber.length()-4; i++) {
				arr[1] += strPhoneNumber.substring(i, i+1);
			}
		} else {
			arr[0] = "";
			arr[1] = "";
			arr[2] = strPhoneNumber;
		}
		return arr;		
	}

	/**
	 * Add Dash For Phone Number.
	 * 
	 * @param strPhoneNumber
	 * @return
	 */
	public static String addDashPhoneNumber(String strPhoneNumber) {
		String phoneNumber = "";
		String[] arr = getPhoneNumberArray(strPhoneNumber);
		if (strPhoneNumber!=null && strPhoneNumber.trim().length() > 0) {
			phoneNumber = arr[0] + "-" + arr[1] + "-" + arr[2];
		} else {
			phoneNumber = arr[2];
		}
		
		return phoneNumber;
	}
	
	/**
	 * Biz Number To Array.
	 * @param strBizNumber
	 * @return
	 */
	public static String[] getBizNumberArray(String strBizNumber) {
		String[] arr = new String[3];
		if(strBizNumber != null && strBizNumber.trim().length() == 10) {
			arr[0] = strBizNumber.substring(0, 3);
			arr[1] = strBizNumber.substring(3, 5);
			arr[2] = strBizNumber.substring(5, 10);
		} else {
			arr[0] = "";
			arr[1] = "";
			arr[2] = strBizNumber;
		}
		return arr;
	}
	
	/**
	 * Add Dash For Biz Number.
	 * @param strBizNumber
	 * @return
	 */
	public static String addDashBizNumber(String strBizNumber) {
		String bizNumber = "";
		String[] arr = getBizNumberArray(strBizNumber);
		if(arr[0].length() > 0) {
			bizNumber = arr[0] + "-" + arr[1] + "-" + arr[2];
		} else {
			bizNumber = arr[2];
		}
		
		return bizNumber;
	}
	
	/**
	 * YYMMDD TO Array.
	 * @param strYMD
	 * @return
	 */
	public static String[] getYMDArray(String strYMD) {
		String[] arr = new String[3];
		if(strYMD != null && strYMD.trim().length() == 8) {
			arr[0] = strYMD.substring(0, 4);
			arr[1] = strYMD.substring(4, 6);
			arr[2] = strYMD.substring(6, 8);
		} else {
			arr[0] = "";
			arr[1] = "";
			arr[2] = strYMD;
		}
		return arr;
	}
	
	/**
	 * add YYYYMMDD KIHO 
	 * @param strYMD
	 * @param strKiho
	 * @return
	 */
	public static String addDashYMD(String strYMD, String strKiho) {
		String strSetymd = "";
		String[] arr = getYMDArray(strYMD);
		if(arr[0].length() > 0) {
			strSetymd = arr[0] + strKiho + arr[1] + strKiho + arr[2];
		} else {
			strSetymd = arr[2];
		}
		
		return strSetymd;
	}
	
	/**
	 * HHMMSS TO Array.
	 * @param strHMS
	 * @return
	 */
	public static String[] getHMSArray(String strHMS) {
		String[] arr = new String[3];
		if(strHMS != null && strHMS.trim().length() == 6) {
			arr[0] = strHMS.substring(0, 2);
			arr[1] = strHMS.substring(2, 4);
			arr[2] = strHMS.substring(4, 6);
		} else {
			arr[0] = "";
			arr[1] = "";
			arr[2] = strHMS;
		}
		return arr;
	}
	
	/**
	 * add colon HHMMSS
	 * @param strHMS
	 * @return
	 */
	public static String addColonHMS(String strHMS) {
		String strSethms = "";
		String[] arr = getHMSArray(strHMS);
		if(arr[0].length() > 0) {
			strSethms = arr[0] + ":" + arr[1] + ":" + arr[2];
		} else {
			strSethms = arr[2];
		}
		
		return strSethms;
	}
	
	/**
	 * Make char of front.
	 * @param src
	 * @param apchar
	 * @param len
	 * @return
	 */
	public static String appendLeft(String src, String apchar, int len)
	{
		int count = len - src.trim().length();
		for(int i=0;i<count;i++)
		    src = apchar.trim() + src.trim();

	    return src;
	}

	/**
	 * Make char of front.
	 * @param src
	 * @param apchar
	 * @param len
	 * @return
	 */
	public static String appendLeft(int src, String apchar, int len)
	{
		String str_src = (new Integer(src)).toString();
	    return DwUtil.appendLeft(str_src, apchar, len);
	}
	
}
