package kr.co.dw.util;
/**
 * Using SafeCode Utility
 * 
 */
import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import codeone.SafeCode;

public class SafeUtil {

	private HttpServletRequest request;
	private HttpServletResponse response;
	
	public SafeUtil(HttpServletRequest req, HttpServletResponse res) {
		try {
			request  = req;
			response = res;
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		
	}
	
	/**
	 * Get Parameter
	 *  
	 * <pre>
	 * <ul>
	 * <ol>null인 경우 대체문자열로 대체
	 * <ol>html 테그 제거
	 * <ol>문자열을 intLength만큼 자르기
	 * </pre>
	 * 
	 * @param strParameter 파라미터 문자열
	 * @param strReplaceWord 널인 경우 대체할 문자열 
	 * @param intLength 잘라낼 길이
	 * @return 문자열
	 * @throws IOException 
	 */
	public String getParamSafe(String strParameter, String strReplaceWord, int intLength) throws IOException {
		SafeCode safe = new SafeCode(request);
		String safeflag = safe.getErrorNum();
		
		if(!safeflag.equals("pass")){
			response.sendRedirect("/error.jsp");
			return strParameter;
		}
		
		String safeparm = strParameter;
		
		if(safeparm != null){
			if(!safe.doSafeCode(safeparm).equals("pass")){
				response.sendRedirect("/error.jsp");
				return strParameter;
			}
		}
		
		strParameter = replaceString(StrUtil.nvl(strParameter, strReplaceWord));
		strParameter = StrUtil.cutString(strParameter, intLength, ""); 
		return strParameter;
	}

	/**
	 * Get Parameter
	 * 
	 * @param strParameter
	 * @param strReplaceWord
	 * @return
	 * @throws IOException
	 */
	public String getParamSafe(String strParameter, String strReplaceWord) throws IOException {
		SafeCode safe = new SafeCode(request);
		String safeflag = safe.getErrorNum();
		
		if(!safeflag.equals("pass")){
			response.sendRedirect("/error.jsp");
			return strParameter;
		}
		
		String safeparm = strParameter;
		
		if(safeparm != null){
			if(!safe.doSafeCode(safeparm).equals("pass")){
				response.sendRedirect("/error.jsp");
				return strParameter;
			}
		}
		
		strParameter = replaceString(StrUtil.nvl(strParameter, strReplaceWord));
		return strParameter;
	}

	/**
	 * Remove Critical Pattern. 
	 * 
	 * @param str
	 * @return
	 */
	private String replaceString(String str) {
		str = str.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", ""); // remove html tag
		str = str.replaceAll("'","");
		str = str.replaceAll("\"","");
		return str;
	}
	
	public void release() {
		request = null;
		response = null;
	}

}
