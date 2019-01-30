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
			logger.debug(ps.getQueryString());
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
	
}
