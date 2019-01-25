package kr.co.dw;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

public class GlobalEnv {

	public  static String GLOBAL_CONNECTION_NAME = "/jdbc/SQLDB";	//JDBC NAME.
	private static String GLOBAL_WEBROOT_DIR     = null;			//WEB CONTENT TOP RANK DIR.
	public  static String GLOBAL_DATE_SEPERATOR  = ".";				//DATE BAGIC DELIMITER.

	/**
	 * CONTEXT REFER.
	 *
	 * @return WEB CONTENT TOP RANK DIR.
	 */
	public static String getWebRootDir() {
		if (GLOBAL_WEBROOT_DIR == null) {
			try {
				Context ctx    = new InitialContext();
				Context envctx = (Context) ctx.lookup("java:comp/env");
				GLOBAL_WEBROOT_DIR = (String) envctx.lookup("WEBROOT");
				System.out.println("WebContent Root Directory : " + GLOBAL_WEBROOT_DIR);
			} catch (NamingException e) {
				System.out.println("getWebRootDir_Error::::::::::::::::"+e.toString());
				e.printStackTrace();
			}
		}
		return GLOBAL_WEBROOT_DIR;
	}

}
