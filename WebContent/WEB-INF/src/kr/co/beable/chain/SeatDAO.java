package kr.co.beable.chain;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import kr.co.dw.mgr.ConnectionMgr;
import kr.co.dw.util.WrapPreparedStatementUtil;

public class SeatDAO {
	
	protected ArrayList<SeatVO> CM_SEATS_PROC(String strStoreNo){
		Connection conn					= ConnectionMgr.getInstance().getConnetion();
		WrapPreparedStatementUtil ps	= null;
		ResultSet rs					= null;
		Logger logger					= Logger.getLogger(this.getClass());
		ArrayList<SeatVO> arrResult		= new ArrayList<SeatVO>();
		
		try {
			ps = new WrapPreparedStatementUtil(conn, " EXEC DBO.CM_SEATS_PROC ? ");
			ps.setString(1, strStoreNo);
			logger.debug(ps.getQueryString());
			rs = ps.executeQuery();
			
			while(rs.next()) {
				SeatVO vo = new SeatVO();
				vo.STORE_NO	= rs.getString("STORE_NO");
				vo.ROOM_CD	= rs.getString("ROOM_CD");
				vo.ROW_NO	= rs.getString("ROW_NO");
				vo.SEAT		= castArray(rs.getString("SEAT"));
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
	
	private String castArray(String s) {
		return "['" + s.replaceAll(",", "','") + "'],";
	}
}
