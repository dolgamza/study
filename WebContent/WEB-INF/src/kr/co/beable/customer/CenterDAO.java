package kr.co.beable.customer;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import kr.co.dw.mgr.ConnectionMgr;
import kr.co.dw.util.WrapPreparedStatementUtil;

public class CenterDAO {
	
	protected ArrayList<CenterVO.resCenterAllVO> CM_ALL_STORE_LIST_PROC(){
		Connection conn									= ConnectionMgr.getInstance().getConnetion();
		WrapPreparedStatementUtil ps					= null;
		ResultSet rs									= null;
		Logger logger									= Logger.getLogger(this.getClass());
		ArrayList<CenterVO.resCenterAllVO> arrResult	= new ArrayList<CenterVO.resCenterAllVO>();
		
		try {
			
			int i = 1;
			ps = new WrapPreparedStatementUtil(conn, " EXEC DBO.CM_ALL_STORE_LIST_PROC");
			
			logger.debug(ps.getQueryString());
			System.out.println(ps.getQueryString());
			rs = ps.executeQuery();
			
			while(rs.next()) {
				
				CenterVO.resCenterAllVO res = new CenterVO().new resCenterAllVO();
				res.STORE_NM	= rs.getString("STORE_NM");
				res.SIGUGUN_CD	= rs.getString("SIGUGUN_CD");
				res.SIDO_NM		= rs.getString("SIDO_NM");
				res.SIGUGUN_NM	= rs.getString("SIGUGUN_NM");
				res.LOC_SEQ		= rs.getString("LOC_SEQ");
				arrResult.add(res);
			}
			
		} catch (Exception e) {
			logger.error(ps.getQueryString());
			System.out.println(e.toString());
		} finally {
			System.out.println(ps.getQueryString());
			ConnectionMgr.getInstance().closeConnection(conn, ps, rs);
		}
		return arrResult;
	}
	
	protected ArrayList<CenterVO.resCenterDetailVO> CM_STORE_DETAIL_PROC(int paramStoreNo){
		Connection conn									= ConnectionMgr.getInstance().getConnetion();
		WrapPreparedStatementUtil ps					= null;
		ResultSet rs									= null;
		Logger logger									= Logger.getLogger(this.getClass());
		ArrayList<CenterVO.resCenterDetailVO> arrResult	= new ArrayList<CenterVO.resCenterDetailVO>();
		
		try {
			
			ps = new WrapPreparedStatementUtil(conn, " EXEC DBO.CM_STORE_DETAIL_PROC ? ");
			ps.setInt(1, paramStoreNo);
			logger.debug(ps.getQueryString());
			System.out.println(ps.getQueryString());
			rs = ps.executeQuery();
			
			while(rs.next()) {
				
				CenterVO.resCenterDetailVO res = new CenterVO().new resCenterDetailVO();
				res.STORE_NO	= rs.getString("STORE_NO");
				res.STORE_NM	= rs.getString("STORE_NM");
				res.PHONE_NO	= rs.getString("PHONE_NO");
				res.ADDR		= rs.getString("ADDR");
				res.COORDINATE	= rs.getString("COORDINATE");
				res.DB_IP		= rs.getString("DB_IP");
				res.DB_PORT		= rs.getString("DB_PORT");
				res.DB_NM		= rs.getString("DB_NM");
				res.DB_USER_NM	= rs.getString("DB_USER_NM");
				res.DB_PW		= rs.getString("DB_PW");
				res.IMG_PATH	= rs.getString("IMG_PATH");
				arrResult.add(res);
			}
			
		} catch (Exception e) {
			logger.error(ps.getQueryString());
			System.out.println(e.toString());
		} finally {
			System.out.println(ps.getQueryString());
			ConnectionMgr.getInstance().closeConnection(conn, ps, rs);
		}
		return arrResult;
	}
}
