package kr.co.beable.space;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import kr.co.beable.space.SpaceVO;
import kr.co.dw.mgr.ConnectionMgr;
import kr.co.dw.util.WrapPreparedStatementUtil;

public class SpaceDAO {
	
	/**
	 * Space Image List...
	 * @return
	 */
	protected ArrayList<SpaceVO> SP_IMAGE_LIST_PROC(String tapCode){
		Connection conn									= ConnectionMgr.getInstance().getConnetion();
		WrapPreparedStatementUtil ps					= null;
		ResultSet rs									= null;
		Logger logger									= Logger.getLogger(this.getClass());
		ArrayList<SpaceVO> arrResult	= new ArrayList<SpaceVO>();
		
		try {
			
			ps = new WrapPreparedStatementUtil(conn, " EXEC DBO.SP_IMAGE_LIST_PROC ?");
			ps.setString(1, tapCode);
			logger.debug(ps.getQueryString());
			rs = ps.executeQuery();
			
			while(rs.next()) {
				
				SpaceVO res = new SpaceVO();
				
				res.SEQNO			= rs.getString("SEQNO");
				res.TAP_GUBUN		= rs.getString("TAP_GUBUN");
				res.IMG_NM			= rs.getString("IMG_NM");
				res.IMG_URL	 		= rs.getString("IMG_URL");
				res.ADDR_MAIN		= rs.getString("ADDR_MAIN");
				res.ADDR_DETAIL		= rs.getString("ADDR_DETAIL");
				res.TEL_NO			= rs.getString("TEL_NO");
				res.HOMEPAGE		= rs.getString("HOMEPAGE");
				res.WRITE_DT		= rs.getString("WRITE_DT");
				res.WRITE_USER		= rs.getString("WRITE_USER");
				res.MODIFY_DT		= rs.getString("MODIFY_DT");
				res.MODIFY_USER		= rs.getString("MODIFY_USER");
				res.USE_YN			= rs.getString("USE_YN");
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
