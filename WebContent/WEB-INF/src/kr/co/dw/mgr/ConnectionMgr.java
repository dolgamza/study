package kr.co.dw.mgr;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.apache.log4j.Logger;

import kr.co.dw.GlobalEnv;


/**
 * Database Connection Manager
 * 
 * <pre>
 * 
 * 1. Required
 *    
 *    (1) jre\lib\ext\sqljdbc4.jar
 *    (2) tomcat\conf\server.xml
 *        <GlobalNamingResources>
 *          ...
 *          <Resource name="jdbc/SQLDB"
 *                    auth="Container"
 *                    type="javax.sql.DataSource"
 *                    username="YourUserName"
 *                    password="YourPassword"
 *                    driverClassName="com.microsoft.sqlserver.jdbc.SQLServerDriver"
 *                    url="jdbc:sqlserver://YourServerIP:1433;databaseName=YourDatabaseName"
 *                    validationQuery="SELECT 1"
 *                    maxActive="300" maxIdle="20" maxWait="-1"/>
 *         </GlobalNamingResources>        
 *     (3) tomcat\conf\context.xml
 *         <Context>
 *           ...
 *           <ResourceLink name="jdbc/SQLDB" global="jdbc/SQLDB" type="javax.sql.DataSource"/>
 *         </Context>
 *     (4) YourWebContent\WEB-INF\web.xml
 *         <resource-ref>
 *           <description>DataSource</description>
 *           <res-ref-name>jdbc/SQLDB</res-ref-name>
 *           <res-type>javax.sql.DataSource</res-type>
 *           <res-auth>Container</res-auth>
 *         </resource-ref>
 *
 * 2. Simple Usage
 * 
 *    ConnectionMgr mgr   = ConnectionMgr.getInstance();
 *    Connection    conn  = mgr.getConnetion();
 *    Statement     stmt  = null;
 *    ResultSet     rs    = null;
 *	
 *    stmt = conn.createStatement();
 *	  rs = stmt.executeQuery("SELECT TOP 10 NAME FROM DBO.EMPLOYEE WITH (NOLOCK)");
 *	  while(rs.next()) {
 *		System.out.println(rs.getString("NAME") + "<br>");
 *	  }
 *	  mgr.closeConnection(conn, stmt, rs);
 * 
 * </pre>
 * 
 * @author DOLGAMZA
 * @version 1.0
 * @since 2012.08
 */
public class ConnectionMgr {
	
	private static ConnectionMgr instance = null; // this class instance
	private static DataSource          ds = null; // DataSource
	
	/**
	 * Constructor
	 * 
	 */
	private ConnectionMgr() {
		try {
			Context    ctx    = new InitialContext();
			Context    envctx = (Context) ctx.lookup("java:comp/env");
			ds = (DataSource) envctx.lookup(GlobalEnv.GLOBAL_CONNECTION_NAME);
		} catch (NamingException e) {
			System.out.println(e.toString());
			setErrorLog("ConnectionMgr", e.toString());
		} 
	}
	
	/**
	 * Get ConnectionMgr Class Instance.
	 * 
	 * @return ConnectionMgr Instance
	 */
	public synchronized static ConnectionMgr getInstance() {
		if (instance == null || ds == null) {
			instance = new ConnectionMgr();
		}
		return instance;
	}
	
	/**
	 * Get Connection
	 * 
	 * @return java.sql.Connection
	 */
	public Connection getConnetion() {
		Connection conn = null;
		try {
			conn = ds.getConnection();
		} catch (SQLException e) {
			setErrorLog("getConnection", e.toString());
		} 
		return conn;
	}

	/**
	 * Save Error Log
	 * 
	 * @param strMethodName MethodName is Occurred Errors
	 * @param str           Error Message
	 */
	private void setErrorLog(String strMethodName, String str) {
		Logger logger = Logger.getLogger(this.getClass());
		logger.error("Error in kr.co.dw.mgr.ConnectionMgr." + strMethodName + "()");
		logger.error(str);
	}
	
	/**
	 * Close Connection
	 * 
	 * @param conn java.sql.Connection
	 * @throws SQLException
	 */
	private void closeConnection(Connection conn) {
		try {
			if (conn!=null) conn.close();
		} catch (SQLException e) {
			setErrorLog("closeConnection", e.toString());
		}
	}
	
	/**
	 * Close Connection
	 * 
	 * @param conn java.sql.Connection
	 * @param ps   java.sql.PreparedStatement
	 * @throws SQLException
	 */
	public void closeConnection(Connection conn, PreparedStatement ps) {
		try {
			if (ps!=null) ps.close();
			closeConnection(conn);
		} catch (SQLException e) {
			setErrorLog("closeConnection", e.toString());
		}
	}

	/**
	 * Close Connection
	 * 
	 * @param conn java.sql.Connection
	 * @param ps   java.sql.PreparedStatement
	 * @param rs   java.sql.ResultSet
	 * @throws SQLException
	 */
	public void closeConnection(Connection conn, PreparedStatement ps, ResultSet rs) {
		try {
			if (rs!=null) rs.close();
			if (ps!=null) ps.close();
			closeConnection(conn);
		} catch (SQLException e) {
			setErrorLog("closeConnection", e.toString());
		}
	}
	
	/**
	 * Close Connection
	 * 
	 * @param conn java.sql.Connection
	 * @param stmt java.sql.Statement
	 * @throws SQLException
	 */
	public void closeConnection(Connection conn, Statement stmt) {
		try {
			if (stmt!=null) stmt.close();
			closeConnection(conn);
		} catch (SQLException e) {
			setErrorLog("closeConnection", e.toString());
		}
	}


	/**
	 * Close Connection
	 *  
	 * @param conn java.sql.Connection
	 * @param stmt java.sql.Statement
	 * @param rs   java.sql.ResultSet
	 * @throws SQLException
	 */
	public void closeConnection(Connection conn, Statement stmt, ResultSet rs) {
		try {
			if (rs!=null) rs.close();
			if (stmt!=null) stmt.close();
			closeConnection(conn);
		} catch (SQLException e) {
			setErrorLog("closeConnection", e.toString());
		}
	}

	/**
	 * Close Connection
	 *  
	 * @param conn java.sql.Connection
	 * @param cs   java.sql.CallableStatement
	 * @throws SQLException
	 */
	public void closeConnection(Connection conn, CallableStatement cs) {
		try {
			if (cs!=null) cs.close();
			closeConnection(conn);
		} catch (SQLException e) {
			setErrorLog("closeConnection", e.toString());
		}
	}

	/**
	 * Close Connection
	 *  
	 * @param conn java.sql.Connection
	 * @param cs   java.sql.CallableStatement
	 * @param rs   java.sql.ResultSet
	 * @throws SQLException
	 */
	public void closeConnection(Connection conn, CallableStatement cs, ResultSet rs) {
		try {
			if (rs!=null) rs.close();
			if (cs!=null) cs.close();
			closeConnection(conn);
		} catch (SQLException e) {
			setErrorLog("closeConnection", e.toString());
		}
	}

}
