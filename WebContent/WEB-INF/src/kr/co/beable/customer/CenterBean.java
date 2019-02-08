package kr.co.beable.customer;

import java.util.ArrayList;

public class CenterBean {
	
	private CenterDAO dao;
	
	public CenterBean() {
		this.dao = new CenterDAO();
	}
	
	/**
	 * All Center List
	 * @return
	 */
	public ArrayList<CenterVO.resCenterAllVO> CM_ALL_STORE_LIST_PROC(){
		return dao.CM_ALL_STORE_LIST_PROC();
	}
	
	/**
	 * Center Detail
	 * @return
	 */
	public ArrayList<CenterVO.resCenterDetailVO> CM_STORE_DETAIL_PROC(int paramStoreNo){
		return dao.CM_STORE_DETAIL_PROC(paramStoreNo);
	}
}
