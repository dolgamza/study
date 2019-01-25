package kr.co.beable.space;

import java.util.ArrayList;

public class SpaceBean {
	
	private SpaceDAO dao;
	
	public SpaceBean() {
		this.dao = new SpaceDAO();
	}
	
	/**
	 * Space Image List...
	 * @return
	 */
	public ArrayList<SpaceVO> SP_IMAGE_LIST_PROC(String tapCode){
		return dao.SP_IMAGE_LIST_PROC(tapCode);
	}
}
