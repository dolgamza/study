package kr.co.beable.chain;

import java.util.ArrayList;

public class SeatBean {
	
	
	public ArrayList<SeatVO> CM_SEATS_PROC(String strStoreNo){
		ArrayList<SeatVO> arr = new SeatDAO().CM_SEATS_PROC(strStoreNo);
		return arr;
	}

}
