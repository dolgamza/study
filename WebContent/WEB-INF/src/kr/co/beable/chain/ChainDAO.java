package kr.co.beable.chain;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import kr.co.dw.mgr.ConnectionMgr;
import kr.co.dw.util.WrapPreparedStatementUtil;

public class ChainDAO {
	
	protected ArrayList<ChainVO.reqLocationTapVO> FC_LOCATION_TAP_PROC(String strCoordinate){
		Connection conn									= ConnectionMgr.getInstance().getConnetion();
		WrapPreparedStatementUtil ps					= null;
		ResultSet rs									= null;
		Logger logger									= Logger.getLogger(this.getClass());
		ArrayList<ChainVO.reqLocationTapVO> arrResult	= new ArrayList<ChainVO.reqLocationTapVO>();
		
		try {
			
			ps = new WrapPreparedStatementUtil(conn, " EXEC DBO.FC_LOCATION_TAP_PROC ? ");
			ps.setString(1, strCoordinate);
			logger.debug(ps.getQueryString());
			rs = ps.executeQuery();
			
			while(rs.next()) {
				
				ChainVO.reqLocationTapVO res = new ChainVO().new reqLocationTapVO();
				res.TOT_CNT					 = rs.getString("TOT_CNT");
				res.MM_LOC_CODE				 = rs.getString("MM_LOC_CODE");
				res.MM_LOC_NM				 = rs.getString("MM_LOC_NM");
				res.MM_LOC_COORDINATE		 = rs.getString("MM_LOC_COORDINATE");
				res.MM_LOC_LATITUDE			 = rs.getString("MM_LOC_LATITUDE");
				res.MM_LOC_LONGITUDE	     = rs.getString("MM_LOC_LONGITUDE");
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
	
	protected ArrayList<ChainVO.reqLocationMapVO> FC_LOCATION_MAP_PROC(){
		Connection conn									= ConnectionMgr.getInstance().getConnetion();
		WrapPreparedStatementUtil ps					= null;
		ResultSet rs									= null;
		Logger logger									= Logger.getLogger(this.getClass());
		ArrayList<ChainVO.reqLocationMapVO> arrResult	= new ArrayList<ChainVO.reqLocationMapVO>();
		
		try {
			
			ps = new WrapPreparedStatementUtil(conn, " EXEC DBO.FC_LOCATION_MAP_PROC");
			logger.debug(ps.getQueryString());
			rs = ps.executeQuery();
			
			while(rs.next()) {
				
				ChainVO.reqLocationMapVO res = new ChainVO().new reqLocationMapVO();
				res.FC_NO			= rs.getString("FC_NO");
				res.FC_NM			= rs.getString("FC_NM");
				res.FC_MAIN_TEL_NO	= rs.getString("FC_MAIN_TEL_NO");
				res.FC_ADDR			= rs.getString("FC_ADDR");
				res.FC_ZIP_CODE		= rs.getString("FC_ZIP_CODE");
				res.FC_COORDINATE	= rs.getString("FC_COORDINATE");
				res.FC_HOMEPAGE		= rs.getString("FC_HOMEPAGE");
				res.FC_THUMBNAIL	= rs.getString("FC_THUMBNAIL");
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
