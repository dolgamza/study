package kr.co.beable.chain;

import java.util.ArrayList;

public class ChainBean {
	
	private ChainDAO dao;
	
	public ChainBean() {
		this.dao = new ChainDAO();
	}
	
	/**
	 * Location tap list
	 * @return
	 */
	public ArrayList<ChainVO.reqLocationTapVO> FC_LOCATION_TAP_PROC(String strCoordinate){
		return dao.FC_LOCATION_TAP_PROC(strCoordinate);
	}
	
	/**
	 * Location map list
	 * @return
	 */
	public ArrayList<ChainVO.reqLocationMapVO> FC_LOCATION_MAP_PROC(){
		return dao.FC_LOCATION_MAP_PROC();
	}
}
