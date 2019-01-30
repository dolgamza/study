package kr.co.beable.center;

import java.util.ArrayList;

public class CenterBean {
	
	private CenterDAO dao;
	
	public CenterBean() {
		this.dao = new CenterDAO();
	}
	
	/**
	 * Location map list
	 * @return
	 */
	public ArrayList<CenterVO.resLocationMapVO> FC_LOCATION_LIST_PROC(CenterVO.reqLocationMapVO req){
		return dao.FC_LOCATION_LIST_PROC(req);
	}
}
