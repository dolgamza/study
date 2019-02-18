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
	public ArrayList<ChainVO.resLocationTapVO> FC_LOCATION_TAP_PROC(){
		return dao.FC_LOCATION_TAP_PROC();
	}
	
	/**
	 * Location map list
	 * @return
	 */
	public ArrayList<ChainVO.resLocationMapVO> FC_LOCATION_MAP_PROC(String strLocCode, String strFcNm, String strGubun){
		return dao.FC_LOCATION_MAP_PROC(strLocCode, strFcNm, strGubun);
	}
	
	/**
	 * Location Center list
	 * @return
	 */
	public ArrayList<ChainVO.resCenterListVO> FC_LOCATION_LIST_PROC(ChainVO.reqCenterListVO req){
		return dao.FC_LOCATION_LIST_PROC(req);
	}
	
	/**
	 * CONTENT-US QUESTION
	 * @param reqShopVO
	 * @return
	 */
	public int CONTENT_US_PROC(ChainVO.reqContactUsVO reqContactUsVO) {
		return dao.CONTENT_US_PROC(reqContactUsVO);
	}
	
	public ArrayList<ChainVO.resCenterListVO> FC_STORE_SELECT_LIST_PROC(ChainVO.reqCenterListVO req){
		return dao.FC_STORE_SELECT_LIST_PROC(req);
	}
}
