package kr.co.beable.settle;

import java.sql.Connection;
import java.sql.ResultSet;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import org.apache.log4j.Logger;

import kr.co.beable.inf.LocalDatabaseBean;
import kr.co.dw.util.DateUtil;
import kr.co.dw.util.WrapPreparedStatementUtil;

public class LocalSeatDAO {

	protected ArrayList<LocalSeatVO> TM_GET_SEAT_STATUS_TOTAL (String strStoreNo) {
		Logger logger 					= Logger.getLogger(this.getClass());
		LocalDatabaseBean ldb			= new LocalDatabaseBean();
		Connection conn					= ldb.getLocalConnection(strStoreNo);
		WrapPreparedStatementUtil ps	= null;
		ResultSet rs					= null;
		ArrayList<LocalSeatVO> arr		= new ArrayList<LocalSeatVO>();
		
		try {
			ps = new WrapPreparedStatementUtil(conn, " EXEC DBO.TM_GET_SEAT_STATUS_TOTAL ");
			logger.debug(ps.getQueryString());
			rs = ps.executeQuery();
			while(rs.next()) {
				LocalSeatVO vo = new LocalSeatVO();
				vo.SEAT = rs.getString("SEAT");
				vo.USING = rs.getString("USING");
				// if (vo.SEAT.equals("10") || vo.SEAT.equals("11")) vo.USING = "Y"; // test
				arr.add(vo);
			}
		} catch (Exception e) {
			logger.error(e.toString());
		} finally {
			try {
				rs.close();
			} catch (Exception e) {
				logger.error(e.toString());
			}
			try {
				ps.close();
			} catch (Exception e) {
				logger.error(e.toString());
			}
			ldb.closeLocalConnection(conn);
		}
		return arr;
	}
	
	protected ArrayList<LocalSeatVO> TM_GET_RESERVATION_STUDYROOM (String strStoreNo, String strSeatNo) {
		
		Logger logger 					= Logger.getLogger(this.getClass());
		LocalDatabaseBean ldb			= new LocalDatabaseBean();
		Connection conn					= ldb.getLocalConnection(strStoreNo);
		WrapPreparedStatementUtil ps	= null;
		ResultSet rs					= null;
		ArrayList<LocalSeatVO> arr		= new ArrayList<LocalSeatVO>();
		
		String strQuery = "";
		
		StringBuffer sb = new StringBuffer();
		sb.append("SELECT ROW_NUMBER() OVER ( ORDER BY CASE WHEN B.SEAT= CONVERT( VARCHAR,"+Integer.parseInt(strSeatNo)+") THEN -1  \n");
		sb.append("                                         ELSE B.SEAT                                       \n");
		sb.append("                                     END                                                   \n");
		sb.append("                         ) IDX                                                             \n");
		sb.append("	 , B.NAME                                                                                 \n");
		sb.append("	 , CASE WHEN ISNUMERIC(A.NAME) = 1 THEN A.NAME                                            \n");
		sb.append("			ELSE LEFT(A.NAME,1) + '○' + SUBSTRING(A.NAME,3,10)                                \n");
		sb.append("		END AS RESERVATION_NAME                                                               \n");
		sb.append("	 , CONVERT( VARCHAR, SD, 108) + CHAR(10) + '~ ' + CONVERT( VARCHAR, ED, 108) AS RESERVATION_TIME \n");
		sb.append("	 , ISNULL(A.CNT,0) CNT                                                                    \n");
		sb.append("	 , REPLICATE('*', LEN( A.HP)) AS RESERVATION_HP                                           \n");
		sb.append("	 , RESERVATION                                                                            \n");
		sb.append("	 , A.HP                                                                                   \n");
		sb.append("	 , A.SD                                                                                   \n");
		sb.append("	 , A.ED                                                                                   \n");
		sb.append("	 , A.SEAT                                                                                 \n");
		sb.append("  FROM 			                                                                          \n");
		sb.append("       ( SELECT *                                                                          \n");
		sb.append("		   FROM	Reservation                                                                   \n");
		sb.append("		  WHERE	1=1                                                                           \n");
		sb.append("		    AND CONVERT(VARCHAR, SD,112) LIKE '" + DateUtil.getCurrentDate() + "%'");
		sb.append("	        AND GETDATE() < ED                                                                \n");
		sb.append("		  UNION ALL                                                                           \n");
		sb.append("		 SELECT '' AS RESERVATION                                                             \n");
		sb.append("			  , '' AS HP                                                                      \n");
		sb.append("			  , A.SD                                                                          \n");
		sb.append("			  , A.RD                                                                          \n");
		sb.append("			  , A.ED                                                                          \n");
		sb.append("			  , SAVETIME                                                                      \n");
		sb.append("			  , A.CASH                                                                        \n");
		sb.append("			  , A.TMR                                                                         \n");
		sb.append("			  , A.POINT                                                                       \n");
		sb.append("			  , RFIDFEE                                                                       \n");
		sb.append("			  , SEAT                                                                          \n");
		sb.append("			  , CNT                                                                           \n");
		sb.append("			  , RECEIPT                                                                       \n");
		sb.append("			  , CONVERT(VARCHAR, R.RFIDNUMBER) AS RFIDNUMBER                                  \n");
		sb.append(" 		   FROM RECORD A                                                                  \n");
		sb.append("		  INNER JOIN RFID R ON A.RFID = R.RFID                                                \n");
		sb.append("		  WHERE 1=1			                                                                  \n");
		sb.append("			AND CONVERT(VARCHAR, A.SD,112) = CONVERT(VARCHAR, GETDATE(),112)                  \n");
		sb.append("			AND GETDATE() < A.ED                                                              \n");
		sb.append("			AND SEAT > 100                                                                    \n");
		sb.append("      ) A                                                                                  \n");
		sb.append(" INNER JOIN SEAT B ON A.SEAT = B.SEAT                                                      \n");
		sb.append(" WHERE A.SEAT = "+Integer.parseInt(strSeatNo));
		
		strQuery = sb.toString();
		
		try {
			ps = new WrapPreparedStatementUtil(conn, strQuery);
			logger.debug(ps.getQueryString());
			System.out.println(ps.getQueryString());
			rs = ps.executeQuery();
			while(rs.next()) {
				LocalSeatVO vo 		= new LocalSeatVO();
				vo.IDX 				= rs.getString("IDX");
				vo.NAME 			= rs.getString("NAME");
				vo.RESERVATION_NAME = rs.getString("RESERVATION_NAME");
				vo.RESERVATION_TIME = rs.getString("RESERVATION_TIME");
				vo.CNT 				= rs.getString("CNT");
				vo.RESERVATION_HP 	= rs.getString("RESERVATION_HP");
				vo.RESERVATION 		= rs.getString("RESERVATION");
				vo.HP 				= rs.getString("HP");
				vo.SD 				= rs.getString("SD");
				vo.ED 				= rs.getString("ED");
				vo.SEAT 			= rs.getString("SEAT");
				arr.add(vo);
			}
		} catch (Exception e) {
			logger.error(e.toString());
		} finally {
			try {
				rs.close();
			} catch (Exception e) {
				logger.error(e.toString());
			}
			try {
				ps.close();
			} catch (Exception e) {
				logger.error(e.toString());
			}
			ldb.closeLocalConnection(conn);
		}
		return arr;
	}
	
	protected int TM_GET_USING_CHK(String strStoreNo, String strSeatNo, String strSDate, int intUseMinute) {
		
		int intRtn = -1;
		
		Logger logger 					= Logger.getLogger(this.getClass());
		LocalDatabaseBean ldb			= new LocalDatabaseBean();
		Connection conn					= ldb.getLocalConnection(strStoreNo);
		WrapPreparedStatementUtil ps	= null;
		ResultSet rs					= null;
		
		String strQuery = "";
		
		StringBuffer sb = new StringBuffer();
		
		sb.append("SELECT COUNT(*) AS CNT                                                                     \n");
		sb.append("  FROM 			                                                                          \n");
		sb.append("       ( SELECT *                                                                          \n");
		sb.append("		   FROM	Reservation                                                                   \n");
		sb.append("		  WHERE	1=1                                                                           \n");
		sb.append("		    AND CONVERT(VARCHAR, SD,112) LIKE '" + DateUtil.getCurrentDate() + "%'");
		sb.append("	        AND GETDATE() < ED                                                                \n");
		sb.append("		  UNION ALL                                                                           \n");
		sb.append("		 SELECT '' AS RESERVATION                                                             \n");
		sb.append("			  , '' AS HP                                                                      \n");
		sb.append("			  , A.SD                                                                          \n");
		sb.append("			  , A.RD                                                                          \n");
		sb.append("			  , A.ED                                                                          \n");
		sb.append("			  , SAVETIME                                                                      \n");
		sb.append("			  , A.CASH                                                                        \n");
		sb.append("			  , A.TMR                                                                         \n");
		sb.append("			  , A.POINT                                                                       \n");
		sb.append("			  , RFIDFEE                                                                       \n");
		sb.append("			  , SEAT                                                                          \n");
		sb.append("			  , CNT                                                                           \n");
		sb.append("			  , RECEIPT                                                                       \n");
		sb.append("			  , CONVERT(VARCHAR, R.RFIDNUMBER) AS RFIDNUMBER                                  \n");
		sb.append(" 		   FROM RECORD A                                                                  \n");
		sb.append("		  INNER JOIN RFID R ON A.RFID = R.RFID                                                \n");
		sb.append("		  WHERE 1=1			                                                                  \n");
		sb.append("			AND CONVERT(VARCHAR, A.SD,112) = CONVERT(VARCHAR, GETDATE(),112)                  \n");
		sb.append("			AND GETDATE() < A.ED                                                              \n");
		sb.append("			AND SEAT > 100                                                                    \n");
		sb.append("      ) A                                                                                  \n");
		sb.append(" INNER JOIN SEAT B ON A.SEAT = B.SEAT                                                      \n");
		sb.append(" WHERE A.SEAT = "+Integer.parseInt(strSeatNo));
		sb.append("   AND ( 																				  \n");
		sb.append("         (SD >= '"+strSDate+"' AND ED <= DATEADD(MINUTE, "+intUseMinute+", '"+strSDate+"'))\n");
		sb.append("       OR 																				  \n");
		sb.append("    		(SD <= '"+strSDate+"' AND ED >= DATEADD(MINUTE, "+intUseMinute+", '"+strSDate+"'))\n");
		sb.append("       OR 																				  \n");
		sb.append("    		SD BETWEEN '"+strSDate+"' AND DATEADD(MINUTE, "+intUseMinute+", '"+strSDate+"')   \n");
		sb.append("       OR 																				  \n");
		sb.append("    		ED BETWEEN '"+strSDate+"' AND DATEADD(MINUTE, "+intUseMinute+", '"+strSDate+"')   \n");
		sb.append("    	  )																			  		  \n");
		
		strQuery = sb.toString();
		
		try {
			ps = new WrapPreparedStatementUtil(conn, strQuery);
			logger.debug(ps.getQueryString());
			System.out.println(ps.getQueryString());
			rs = ps.executeQuery();
			if(rs.next()) {
				intRtn = rs.getInt("CNT");
			}
		} catch (Exception e) {
			logger.error(e.toString());
		} finally {
			try {
				rs.close();
			} catch (Exception e) {
				logger.error(e.toString());
			}
			try {
				ps.close();
			} catch (Exception e) {
				logger.error(e.toString());
			}
			ldb.closeLocalConnection(conn);
		}
		return intRtn;
	}
	
	public static void main(String args[]) throws ParseException {
		
	}
	
}
