package kr.co.beable.settle;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import kr.co.beable.inf.LocalDatabaseBean;
import kr.co.dw.util.WrapPreparedStatementUtil;

public class LocalSeatDAO {

	protected ArrayList<LocalSeatVO> TM_GET_SEAT_STATUS_TOTAL (String strStoreNo) {
		Logger logger 					= Logger.getLogger(this.getClass());
		LocalDatabaseBean ldb			= new LocalDatabaseBean();
		Connection conn					= ldb.getLocalConnection(strStoreNo);
		WrapPreparedStatementUtil ps	= null;
		ResultSet rs					= null;
		ArrayList<LocalSeatVO> arr		= new ArrayList<LocalSeatVO>();
		
		try {
			ps = new WrapPreparedStatementUtil(conn, " EXEC DBO.TM_GET_SEAT_STATUS_TOTAL ");
			logger.debug(ps.getQueryString());
			rs = ps.executeQuery();
			while(rs.next()) {
				LocalSeatVO vo = new LocalSeatVO();
				vo.SEAT = rs.getString("SEAT");
				vo.USING = rs.getString("USING");
				// if (vo.SEAT.equals("10") || vo.SEAT.equals("11")) vo.USING = "Y"; // test
				arr.add(vo);
			}
		} catch (Exception e) {
			logger.error(e.toString());
		} finally {
			try {
				rs.close();
			} catch (Exception e) {
				logger.error(e.toString());
			}
			try {
				ps.close();
			} catch (Exception e) {
				logger.error(e.toString());
			}
			ldb.closeLocalConnection(conn);
		}
		return arr;
	}
}
