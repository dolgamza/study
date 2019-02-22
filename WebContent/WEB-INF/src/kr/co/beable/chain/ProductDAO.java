package kr.co.beable.chain;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import kr.co.dw.mgr.ConnectionMgr;
import kr.co.dw.util.WrapPreparedStatementUtil;

public class ProductDAO {

	protected ArrayList<ProductVO> PM_PRODUCT_LIST_PROC(String strStoreNo, String strRoomCd){
		Connection conn					= ConnectionMgr.getInstance().getConnetion();
		WrapPreparedStatementUtil ps	= null;
		ResultSet rs					= null;
		Logger logger					= Logger.getLogger(this.getClass());
		ArrayList<ProductVO> arrResult		= new ArrayList<ProductVO>();
		
		try {
			ps = new WrapPreparedStatementUtil(conn, " EXEC DBO.PM_PRODUCT_LIST_PROC ?, ? ");
			ps.setString(1, strStoreNo);
			ps.setString(2, strRoomCd);
			System.out.println(ps.getQueryString());
			rs = ps.executeQuery();
			
			while(rs.next()) {
				ProductVO vo = new ProductVO();
				vo.PRD_GRP_CD	= rs.getString("PRD_GRP_CD");
				vo.PRD_GRP_NM	= rs.getString("PRD_GRP_NM");
				vo.PRD_CD		= rs.getString("PRD_CD");
				vo.STORE_NO		= rs.getString("STORE_NO");
				vo.PRD_NM		= rs.getString("PRD_NM");
				vo.PRICE		= rs.getString("PRICE");
				arrResult.add(vo);
			}
			
		} catch (Exception e) {
			logger.error(ps.getQueryString());
			System.out.println(e.toString());
		} finally {
			ConnectionMgr.getInstance().closeConnection(conn, ps, rs);
		}
		return arrResult;
	}
	
	protected ArrayList<ProductVO> PM_PRODUCT_LIST_PROC(String strStoreNo, String strRoomCd, String strProductNo){
		Connection conn					= ConnectionMgr.getInstance().getConnetion();
		WrapPreparedStatementUtil ps	= null;
		ResultSet rs					= null;
		Logger logger					= Logger.getLogger(this.getClass());
		ArrayList<ProductVO> arrResult		= new ArrayList<ProductVO>();
		
		try {
			ps = new WrapPreparedStatementUtil(conn, " EXEC DBO.PM_PRODUCT_LIST_PROC2 ?, ?, ? ");
			ps.setString(1, strStoreNo);
			ps.setString(2, strRoomCd);
			ps.setString(3, strProductNo);
			//System.out.println(ps.getQueryString());
			rs = ps.executeQuery();
			
			while(rs.next()) {
				ProductVO vo 		= new ProductVO();
				vo.PRD_GRP_CD		= rs.getString("PRD_GRP_CD");
				vo.PRD_GRP_NM		= rs.getString("PRD_GRP_NM");
				vo.PRD_CD			= rs.getString("PRD_CD");
				vo.STORE_NO			= rs.getString("STORE_NO");
				vo.PRD_NM			= rs.getString("PRD_NM");
				vo.PRICE			= rs.getString("PRICE");
				vo.PRD_MATCHING_CD	= rs.getString("PRD_MATCHING_CD");
				vo.PRD_TIME			= rs.getString("PRD_TIME");
				vo.DELAY_YN			= rs.getString("DELAY_YN");
				arrResult.add(vo);
			}
			
		} catch (Exception e) {
			logger.error(ps.getQueryString());
			System.out.println(e.toString());
		} finally {
			ConnectionMgr.getInstance().closeConnection(conn, ps, rs);
		}
		return arrResult;
	}
	
	protected ArrayList<ProductVO> PM_ROOM_LIST_PROC(int strStoreNo, int strPrdCd){
		Connection conn					= ConnectionMgr.getInstance().getConnetion();
		WrapPreparedStatementUtil ps	= null;
		ResultSet rs					= null;
		Logger logger					= Logger.getLogger(this.getClass());
		ArrayList<ProductVO> arrResult		= new ArrayList<ProductVO>();
		
		try {
			ps = new WrapPreparedStatementUtil(conn, " EXEC DBO.PM_ROOM_LIST_PROC ?, ? ");
			ps.setInt(1, strStoreNo);
			ps.setInt(2, strPrdCd);
			System.out.println(ps.getQueryString());
			rs = ps.executeQuery();
			
			while(rs.next()) {
				ProductVO vo 		= new ProductVO();
				vo.STORE_NO			= rs.getString("STORE_NO");
				vo.PRD_CD			= rs.getString("PRD_CD");
				vo.PRD_NM			= rs.getString("PRD_NM");
				vo.ROOM_CD			= rs.getString("ROOM_CD");
				vo.SEAT_NO			= rs.getString("SEAT_NO");
				vo.PRD_GRP_CD		= rs.getString("PRD_GRP_CD");
				vo.SEAT_CD			= rs.getString("SEAT_CD");
				vo.SEAT_NM			= rs.getString("SEAT_NM");
				vo.PRD_TIME			= rs.getString("PRD_TIME");
				vo.DELAY_YN			= rs.getString("DELAY_YN");
				arrResult.add(vo);
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
