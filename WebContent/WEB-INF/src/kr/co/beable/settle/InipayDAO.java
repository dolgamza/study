package kr.co.beable.settle;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import kr.co.dw.mgr.ConnectionMgr;
import kr.co.dw.util.WrapPreparedStatementUtil;

public class InipayDAO {
	
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
}
