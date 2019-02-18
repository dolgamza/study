package kr.co.beable.customer;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import kr.co.dw.mgr.ConnectionMgr;
import kr.co.dw.util.WrapPreparedStatementUtil;

public class MemberDAO {
	
	/**
	 * USER MEMBER JOIN
	 * @param reqMemVO
	 * @return
	 */
	protected int CM_MEMBER_JOIN_PROC(MemberVO.reqMemberJoinVO reqMemVO) {
		
		Connection conn					= ConnectionMgr.getInstance().getConnetion();
		WrapPreparedStatementUtil ps	= null;
		ResultSet                 rs   	= null;
		Logger logger					= Logger.getLogger(this.getClass());
		int isSuccess 					= 0;
		
		try {
			
			ps = new WrapPreparedStatementUtil(conn, " EXEC DBO.CM_MEMBER_JOIN_PROC ?, ?, ?, ? " );
			int i = 1;
			
			ps.setString(i++, reqMemVO.USR_PHONE_NO);
			ps.setString(i++, reqMemVO.USR_PW);
			ps.setString(i++, reqMemVO.STORE_NO);
			ps.setString(i++, reqMemVO.CARD_NO);
			
			logger.debug(ps.getQueryString());
			System.out.println(ps.getQueryString());
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
	
	/**
	 * MEMBER JOIN DUPLICATION CHECK
	 * @param strFranchise
	 * @param strF_id
	 * @param strF_cardno
	 * @return
	 */
	protected String CM_MEMBER_DUP_CHK_PROC(String strFranchise,String strF_id,String strF_cardno, String strF_ath) {
		
		Connection conn					= ConnectionMgr.getInstance().getConnetion();
		WrapPreparedStatementUtil ps	= null;
		ResultSet rs					= null;
		Logger logger					= Logger.getLogger(this.getClass());
		String result					= "";
		
		try {
			
			ps = new WrapPreparedStatementUtil(conn, " EXEC DBO.CM_MEMBER_DUP_CHK_PROC ?, ?, ?, ? ");
			ps.setString(1, strFranchise);
			ps.setString(2, strF_id);
			ps.setString(3, strF_cardno);
			ps.setString(4, strF_ath);
			
			System.out.println(ps.getQueryString());
			logger.debug(ps.getQueryString());
			rs = ps.executeQuery();
			
			rs.next();
			
			result = rs.getString("MSG");
			
		} catch (Exception e) {
			logger.error(ps.getQueryString());
			System.out.println(e.toString());
		} finally {
			ConnectionMgr.getInstance().closeConnection(conn, ps, rs);
		}
		return result;
	}
	
	/**
	 * USER LOGIN
	 * @param req
	 * @return
	 */
	protected ArrayList<MemberVO.resLoginListVO> CM_USER_LOGIN_PROC(MemberVO.reqLoginVO req){
		
		Connection conn									= ConnectionMgr.getInstance().getConnetion();
		WrapPreparedStatementUtil ps					= null;
		ResultSet rs									= null;
		Logger logger									= Logger.getLogger(this.getClass());
		ArrayList<MemberVO.resLoginListVO> arrResult	= new ArrayList<MemberVO.resLoginListVO>();
		
		try {
						
			ps = new WrapPreparedStatementUtil(conn, " EXEC DBO.CM_USER_LOGIN_PROC ?, ?, ? ");
			ps.setString(1, req.USR_PHONE_NO);
			ps.setString(2, req.USR_PW);
			ps.setString(3, req.GUBUN);
			logger.debug(ps.getQueryString());
			//System.out.println(ps.getQueryString());
			rs = ps.executeQuery();
			
			while(rs.next()) {
				MemberVO.resLoginListVO res = new MemberVO().new resLoginListVO();
				res.USR_PHONE_NO	= rs.getString("USR_PHONE_NO");
				res.USR_PW			= rs.getString("USR_PW");
				res.DT				= rs.getString("DT");
				res.STORE_NO		= rs.getString("STORE_NO");
				res.CARD_NO			= rs.getString("CARD_NO");
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
	
	/**
	 * USER LOGIN HISTORY
	 * @param req
	 * @return
	 */
	protected boolean CM_LOGIN_HIS_PROC(MemberVO.reqLoginHistoryVO req) {
		
		Connection conn					= ConnectionMgr.getInstance().getConnetion();
		WrapPreparedStatementUtil ps	= null;
		Logger logger					= Logger.getLogger(this.getClass());
		boolean result					= false;
		
		try {
			
			ps = new WrapPreparedStatementUtil(conn, " EXEC DBO.CM_LOGIN_HIS_PROC ?, ? ");
			ps.setString(1, req.USR_PHONE_NO);
			ps.setString(2, req.IP_ADDR);
			logger.debug(ps.getQueryString());
			result = ps.execute();
			
		} catch (Exception e) {
			logger.error(ps.getQueryString());
			System.out.println(e.toString());
		} finally {
			ConnectionMgr.getInstance().closeConnection(conn, ps);
		}
		return result;
	}
	
	protected int CM_LOGIN_PWD_CHANGE_PROC(String strId, String strPwd) {
		
		Connection conn					= ConnectionMgr.getInstance().getConnetion();
		WrapPreparedStatementUtil ps	= null;
		ResultSet                 rs   	= null;
		Logger logger					= Logger.getLogger(this.getClass());
		int isSuccess 					= 0;
		
		try {
			
			ps = new WrapPreparedStatementUtil(conn, " EXEC DBO.CM_LOGIN_PWD_CHANGE_PROC ?, ? " );
			int i = 1;
			
			ps.setString(i++, strId);
			ps.setString(i++, strPwd);
			
			logger.debug(ps.getQueryString());
			System.out.println(ps.getQueryString());
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
	
	protected int CM_CARDNO_CHANGE_PROC(String strStoreNo, String sessUsrPhoneNo, String strFcardno, String strGubun) {
		
		Connection conn					= ConnectionMgr.getInstance().getConnetion();
		WrapPreparedStatementUtil ps	= null;
		ResultSet                 rs   	= null;
		Logger logger					= Logger.getLogger(this.getClass());
		int isSuccess 					= 0;
		
		try {
			
			ps = new WrapPreparedStatementUtil(conn, " EXEC DBO.CM_CARDNO_CHANGE_PROC ?, ?, ?, ? " );
			int i = 1;
			
			ps.setInt(i++, Integer.parseInt(strStoreNo));
			ps.setString(i++, sessUsrPhoneNo);
			ps.setInt(i++, Integer.parseInt(strFcardno));
			ps.setString(i++, strGubun);
			
			logger.debug(ps.getQueryString());
			System.out.println(ps.getQueryString());
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
