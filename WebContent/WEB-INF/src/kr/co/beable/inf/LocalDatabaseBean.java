package kr.co.beable.inf;

import java.util.ArrayList;

public class LocalDatabaseBean {

	public int CM_STORE_SERVER_INS_PROC (LocalDatabaseVO vo) {
		return new LocalDatabaseDAO().CM_STORE_SERVER_INS_PROC(vo);
	}
	
	public String CM_STORE_DB_CONN_INFO_PROC (String strStoreNo) {
		ArrayList<LocalDatabaseInfoVO> arr = new LocalDatabaseDAO().CM_STORE_DB_CONN_INFO_PROC(strStoreNo);
		LocalDatabaseInfoVO vo = arr.get(0);
		String strUrl = "X";
		if (vo.DB_IP.length()>4 && vo.DB_PORT.length()>1 && vo.DB_NM.length()>1 && vo.DB_USER_NM.length()>0 && vo.DB_PW.length()>0) {
			strUrl = "jdbc:sqlserver://"+vo.DB_IP+":"+vo.DB_PORT+";databaseName="+vo.DB_NM+";user="+vo.DB_USER_NM+";password="+vo.DB_PW+";";
		}
		return strUrl;
	}
}
