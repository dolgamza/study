package kr.co.beable.settle;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import kr.co.beable.inf.LocalDatabaseBean;
import kr.co.dw.mgr.ConnectionMgr;
import kr.co.dw.util.WrapPreparedStatementUtil;

public class InipayDAO {
	
	/**
	 * PG Settle info Insert
	 * @param req
	 * @return
	 */
	protected int PG_SETTLE_INFO_INS_PROC (InipayVO.reqPgSettleVO req) {
		Connection conn					= ConnectionMgr.getInstance().getConnetion();
		WrapPreparedStatementUtil ps	= null;
		ResultSet rs					= null;
		Logger logger					= Logger.getLogger(this.getClass());
		
		int intResult = -1;
		try {
			ps = new WrapPreparedStatementUtil(conn, " EXEC DBO.PG_SETTLE_INFO_INS_PROC ?, ?, ?, ? ");
			int i = 1;
			ps.setInt(i++		, req.STORE_NO);
			ps.setString(i++	, req.USR_PHONE_NO);
			ps.setInt(i++		, req.CARD_NO);
			ps.setString(i++	, req.DATA_XML);
			logger.debug(ps.getQueryString());
			rs = ps.executeQuery();
			
			rs.next();
			
			if (rs.getInt("RESULT") == 0) {
				intResult	= rs.getInt("PG_SETTLE_SEQ");
			}
			
			
		} catch (Exception e) {
			logger.error(ps.getQueryString());
			System.out.println(e.toString());
		} finally {
			ConnectionMgr.getInstance().closeConnection(conn, ps);
		}
		return intResult;
	}
	
	/**
	 * SM_SETTLE_TB Insert
	 * @param req
	 * @return
	 */
	protected int SM_SETTLE_INS_PROC (InipayVO.reqSmSettleVO req) {
		Connection conn					= ConnectionMgr.getInstance().getConnetion();
		WrapPreparedStatementUtil ps	= null;
		ResultSet rs					= null;
		Logger logger					= Logger.getLogger(this.getClass());
		
		int intResult = -1;
		try {
			ps = new WrapPreparedStatementUtil(conn, " EXEC DBO.SM_SETTLE_INS_PROC ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ? ");
			int i = 1;
			ps.setInt(i++	, req.STORE_NO);
			ps.setInt(i++	, req.SEAT_NO);
			ps.setString(i++, req.ROOM_CD);
			ps.setInt(i++	, req.PRD_CD);
			ps.setString(i++, req.USR_PHONE_NO);
			ps.setInt(i++	, req.CARD_NO);
			ps.setString(i++, req.PRICE);
			ps.setString(i++, req.PG_NO);
			ps.setString(i++, req.PAY_AMT);
			ps.setString(i++, req.METHOD_CD);
			ps.setString(i++, req.STATUS_CD);
			ps.setString(i++, req.PAY_DT);
			
			logger.debug(ps.getQueryString());
			System.out.println(ps.getQueryString());
			rs = ps.executeQuery();
			
			rs.next();
			
			intResult = rs.getInt("RESULT");
		} catch (Exception e) {
			logger.error(ps.getQueryString());
			System.out.println(e.toString());
		} finally {
			ConnectionMgr.getInstance().closeConnection(conn, ps);
		}
		return intResult;
	}
	
	/**
	 * Product Seat Info Select
	 * @param req
	 * @return
	 */
	protected ArrayList<InipayVO.resSmProductSeatVO> SM_PRODUCT_SEAT_INFO_PROC (InipayVO.reqSmProductSeatVO req) {
		Connection conn					= ConnectionMgr.getInstance().getConnetion();
		WrapPreparedStatementUtil ps	= null;
		ResultSet rs					= null;
		Logger logger					= Logger.getLogger(this.getClass());
		
		ArrayList<InipayVO.resSmProductSeatVO> arrResult = new ArrayList<InipayVO.resSmProductSeatVO>();
		try {
			ps = new WrapPreparedStatementUtil(conn, " EXEC DBO.SM_PRODUCT_SEAT_INFO_PROC ?, ?, ?, ? ");
			int i = 1;
			ps.setInt(i++	, req.STORE_NO);
			ps.setInt(i++	, req.SEAT_NO);
			ps.setString(i++, req.ROOM_CD);
			ps.setInt(i++	, req.PRD_CD);
			
			logger.debug(ps.getQueryString());
			System.out.println(ps.getQueryString());
			rs = ps.executeQuery();
			
			while(rs.next()) {
				InipayVO.resSmProductSeatVO VO = new InipayVO().new resSmProductSeatVO();
				VO.PRD_GRP_CD		= rs.getString("PRD_GRP_CD");
				VO.PRD_GRP_NM		= rs.getString("PRD_GRP_NM");
				VO.PRD_CD			= rs.getInt("PRD_CD");
				VO.PRD_NM			= rs.getString("PRD_NM");
				VO.STORE_NO			= rs.getInt("STORE_NO");
				VO.PRD_MATCHING_CD	= rs.getString("PRD_MATCHING_CD");
				VO.METHOD_NM		= rs.getString("METHOD_NM");
				VO.ROOM_CD			= rs.getString("ROOM_CD");
				VO.PRD_TIME			= rs.getInt("PRD_TIME");
				VO.MEM_CNT			= rs.getInt("MEM_CNT");
				VO.SEAT_NO			= rs.getInt("SEAT_NO");
				VO.SEAT_CD			= rs.getString("SEAT_CD");
				
				arrResult.add(VO);
			}
			
		} catch (Exception e) {
			logger.error(ps.getQueryString());
			System.out.println(e.toString());
		} finally {
			ConnectionMgr.getInstance().closeConnection(conn, ps);
		}
		return arrResult;
	}
	
	/**
	 * Store LocalDatabase IUD_REFILL Insert
	 * @param strStoreNo
	 * @param strRfId
	 * @param strReceipt
	 * @param strCash
	 * @param strCashGubun
	 * @param strMethod
	 * @param intTmr
	 * @param strHp
	 * @return
	 */
	protected boolean IUD_REFILL_INS_PROC (InipayVO.reqIudRefillVO req) {
		Logger logger 					= Logger.getLogger(this.getClass());
		LocalDatabaseBean ldb			= new LocalDatabaseBean();
		Connection conn					= ldb.getLocalConnection(req.STORE_NO);
		WrapPreparedStatementUtil ps	= null;
		ResultSet rs					= null;
		boolean blInsResult				= false;
		try {
			ps = new WrapPreparedStatementUtil(conn, " EXEC DBO.IUD_REFILL ?, ?, ?, ?, ?,  ?, ? ");
			
			int i = 1;
			ps.setString(i++, req.RFID);
			ps.setString(i++, req.RECEIPT);
			ps.setString(i++, req.CASH);
			ps.setString(i++, req.CASHGUBUN);
			ps.setString(i++, req.METHOD);
			ps.setInt(i++, req.TMR);
			ps.setString(i++, req.HP);
			logger.debug(ps.getQueryString());
			System.out.println(ps.getQueryString());
			
			rs = ps.executeQuery();
			String strMusic	= "";
			String strMsg	= "";
			while(rs.next()) {
				strMusic	= rs.getString("MUSIC");
				strMsg		= rs.getString("MSG");
			}
			
			if("충전".equals(strMusic)) {
				blInsResult = true;
			}
			
			System.out.println("blInsResult:"+blInsResult+", Msg:"+strMsg);
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
		return blInsResult;
	}
	
	/**
	 * Store LocalDatabase Check to RFIDREFILL Data
	 * @param strStoreNo
	 * @param strRfId
	 * @param strReceipt
	 * @return
	 */
	protected int RFIDREFILL_SEL_PROC (InipayVO.reqIudRefillVO req) {
		Logger logger 					= Logger.getLogger(this.getClass());
		LocalDatabaseBean ldb			= new LocalDatabaseBean();
		Connection conn					= ldb.getLocalConnection(req.STORE_NO);
		WrapPreparedStatementUtil ps	= null;
		ResultSet rs					= null;
		int intResult					= -1;
		try {
			ps = new WrapPreparedStatementUtil(conn, " SELECT COUNT(1) AS CNT FROM RFIDREFILL WITH (NOLOCK) WHERE RECEIPT = ? AND RFID = ? ; ");
			int i = 1;
			ps.setString(i++, req.RECEIPT);
			ps.setString(i++, req.RFID);
			logger.debug(ps.getQueryString());
			System.out.println(ps.getQueryString());
			rs = ps.executeQuery();
			rs.next();
			
			intResult = rs.getInt("CNT");
			System.out.println("intResult:"+intResult);
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
		return intResult;
	}
	
	protected boolean IUD_RECORD_INS_PROC (InipayVO.reqIudRecordVO req) {
		Logger logger 					= Logger.getLogger(this.getClass());
		LocalDatabaseBean ldb			= new LocalDatabaseBean();
		Connection conn					= ldb.getLocalConnection(req.STORE_NO);
		WrapPreparedStatementUtil ps	= null;
		ResultSet rs					= null;
		boolean blInsResult				= false;
		
		try {
			ps = new WrapPreparedStatementUtil(conn, " EXEC DBO.IUD_RECORD ?, ?, ?, ?, ?,  ?, ?, ?, ? ");
			
			int i = 1;
			ps.setString(i++, req.RECEIPT);
			ps.setString(i++, req.SEAT);
			ps.setString(i++, req.RFID);
			ps.setString(i++, req.FEE);
			ps.setString(i++, req.CASHERTYPE);
			ps.setInt(i++, req.TMR);
			ps.setString(i++, req.HP);
			ps.setString(i++, req.ROOMTMR);
			ps.setInt(i++, req.MEMCNT);
			logger.debug(ps.getQueryString());
			System.out.println(ps.getQueryString());
			
			rs = ps.executeQuery();
			
			String strMusic		= "";
			String strMsg		= "";
			while(rs.next()) {
				strMusic	= rs.getString("MUSIC");
				strMsg		= rs.getString("MSG");
			}
			
			if("사용승인".equals(strMusic)) {
				blInsResult = true;
			}
			
			System.out.println("blInsResult:"+blInsResult+", Msg:"+strMsg);
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
		return blInsResult;
	}
	
	protected int RECORD_SEL_PROC (InipayVO.reqIudRecordVO req) {
		Logger logger 					= Logger.getLogger(this.getClass());
		LocalDatabaseBean ldb			= new LocalDatabaseBean();
		Connection conn					= ldb.getLocalConnection(req.STORE_NO);
		WrapPreparedStatementUtil ps	= null;
		ResultSet rs					= null;
		int intResult					= -1;
		try {
			ps = new WrapPreparedStatementUtil(conn, " SELECT COUNT(1) AS CNT FROM RECORD WITH (NOLOCK) WHERE RECEIPT = ? AND RFID = ? ; ");
			int i = 1;
			ps.setString(i++, req.RECEIPT);
			ps.setString(i++, req.RFID);
			logger.debug(ps.getQueryString());
			System.out.println(ps.getQueryString());
			rs = ps.executeQuery();
			rs.next();
			
			intResult = rs.getInt("CNT");
			System.out.println("intResult:"+intResult);
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
		return intResult;
	}
	
	protected boolean IUD_DELAY_UPD_PROC (InipayVO.reqIudDelayVO req) {
		Logger logger 					= Logger.getLogger(this.getClass());
		LocalDatabaseBean ldb			= new LocalDatabaseBean();
		Connection conn					= ldb.getLocalConnection(req.STORE_NO);
		WrapPreparedStatementUtil ps	= null;
		ResultSet rs					= null;
		boolean blInsResult				= false;
		
		try {
			ps = new WrapPreparedStatementUtil(conn, " EXEC DBO.IUD_DELAY ?, ?, ?, ?, ?,  ?, ? ");
			
			int i = 1;
			ps.setString(i++, req.RFID);
			ps.setInt(i++, req.SEAT);
			ps.setInt(i++, req.TMR);
			ps.setInt(i++, req.CASH);
			ps.setInt(i++, req.CARD);
			ps.setInt(i++, req.POINT);
			ps.setInt(i++, req.RFIDFEE);
			logger.debug(ps.getQueryString());
			System.out.println(ps.getQueryString());
			
			rs = ps.executeQuery();
			
			String strMusic		= "";
			String strMsg		= "";
			while(rs.next()) {
				strMusic	= rs.getString("MUSIC");
				strMsg		= rs.getString("MSG");
			}
			
			if("사용승인".equals(strMusic)) {
				blInsResult = true;
			}
			
			System.out.println("blInsResult:"+blInsResult+", Msg:"+strMsg);
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
		return blInsResult;
	}
}
