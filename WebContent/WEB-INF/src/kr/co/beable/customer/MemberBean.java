package kr.co.beable.customer;

import java.util.ArrayList;

public class MemberBean {
	private MemberDAO dao;
	
	public MemberBean() {
		this.dao = new MemberDAO();
	}
	
	/**
	 * USER MEMBER JOIN
	 * @param reqMemVO
	 * @return
	 */
	public int CM_MEMBER_JOIN_PROC(MemberVO.reqMemberJoinVO reqMemVO) {
		return dao.CM_MEMBER_JOIN_PROC(reqMemVO);
	}
	
	/**
	 * MEMBER JOIN DUPLICATION CHECK
	 * @return
	 */
	public boolean CM_MEMBER_DUP_CHK_PROC(String strFranchise,String strF_id,String strF_cardno) {
		return dao.CM_MEMBER_DUP_CHK_PROC(strFranchise, strF_id, strF_cardno);
	}
	
	/**
	 * USER LOGIN
	 * @param req
	 * @return
	 */
	public ArrayList<MemberVO.resLoginListVO> CM_USER_LOGIN_PROC(MemberVO.reqLoginVO req) {
		return dao.CM_USER_LOGIN_PROC(req);
	}
	
	/**
	 * USER LOGIN HISTORY
	 * @param req
	 * @return
	 */
	public boolean CM_LOGIN_HIS_PROC(MemberVO.reqLoginHistoryVO req) {
		return dao.CM_LOGIN_HIS_PROC(req);
	}
	
	/**
	 * USER LOGIN PWD CHANGE
	 * @return
	 */
	public int CM_LOGIN_PWD_CHANGE_PROC(String strId, String strPwd) {
		return dao.CM_LOGIN_PWD_CHANGE_PROC(strId, strPwd);
	}
}
