package kr.co.beable.settle;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import kr.co.beable.inf.LocalDatabaseBean;
import kr.co.dw.mgr.ConnectionMgr;
import kr.co.dw.util.WrapPreparedStatementUtil;

public class SettleDAO {
	
	protected ArrayList<SettleVO.resSettleListVO> SM_SETTLE_LIST_PROC (SettleVO.reqSettleListVO req) {
		Connection conn					= ConnectionMgr.getInstance().getConnetion();
		WrapPreparedStatementUtil ps	= null;
		ResultSet rs					= null;
		Logger logger					= Logger.getLogger(this.getClass());
		
		ArrayList<SettleVO.resSettleListVO> arrResult = new ArrayList<SettleVO.resSettleListVO>();
		try {
			ps = new WrapPreparedStatementUtil(conn, " EXEC DBO.SM_SETTLE_LIST_PROC ?, ?, ?, ?, ? ");
			int i = 1;
			ps.setInt(i++		, req.PAGE);
			ps.setInt(i++		, req.BLOCKSIZE);
			ps.setString(i++	, req.USR_PHONE_NO);
			ps.setString(i++	, req.SEL_FG);
			ps.setString(i++	, req.SEL_VAL);
			logger.debug(ps.getQueryString());
			rs = ps.executeQuery();
			
			while(rs.next()) {
				SettleVO.resSettleListVO res = new SettleVO().new resSettleListVO();
				
				res.TCNT			= rs.getInt("TCNT");
				res.RN				= rs.getInt("RN");
				res.STORE_NO		= rs.getInt("STORE_NO");
				res.STORE_NM		= rs.getString("STORE_NM");
				res.USR_PHONE_NO	= rs.getString("USR_PHONE_NO");
				res.CARD_NO			= rs.getInt("CARD_NO");
				res.USR_PHONE_NO	= rs.getString("USR_PHONE_NO");
				res.PRD_GRP_NM		= rs.getString("PRD_GRP_NM");
				res.PRD_CD			= rs.getInt("PRD_CD");
				res.PRD_NM			= rs.getString("PRD_NM");
				res.ROOM_CD			= rs.getString("ROOM_CD");
				res.ROOM_NM			= rs.getString("ROOM_NM");
				res.SEAT_NO			= rs.getInt("SEAT_NO");
				res.SEAT_NM			= rs.getString("SEAT_NM");
				res.PAY_AMT			= rs.getString("PAY_AMT");
				res.METHOD_CD		= rs.getString("METHOD_CD");
				res.METHOD_NM		= rs.getString("METHOD_NM");
				res.PAY_DT			= rs.getString("PAY_DT");
				res.PAY_DATE		= rs.getString("PAY_DATE");
				res.STATUS_CD		= rs.getString("STATUS_CD");
				res.STATUS_NM		= rs.getString("STATUS_NM");
				
				arrResult.add(res);
			}
			
		} catch (Exception e) {
			logger.error(ps.getQueryString());
			System.out.println(e.toString());
		} finally {
			ConnectionMgr.getInstance().closeConnection(conn, ps, rs);
		}
		return arrResult;
	}
	

}
