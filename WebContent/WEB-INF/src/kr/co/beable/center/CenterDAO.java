package kr.co.beable.center;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import kr.co.dw.mgr.ConnectionMgr;
import kr.co.dw.util.WrapPreparedStatementUtil;

public class CenterDAO {
	
	protected ArrayList<CenterVO.resLocationMapVO> FC_LOCATION_LIST_PROC(CenterVO.reqLocationMapVO req){
		Connection conn									= ConnectionMgr.getInstance().getConnetion();
		WrapPreparedStatementUtil ps					= null;
		ResultSet rs									= null;
		Logger logger									= Logger.getLogger(this.getClass());
		ArrayList<CenterVO.resLocationMapVO> arrResult	= new ArrayList<CenterVO.resLocationMapVO>();
		
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
				
				CenterVO.resLocationMapVO res = new CenterVO().new resLocationMapVO();
				res.TCNT			= rs.getInt("TCNT");
				res.RN				= rs.getInt("RN");
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
			System.out.println(ps.getQueryString());
			ConnectionMgr.getInstance().closeConnection(conn, ps, rs);
		}
		return arrResult;
	}
}
