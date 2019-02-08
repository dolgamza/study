package kr.co.beable.chain;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import kr.co.dw.mgr.ConnectionMgr;
import kr.co.dw.util.WrapPreparedStatementUtil;

public class ChainDAO {
	
	protected ArrayList<ChainVO.resLocationTapVO> FC_LOCATION_TAP_PROC(String strCoordinate){
		Connection conn									= ConnectionMgr.getInstance().getConnetion();
		WrapPreparedStatementUtil ps					= null;
		ResultSet rs									= null;
		Logger logger									= Logger.getLogger(this.getClass());
		ArrayList<ChainVO.resLocationTapVO> arrResult	= new ArrayList<ChainVO.resLocationTapVO>();
		
		try {
			
			ps = new WrapPreparedStatementUtil(conn, " EXEC DBO.FC_LOCATION_TAP_PROC ? ");
			ps.setString(1, strCoordinate);
			logger.debug(ps.getQueryString());
			rs = ps.executeQuery();
			
			while(rs.next()) {
				
				ChainVO.resLocationTapVO res = new ChainVO().new resLocationTapVO();
				res.TOT_CNT					 = rs.getString("TOT_CNT");
				res.SIDO_CD				 	 = rs.getString("SIDO_CD");
				res.SIDO_NM					 = rs.getString("SIDO_NM");
				res.LOC_COORDINATE		 	 = rs.getString("LOC_COORDINATE");
				res.LOC_LATITUDE			 = rs.getString("LOC_LATITUDE");
				res.LOC_LONGITUDE	     	 = rs.getString("LOC_LONGITUDE");
				res.CNT	 					 = rs.getString("CNT");
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
	
	protected ArrayList<ChainVO.resLocationMapVO> FC_LOCATION_MAP_PROC(String strLocCode, String strFcNm){
		Connection conn									= ConnectionMgr.getInstance().getConnetion();
		WrapPreparedStatementUtil ps					= null;
		ResultSet rs									= null;
		Logger logger									= Logger.getLogger(this.getClass());
		ArrayList<ChainVO.resLocationMapVO> arrResult	= new ArrayList<ChainVO.resLocationMapVO>();
		
		try {
			
			ps = new WrapPreparedStatementUtil(conn, " EXEC DBO.FC_LOCATION_MAP_PROC ?, ? ");
			ps.setString(1, strLocCode);
			ps.setString(2, strFcNm);
			logger.debug(ps.getQueryString());
			rs = ps.executeQuery();
			
			while(rs.next()) {
				
				ChainVO.resLocationMapVO res = new ChainVO().new resLocationMapVO();
				res.TCNT			= rs.getString("TCNT");
				res.RN				= rs.getString("RN");
				res.STORE_NO		= rs.getString("STORE_NO");
				res.STORE_NM		= rs.getString("STORE_NM");
				res.PHONE_NO		= rs.getString("PHONE_NO");
				res.ADDR			= rs.getString("ADDR");
				res.ZIP_CODE		= rs.getString("ZIP_CODE");
				res.COORDINATE		= rs.getString("COORDINATE");
				res.WEB_URL			= rs.getString("WEB_URL");
				res.IMG_URL			= rs.getString("IMG_URL");
				res.SIDO_CD			= rs.getString("SIDO_CD");
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
	
	protected ArrayList<ChainVO.resCenterListVO> FC_LOCATION_LIST_PROC(ChainVO.reqCenterListVO req){
		Connection conn									= ConnectionMgr.getInstance().getConnetion();
		WrapPreparedStatementUtil ps					= null;
		ResultSet rs									= null;
		Logger logger									= Logger.getLogger(this.getClass());
		ArrayList<ChainVO.resCenterListVO> arrResult	= new ArrayList<ChainVO.resCenterListVO>();
		
		try {
			
			int i = 1;
			ps = new WrapPreparedStatementUtil(conn, " EXEC DBO.FC_LOCATION_LIST_PROC ?,?,?,?");
			ps.setInt(i++, req.PAGE);
			ps.setInt(i++, req.BLOCKSIZE);
			ps.setString(i++, req.SEL_FG);
			ps.setString(i++, req.SEL_VAL);
			logger.debug(ps.getQueryString());
			System.out.println(ps.getQueryString());
			rs = ps.executeQuery();
			
			while(rs.next()) {
				
				ChainVO.resCenterListVO res = new ChainVO().new resCenterListVO();
				res.TCNT		= rs.getInt("TCNT");
				res.RN			= rs.getInt("RN");
				res.STORE_NO	= rs.getString("STORE_NO");
				res.STORE_NM	= rs.getString("STORE_NM");
				res.PHONE_NO	= rs.getString("PHONE_NO");
				res.ADDR		= rs.getString("ADDR");
				res.ZIP_CODE	= rs.getString("ZIP_CODE");
				res.COORDINATE	= rs.getString("COORDINATE");
				res.WEB_URL		= rs.getString("WEB_URL");
				res.IMG_URL		= rs.getString("IMG_URL");
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
	
	protected int CONTENT_US_PROC(ChainVO.reqContactUsVO ContactUsVO) {
			
		Connection conn					= ConnectionMgr.getInstance().getConnetion();
		WrapPreparedStatementUtil ps	= null;
		ResultSet                 rs   	= null;
		Logger logger					= Logger.getLogger(this.getClass());
		int isSuccess 					= 0;
		
		try {
			
			ps = new WrapPreparedStatementUtil(conn, " EXEC DBO.CONTENT_US_PROC ?, ?, ?, ? ");
			int i = 1;
			
			ps.setString(i++, ContactUsVO.F_NAME);
			ps.setString(i++, ContactUsVO.F_MAIL);
			ps.setString(i++, ContactUsVO.F_PHONE);
			ps.setString(i++, ContactUsVO.F_BIGO);
			
			logger.debug(ps.getQueryString());
			
			rs = ps.executeQuery();
			rs.next();
			isSuccess = rs.getInt("RESULT");
		} catch (Exception e) {
			logger.error(ps.getQueryString());
			System.out.println(e.toString());
		} finally {
			ConnectionMgr.getInstance().closeConnection(conn, ps, rs);
		}
		return isSuccess;
	}
}
