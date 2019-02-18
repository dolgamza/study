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
	 * @param strFranchise
	 * @param strF_id
	 * @param strF_cardno
	 * @param strF_ath
	 * @return
	 */
	public String CM_MEMBER_DUP_CHK_PROC(String strFranchise, String strF_id, String strF_cardno, String strF_ath) {
		return dao.CM_MEMBER_DUP_CHK_PROC(strFranchise, strF_id, strF_cardno, strF_ath);
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
	 * @param strId
	 * @param strPwd
	 * @return
	 */
	public int CM_LOGIN_PWD_CHANGE_PROC(String strId, String strPwd) {
		return dao.CM_LOGIN_PWD_CHANGE_PROC(strId, strPwd);
	}
	
	/**
	 * USER CARDNO CHANGE
	 * @param strStoreNo
	 * @param sessUsrPhoneNo
	 * @param setFcardno
	 * @param strGubun
	 * @return
	 */
	public int CM_CARDNO_CHANGE_PROC(String strStoreNo, String sessUsrPhoneNo, String strFcardno, String strGubun) {
		return dao.CM_CARDNO_CHANGE_PROC(strStoreNo, sessUsrPhoneNo, strFcardno, strGubun);
	}
}
