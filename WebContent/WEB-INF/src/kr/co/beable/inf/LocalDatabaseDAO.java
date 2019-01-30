package kr.co.beable.inf;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

import org.apache.log4j.Logger;
import kr.co.dw.mgr.ConnectionMgr;
import kr.co.dw.util.StrUtil;
import kr.co.dw.util.WrapPreparedStatementUtil;

public class LocalDatabaseDAO {
	
	protected int CM_STORE_SERVER_INS_PROC (LocalDatabaseVO vo) {
		Connection conn					= ConnectionMgr.getInstance().getConnetion();
		WrapPreparedStatementUtil ps	= null;
		Logger logger					= Logger.getLogger(this.getClass());
		int intResult = 0;
		try {
			ps = new WrapPreparedStatementUtil(conn, " EXEC DBO.CM_STORE_SERVER_INS_PROC ?, ? ");
			ps.setString(1, vo.strServer);
			ps.setString(2, vo.strStoreKey);
			logger.debug(ps.getQueryString());
			intResult = ps.executeUpdate();
		} catch (Exception e) {
			logger.error(ps.getQueryString());
			System.out.println(e.toString());
		} finally {
			ConnectionMgr.getInstance().closeConnection(conn, ps);
		}
		return intResult;
	}
	
	protected ArrayList<LocalDatabaseInfoVO> CM_STORE_DB_CONN_INFO_PROC (String strStoreNo) {
		Connection conn					= ConnectionMgr.getInstance().getConnetion();
		WrapPreparedStatementUtil ps	= null;
		ResultSet rs					= null;
		Logger logger					= Logger.getLogger(this.getClass());
		ArrayList<LocalDatabaseInfoVO> arr = new ArrayList<LocalDatabaseInfoVO>();
		try {
			ps = new WrapPreparedStatementUtil(conn, "EXEC DBO.CM_STORE_DB_CONN_INFO_PROC ?");
			ps.setInt(1, Integer.parseInt(strStoreNo));
			logger.debug(ps.getQueryString());
			rs = ps.executeQuery();
			
			while(rs.next()) {
				LocalDatabaseInfoVO vo = new LocalDatabaseInfoVO();
				vo.DB_IP		= StrUtil.nvl(rs.getString("DB_IP"),		"");
				vo.DB_PORT		= StrUtil.nvl(rs.getString("DB_PORT"),		"");
				vo.DB_NM		= StrUtil.nvl(rs.getString("DB_NM"),		"");
				vo.DB_USER_NM	= StrUtil.nvl(rs.getString("DB_USER_NM"),	"");
				vo.DB_PW 		= StrUtil.nvl(rs.getString("DB_PW"),		"");
				arr.add(vo);
			}
		} catch (Exception e) {
			logger.error(ps.getQueryString());
			System.out.println(e.toString());
		} finally {
			ConnectionMgr.getInstance().closeConnection(conn, ps, rs);
		}
		return arr;
	}
	

}
