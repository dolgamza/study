package kr.co.beable.inf;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Random;

import org.apache.log4j.Logger;

import kr.co.beable.customer.CenterVO;
import kr.co.beable.customer.CenterVO.resCenterAllVO;
import kr.co.dw.mgr.ConnectionMgr;
import kr.co.dw.util.StrUtil;
import kr.co.dw.util.WrapPreparedStatementUtil;

public class LocalDatabaseDAO {
	
	/**
	 * DB INFO UPDATE
	 * @param vo
	 * @return
	 */
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
	
	/**
	 * DB INFO
	 * @param strStoreNo
	 * @return
	 */
	protected ArrayList<LocalDatabaseInfoVO> CM_STORE_DB_CONN_INFO_PROC (String strStoreNo) {
		Connection conn					= ConnectionMgr.getInstance().getConnetion();
		WrapPreparedStatementUtil ps	= null;
		ResultSet rs					= null;
		Logger logger					= Logger.getLogger(this.getClass());
		ArrayList<LocalDatabaseInfoVO> arr = new ArrayList<LocalDatabaseInfoVO>();
		try {
			ps = new WrapPreparedStatementUtil(conn, "EXEC DBO.CM_STORE_DB_CONN_INFO_PROC ? ");
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
	
	/**
	 * CERTIFICATION SEND SMS
	 * @param strF_id
	 * @param strStoreNo
	 * @return
	 * @throws SQLException
	 */
	protected int CM_STORE_MAKE_CERTIFICATION_PROC (String strF_id, String strStoreNo) throws SQLException {
		
		System.out.println("class strF_id : " + strF_id);
		System.out.println("class strStoreNo : " + strStoreNo);
		
		String strUrl	= "";
		int insertCnt	= 0;
		int resultCnt	= -1;
		
		Connection localConn 				= null;
		WrapPreparedStatementUtil localPs	= null;
		
		String strRandomNum					= new LocalDatabaseDAO().numberGen(6);
		
		try {
			
			strUrl	= new LocalDatabaseBean().CM_STORE_DB_CONN_INFO_PROC(strStoreNo);
			
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			localConn = DriverManager.getConnection(strUrl);
			localPs = new WrapPreparedStatementUtil(localConn, " exec IUD_SMS ?, ?, ?, ?, ?, ? ");
			int i = 1;
			
			localPs.setString(i++, strF_id);
			localPs.setString(i++, "[비에이블] 인증번호[" + strRandomNum + "]를 입력해 주세요.");
			localPs.setString(i++, "00000000000000");	//예약문자 전송시 'YYYYmmddHHMMss', 즉시전송시 '00000000000000'
			localPs.setString(i++, "0");				//Default = 0, ( 0 : 즉시전송(숫자 0) R : 예약전송 )
			localPs.setString(i++, "S");				//'S' -- M : MMS, S : SMS, I : 국제문자, L : 국제 MMS
			localPs.setString(i++, "");   //기본값 [알림톡 발송시 예약된 메크로 코드( 일반 문자 발송시 빈문자 넣으시면 됨)] //SM_006_SEAT_IN
			System.out.println(localPs.getQueryString());
			
			insertCnt += localPs.executeUpdate();
			
			System.out.println("insertCnt : " + insertCnt);
			
			if(insertCnt > 0) {
				resultCnt = new LocalDatabaseDAO().CM_STORE_CHECK_CERTIFICATION_PROC(strF_id, strRandomNum);
			}
			
		} catch(Exception e) {
			System.out.println(e.toString());
		} finally {
			localPs.close();
			localConn.close();
		}
		
		return resultCnt;
		
	}
	
	/**
	 * CERTIFICATION CHK
	 * @param strF_id
	 * @param strRandomNum
	 * @return
	 */
	protected int CM_STORE_CHECK_CERTIFICATION_PROC (String strF_id, String strRandomNum) {
		Connection conn					= ConnectionMgr.getInstance().getConnetion();
		WrapPreparedStatementUtil ps	= null;
		ResultSet rs					= null;
		Logger logger					= Logger.getLogger(this.getClass());
		int isSuccess 					= 0;
		
		try {
			ps = new WrapPreparedStatementUtil(conn, "EXEC DBO.CM_STORE_CHECK_CERTIFICATION_PROC ?, ? ");
			ps.setString(1, strF_id);
			ps.setString(2, strRandomNum);
			rs = ps.executeQuery();
			rs.next();
			isSuccess = rs.getInt("RESULT");
			
			System.out.println("isSuccess : " + isSuccess);
			
		} catch (Exception e) {
			logger.error(ps.getQueryString());
			System.out.println(e.toString());
		} finally {
			ConnectionMgr.getInstance().closeConnection(conn, ps, rs);
		}
		return isSuccess;
	}
	
	/**
	 * CREATE RANDOM NUMBER
	 * @param len
	 * @return
	 */
	private String numberGen(int len) {
        
        Random rand 	= new Random();
        String numStr 	= ""; //난수가 저장될 변수
        
        for(int i=0;i<len;i++) {
            
            //0~9 까지 난수 생성
            String ran = Integer.toString(rand.nextInt(10));
            
            if(!numStr.contains(ran)) {
                //중복된 값이 없으면 numStr에 append
                numStr += ran;
            }else {
                //생성된 난수가 중복되면 루틴을 다시 실행한다
                i-=1;
            }
        }
        
        return numStr;
    }
	
	/**
	 * CARD TO RFID
	 * @param strStoreNo
	 * @param strCardNo
	 * @return
	 * @throws SQLException
	 */
	protected String CM_USER_CARD_TO_RFID_PROC (String strStoreNo, String strCardNo) throws SQLException {
		
		String rtnResult 	= "";
		int cnt				= 0; 
		String strUrl		= "";
		
		Connection localConn 				= null;
		WrapPreparedStatementUtil localPs	= null;
		ResultSet localRs					= null;
		
		try {
			
			strUrl	= new LocalDatabaseBean().CM_STORE_DB_CONN_INFO_PROC(strStoreNo);
			
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			localConn 	= DriverManager.getConnection(strUrl);
			localPs 	= new WrapPreparedStatementUtil(localConn, " SELECT RFID, COUNT(*) AS CNT FROM RFID WITH (NOLOCK) WHERE RFIDNUMBER = ? GROUP BY RFID; ");
			
			int i = 1;
			localPs.setString(i++, strCardNo);
			localRs 	= localPs.executeQuery();
			System.out.println(localPs.getQueryString());
			
			if(localRs.next()) {
				rtnResult = localRs.getString("RFID");
				cnt		  = localRs.getInt("CNT");
			}
			
		} catch(Exception e) {
			System.out.println(e.toString());
		} finally {
			localRs.close();
			localPs.close();
			localConn.close();
		}
		
		return rtnResult;
		
	}
	
	/**
	 * CARD USE CHECK
	 * @param strStoreNo
	 * @param strCardNo
	 * @return
	 * @throws SQLException
	 */
	protected ArrayList<LocalDatabaseInfoVO> CM_USER_CARD_CHK_PROC (String strStoreNo, String strCardNo) throws SQLException {
		
		boolean result 	= false;
		String strUrl	= "";
		
		Connection localConn 				= null;
		WrapPreparedStatementUtil localPs	= null;
		ResultSet localRs					= null;
		ArrayList<LocalDatabaseInfoVO> arrResult	= new ArrayList<LocalDatabaseInfoVO>();
		
		try {
			
			String rfid = CM_USER_CARD_TO_RFID_PROC(strStoreNo, strCardNo);
			
			strUrl	= new LocalDatabaseBean().CM_STORE_DB_CONN_INFO_PROC(strStoreNo);
			
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			localConn 	= DriverManager.getConnection(strUrl);
			localPs 	= new WrapPreparedStatementUtil(localConn, " EXEC DBO.RFID_CARD_CHECK ? ");
			
			localPs.setString(1, rfid);
			localRs = localPs.executeQuery();
			result = localRs.next();
			
			System.out.println("result : " + result);
			
			if(result) {
				
				LocalDatabaseInfoVO res = new LocalDatabaseInfoVO();
				
				res.RESULT		= localRs.getString("RESULT");
				res.MSG			= localRs.getString("MSG");
				res.RFID		= localRs.getString("RFID");
				res.CASH		= localRs.getString("CASH");
				res.SD			= localRs.getString("SD");
				res.ED			= localRs.getString("ED");
				res.SIZE		= localRs.getString("SIZE");
				res.HP			= localRs.getString("HP");
				res.POINT		= localRs.getString("POINT");
				res.RFIDINFO	= localRs.getString("RFIDINFO");
				
				arrResult.add(res);
			}
			
		} catch(Exception e) {
			System.out.println(e.toString());
		} finally {
			localRs.close();
			localPs.close();
			localConn.close();
		}
		
		return arrResult;
	}
	
	public static void main(String args[]) {
		System.out.println(new LocalDatabaseDAO().numberGen(6));
	}

}
