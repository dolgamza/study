package kr.co.beable.inf;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import kr.co.dw.des.DESCrypto;

public class LocalDatabaseBean {

	/**
	 * insert store's connection information
	 * 
	 * @param vo
	 * @return
	 */
	public int CM_STORE_SERVER_INS_PROC (LocalDatabaseVO vo) {
		return new LocalDatabaseDAO().CM_STORE_SERVER_INS_PROC(vo);
	}
	
	/**
	 * get connection string
	 * 
	 * @param strStoreNo
	 * @return connection information
	 * @throws Exception
	 */
	public String CM_STORE_DB_CONN_INFO_PROC (String strStoreNo) throws Exception {
		ArrayList<LocalDatabaseInfoVO> arr = new LocalDatabaseDAO().CM_STORE_DB_CONN_INFO_PROC("1");
		LocalDatabaseInfoVO vo = arr.get(0);
		String strUrl 	= "X";
		if (vo.DB_IP.length()>4 && vo.DB_PORT.length()>1 && vo.DB_NM.length()>1 && vo.DB_USER_NM.length()>0 && vo.DB_PW.length()>0) {
			strUrl = "jdbc:sqlserver://"+vo.DB_IP+":"+vo.DB_PORT+";databaseName="+vo.DB_NM+";user="+vo.DB_USER_NM+";password="+DESCrypto.decrypt(vo.DB_PW)+";";
		}
		return strUrl;
	}
	
	public int CM_STORE_MAKE_CERTIFICATION_PROC (String strF_id, String strStoreNo) throws SQLException {
		return new LocalDatabaseDAO().CM_STORE_MAKE_CERTIFICATION_PROC(strF_id, strStoreNo);
	}
	
	/**
	 * connect store's database
	 * 
	 * @param strStoreNo
	 * @return Connection
	 */
	public Connection getLocalConnection(String strStoreNo) {
		Connection lc = null;
		Logger logger = Logger.getLogger(this.getClass());
		try {
			String strUrl = CM_STORE_DB_CONN_INFO_PROC (strStoreNo);
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			lc = DriverManager.getConnection(strUrl);
		} catch (Exception e) {
			logger.error(e.toString());
		}
		return lc;
	}
	
	/**
	 * disconnect store's database
	 * 
	 * @param conn Connection
	 */
	public void closeLocalConnection(Connection conn) {
		Logger logger = Logger.getLogger(this.getClass());
		try {
			conn.close();
		} catch (Exception e) {
			logger.error(e.toString());
		}
	}
	
	
}
