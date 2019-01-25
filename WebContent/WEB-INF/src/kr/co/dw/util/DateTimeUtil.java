package kr.co.dw.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import kr.co.dw.GlobalEnv;


/**
 * Date & Time Utility
 * 
 * <pre>
 * 1. Usage
 *    
 *    &lt;%
 *    out.println(DateTimeUtil.getCurrentDate("-") + " " + DateTimeUtil.getCurrentTime());
 *    out.println("<hr>");
 *    out.println("DIFF TEST (2002.05.31 ~ 2012.07.31) : " + DateTimeUtil.diff("2002.05.31", "2012.07.31", ".")); 
 *    out.println("<hr>");
 *    out.println("양력>음력 : 2012.03.22 > 2012.03.01 ? " + DateTimeUtil.convertSolarToLunar("2012.03.22", ".")); 
 *    out.println("<br>");
 *    out.println("양력>음력윤달 : 2012.03.01 ? " + DateTimeUtil.convertSolarToLunar("2012.04.21", ".")); 
 *    out.println("<hr>");
 *    out.println("음력>양력 : 2012.03.01 > 2012.03.22 ? " + DateTimeUtil.convertLunarToSolar("2012.03.01", false, ".")); 
 *    out.println("<br>");
 *    out.println("음력윤달>양력 : 2012.03.01 > 2012.04.21 ? " + DateTimeUtil.convertLunarToSolar("2012.03.01", true, ".")); 
 *    out.println("<hr>");
 *    %&gt;
 * </pre>
 * @author DOLGAMZA
 * @version 1.0
 * @since 2012.08
 */
public class DateTimeUtil {

	
	static String[] arrLunar   = 
			   {"1212122322121", "1212121221220", "1121121222120", "2112132122122", "2112112121220", // 음력 1881년부터 2040년까지의 데이터
	            "2121211212120", "2212321121212", "2122121121210", "2122121212120", "1232122121212",
	            "1212121221220", "1121123221222", "1121121212220", "1212112121220", "2121231212121", // 1891
	            "2221211212120", "1221212121210", "2123221212121", "2121212212120", "1211212232212",
	            "1211212122210", "2121121212220", "1212132112212", "2212112112210", "2212211212120", // 1901
	            "1221412121212", "1212122121210", "2112212122120", "1231212122212", "1211212122210",
	            "2121123122122", "2121121122120", "2212112112120", "2212231212112", "2122121212120", // 1911
	            "1212122121210", "2132122122121", "2112121222120", "1211212322122", "1211211221220",
	            "2121121121220", "2122132112122", "1221212121120", "2121221212110", "2122321221212", // 1921
	            "1121212212210", "2112121221220", "1231211221222", "1211211212220", "1221123121221",
	            "2221121121210", "2221212112120", "1221241212112", "1212212212120", "1121212212210", // 1931
	            "2114121212221", "2112112122210", "2211211412212", "2211211212120", "2212121121210",
	            "2212214112121", "2122122121120", "1212122122120", "1121412122122", "1121121222120", // 1941
	            "2112112122120", "2231211212122", "2121211212120", "2212121321212", "2122121121210",
	            "2122121212120", "1212142121212", "1211221221220", "1121121221220", "2114112121222", // 1951
	            "1212112121220", "2121211232122", "1221211212120", "1221212121210", "2121223212121",
	            "2121212212120", "1211212212210", "2121321212221", "2121121212220", "1212112112210", // 1961
	            "2223211211221", "2212211212120", "1221212321212", "1212122121210", "2112212122120",
	            "1211232122212", "1211212122210", "2121121122210", "2212312112212", "2212112112120", // 1971
	            "2212121232112", "2122121212110", "2212122121210", "2112124122121", "2112121221220",
	            "1211211221220", "2121321122122", "2121121121220", "2122112112322", "1221212112120", // 1981
	            "1221221212110", "2122123221212", "1121212212210", "2112121221220", "1211231212222",
	            "1211211212220", "1221121121220", "1223212112121", "2221212112120", "1221221232112", // 1991
	            "1212212122120", "1121212212210", "2112132212221", "2112112122210", "2211211212210",
	            "2221321121212", "2212121121210", "2212212112120", "1232212122112", "1212122122120", // 2001
	            "1121212322122", "1121121222120", "2112112122120", "2211231212122", "2121211212120",

	            "2122121121210", "2124212112121", "2122121212120", "1212121223212", "1211212221220", // 2011
	            "1121121221220", "1212132121222", "1212112121220", "2121211212120", "2122321121212",

	            "1221212121210", "2121221212120", "1232121221212", "1211212212210", "2121123212221", // 2021
	            "2121121212220", "1212112112220", "1221231211221", "2212211211220", "1212212121210",
	            "2123212212121", "2112122122120", "1211212322212", "1211212122210", "2121121122120", // 2031
	            "2212114112122", "2212112112120", "2212121211210", "2212232121211", "2122122121210",
	            "2112122122120", "1231212122212", "1211211221220", "2121121321222", "2121121121220", // 2041
	            "2122112112120", "2122141211212", "1221221212110", "2121221221210", "2114121221221"};

	/**
	 * 생성자
	 * 
	 */
	private DateTimeUtil() {}

	/**
	 * 구분자(strSeparator)에 맞춘 오늘의 날짜를 불러온다
	 * 
	 * @param strSeparator 년월일구분자
	 * @return 오늘날짜
	 */
	public static String getCurrentDate(String strSeparator) {
		strSeparator = (strSeparator==null) ? GlobalEnv.GLOBAL_DATE_SEPERATOR : strSeparator; 
		String str = "yyyy" + strSeparator + "MM" + strSeparator + "dd";
		java.text.SimpleDateFormat f = new java.text.SimpleDateFormat(str, java.util.Locale.KOREA);
		return f.format(new java.util.Date());
	}
	
	/**
	 * 현재시간을 불러온다
	 * 
	 * @return 현재시간
	 */
	public static String getCurrentTime() {
		java.text.SimpleDateFormat f = new java.text.SimpleDateFormat("HH:mm:ss", java.util.Locale.KOREA);
		return f.format(new java.util.Date());
	}
	
	public static String getCurrentDateTimeMilli() {
		java.text.SimpleDateFormat f = new java.text.SimpleDateFormat("yyMMddHHmmss", java.util.Locale.KOREA);
		return f.format(new java.util.Date());
	}
	
	/**
	 * 두날짜 사이의 날짜수를 구한다
	 * 
	 * @param strFromDate  비교시작일
	 * @param strToDate    비교일
	 * @param strSeparator 년월일구분자
	 * @return 두날짜 사이의 날짜수
	 * @throws ParseException
	 */
	public static Long diff(String strFromDate, String strToDate, String strSeparator) throws ParseException {
		strSeparator = StrUtil.nvl(strSeparator, GlobalEnv.GLOBAL_DATE_SEPERATOR);
		strFromDate  = StrUtil.nvl(strFromDate, getCurrentDate(strSeparator));
		strToDate    = StrUtil.nvl(strToDate,   getCurrentDate(strSeparator));
		strSeparator = (strSeparator.equals(".")) ? "[.]" : strSeparator;

		if (!isCorrectDate(strFromDate, strSeparator)) return null;
		if (!isCorrectDate(strToDate, strSeparator)) return null;
		
		SimpleDateFormat f = new SimpleDateFormat("yyyyMMdd", java.util.Locale.KOREA);
		Date          from = f.parse(strFromDate.replaceAll(strSeparator, ""));
		Date            to = f.parse(strToDate.replaceAll(strSeparator, ""));
		Long           lng = (to.getTime()-from.getTime())/(24*60*60*1000);
		return lng;
	}
	
	/**
	 * 검색할 날짜에 -intDiff를 더한 날짜를 구한다
	 * 
	 * @param strSearchDate 검색할 날짜
	 * @param intDiff       더하거나 뺄 날짜(+는 빼고, -는 더함)
	 * @param strSeparator  년월일구분자
	 * @return -intDiff한 날짜
	 * @throws ParseException
	 */
	public static String diff(String strSearchDate, int intDiff, String strSeparator) throws ParseException {
		strSeparator  = StrUtil.nvl(strSeparator, GlobalEnv.GLOBAL_DATE_SEPERATOR);
		strSearchDate = StrUtil.nvl(strSearchDate, getCurrentDate(strSeparator));
		
		if (!isCorrectDate(strSearchDate, strSeparator)) return null;
		
		SimpleDateFormat f = new SimpleDateFormat("yyyyMMdd", java.util.Locale.KOREA);
		String strSep   = (strSeparator.equals(".")) ? "[.]" : strSeparator;
		Date  date = f.parse(strSearchDate.replaceAll(strSep, ""));
		Long  lng = date.getTime() - (long)intDiff*(24*60*60*1000);
		date.setTime(lng);
		String str = f.format(date);
		return str.substring(0, 4) + strSeparator + str.substring(4, 6) + strSeparator + str.substring(6, 8);
		
	}
	
	/**
	 * 유효한 날짜 여부를 확인한다
	 * 
	 * @param strDate      날짜
	 * @param strSeparator 년월일구분자
	 * @return 유효한날짜인지?
	 */
	protected static boolean isCorrectDate(String strDate, String strSeparator) {
		int     intYear   = 0;
		if (strDate.length()!=10) return false;
		
		strSeparator  = StrUtil.nvl(strSeparator, GlobalEnv.GLOBAL_DATE_SEPERATOR);
		String[] arr  = (strSeparator.equals(".")) ? strDate.replaceAll("[.]", "-").split("-") : strDate.replaceAll(strSeparator, "-").split("-");
		
		int[] intMonthTable = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
		
		if (arr[0].length()!=4) return false;
		if (Integer.parseInt(arr[1])>12) return false;
		if (Integer.parseInt(arr[2])<1 || Integer.parseInt(arr[2])>31) return false;
		
		intYear = Integer.parseInt(arr[0]);
		if (intYear%4 == 0 && (intYear%100!=0 || intYear%400==0)) intMonthTable[1]=29;
		if (Integer.parseInt(arr[2]) > intMonthTable[Integer.parseInt(arr[1])-1]) return false;
	
		return true;
	}

	/**
	 * 10이하의 숫자가 들어오면 앞에 0을 추가한다
	 * 
	 * @param i 변경검토대상숫자
	 * @return 달력형태의 숫자
	 */
	public static String getMonthDateString(int i) {
		return (i<10) ? "0" + Integer.toString(i) : Integer.toString(i);
	}
	
	/**
	 * 정수형 년, 월, 일을 포맷에 맞게 변경한다
	 *  
	 * @param year 년도
	 * @param month 월
	 * @param date  일
	 * @param strSeparator 구분자
	 * @return 포맷에 맞는 년월일
	 */
	public static String getFormatDate(int year, int month, int date, String strSeparator) {
		String strYear  = Integer.toString(year);
		String strMonth = getMonthDateString(month);
		String strDate  = getMonthDateString(date);
		return strYear + strSeparator + strMonth + strSeparator + strDate;
	}
	
	
	/**
	 * 양력으로 음력 날짜를 조회한다
	 * 
	 * @param strSolarDate 양력날짜
	 * @param strSeparator 년월일구분자
	 * @return 음력날짜
	 * @throws ParseException
	 */
	public static String convertSolarToLunar(String strSolarDate, String strSeparator) throws ParseException {
		strSeparator = StrUtil.nvl(strSeparator, GlobalEnv.GLOBAL_DATE_SEPERATOR);
		strSolarDate = StrUtil.nvl(strSolarDate, getCurrentDate(strSeparator));
		strSolarDate = (strSeparator.equals(".")) ? strSolarDate.replaceAll("[.]", "-") : strSolarDate.replaceAll(strSeparator, "-");
		
		if (!isCorrectDate(strSolarDate, "-")) return null;
		
		int intLunarDay   = (int)(diff("0001-01-01", strSolarDate, "-") - 686685); // 서기 1년1월1일부터 검색일까지의 날짜수에 686685를 빼면 음력 1881.01.01부터의 날짜수가 된다
		int intLunarYear  = 1881;
		int intLunarMonth = 0;
		int intIndex      = 0;

		int intAccrued    = 0;
		int intLeapMonth  = -1;
		int i             = 0;
		boolean isLeapMonth = false;
		
		for (intIndex=0; intIndex<arrLunar.length; intIndex++) { // 음력 1881.01.01부터의 연간 음력날짜수를 차감하면서 음력년수를 산출한다
			intAccrued = 0;
			for (i=0; i<13; i++) {
				if (Integer.parseInt(arrLunar[intIndex].substring(i, i+1))>0) {
					intAccrued += (Integer.parseInt(arrLunar[intIndex].substring(i, i+1))+1)%2 + 29;
				}
			}
			if (intLunarDay-2<intAccrued) break;
			else {
				intLunarYear++;
				intLunarDay = intLunarDay - intAccrued;
			}
		}

		for (i=0; i<13; i++) { // 윤달이 어느 달에 있는지 찾아낸다
			if (Integer.parseInt(arrLunar[intIndex].substring(i, i+1))>2) break;
			intLeapMonth++;
		}

		intAccrued = 0;
		for (i=0; i<13; i++) { 
			intAccrued += (Integer.parseInt(arrLunar[intIndex].substring(i, i+1))+1)%2 + 29;
			if (intLunarDay-2<intAccrued) {
				intLunarMonth = (i>intLeapMonth) ? (intLunarMonth-1) : intLunarMonth;
				break;
			}
			else {
				intLunarMonth++;
				intLunarDay = intLunarDay - intAccrued;
			}
			intAccrued = 0;
		}
		
		isLeapMonth = (Integer.parseInt(arrLunar[intIndex].substring(i, i+1))>2) ? true : false;
		
		intLunarDay = intLunarDay-1;
		return getFormatDate(intLunarYear, (intLunarMonth+1), intLunarDay, strSeparator) + ((isLeapMonth)?"(윤)":"");
	}
	
	/**
	 * 요일구하기
	 * 
	 * @param strSolarDate 날짜
	 * @param strSeparator 년월일 구분자
	 * @return 정수형요일
	 */
	public static int getWeek(String strSolarDate, String strSeparator) {
		strSeparator = StrUtil.nvl(strSeparator, GlobalEnv.GLOBAL_DATE_SEPERATOR);
		String[] arrDate = strSolarDate.split((strSeparator.equals("."))?"[.]":strSeparator);
		int intYear  = Integer.parseInt(arrDate[0]);
		int intMonth = Integer.parseInt("1"+arrDate[1])-101;
		int intDate  = Integer.parseInt("1"+arrDate[2])-100;
		Calendar c = Calendar.getInstance();
		c.set(intYear, intMonth, intDate);
		return c.get(Calendar.DAY_OF_WEEK)-1;
	}
	
	/**
	 * 한글 요일명칭 구하기
	 * 
	 * @param strSolarDate 날짜
	 * @param strSeparator 년월일 구분자
	 * @return 한글요일명
	 */
	public static String getWeekKorean(String strSolarDate, String strSeparator) {
		String[] w = {"일", "월", "화", "수", "목", "금", "토"};
		return w[getWeek(strSolarDate, strSeparator)];
	}

	/**
	 * 영어 요일명칭 구하기
	 * 
	 * @param strSolarDate 날짜
	 * @param strSeparator 년월일 구분자
	 * @return 영문요일명
	 */
	public static String getWeekEnglish(String strSolarDate, String strSeparator) {
		String[] w = {"SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"};
		return w[getWeek(strSolarDate, strSeparator)];
	}
	
	/**
	 * 한자 요일명칭 구하기
	 * 
	 * @param strSolarDate 날짜
	 * @param strSeparator 년월일 구분자
	 * @return 한자요일명
	 */
	public static String getWeekChinese(String strSolarDate, String strSeparator) {
		String[] w = {"日", "月", "火", "水", "木", "金", "土"};
		return w[getWeek(strSolarDate, strSeparator)];
	}
	
	
	/**
	 * 음력으로 양력 날짜를 조회한다
	 * 
	 * @param strLunarDate 음력날짜
	 * @param isLeapMonth  윤달구분
	 * @param strSeparator 년월일구분자
	 * @return 양력날짜
	 * @throws ParseException
	 */
	public static String convertLunarToSolar(String strLunarDate, boolean isLeapMonth, String strSeparator) throws ParseException {
		strSeparator = StrUtil.nvl(strSeparator, GlobalEnv.GLOBAL_DATE_SEPERATOR);
		strLunarDate = (strSeparator.equals(".")) ? strLunarDate.replaceAll("[.]", "-") : strLunarDate.replaceAll(strSeparator, "-");

		String[] arr      = strLunarDate.split("-");
		int intIndex      = Integer.parseInt(arr[0])-1881; // 년도를 찾는다
		int intMonthIndex = Integer.parseInt(arr[1]);
		int intAccrued    = 0;

		for (int i=0; i<intIndex; i++) { // 1881년1월1일부터의 전년까지의 날짜수를 찾는다
			for (int j=0; j<13; j++) {
				if (Integer.parseInt(arrLunar[i].substring(j, j+1))>0) {
					intAccrued += ((Integer.parseInt(arrLunar[i].substring(j, j+1))+1)%2) + 29;
				}
			}
		}
		
		for (int j=0; j<intMonthIndex; j++) {
			if (Integer.parseInt(arrLunar[intIndex].substring(j, j+1))>2) {
				intMonthIndex++;
				break;
			}
		}

		intMonthIndex = (isLeapMonth && Integer.parseInt(arrLunar[intIndex].substring(intMonthIndex, intMonthIndex+1))>2) ? intMonthIndex+1 : intMonthIndex;
		
		for (int j=0; j<intMonthIndex; j++) {
			if (Integer.parseInt(arrLunar[intIndex].substring(j, j+1))>0) {
				intAccrued += (Integer.parseInt(arrLunar[intIndex].substring(j, j+1))+1)%2 + 29;
			}
		}
		intAccrued += Integer.parseInt(arr[2]) + 686685 + 2;
		return diff("0001-01-01", -intAccrued, strSeparator);
	}
	
	/**
	 * 오류내용을 알려준다
	 * 
	 * @return 오류메시지
	 */
	public static String getErrorMessage() {
		return "올바른 날짜가 아닙니다.";
	}
}
