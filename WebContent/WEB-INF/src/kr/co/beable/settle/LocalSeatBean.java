package kr.co.beable.settle;

import java.util.ArrayList;

public class LocalSeatBean {
	
	public ArrayList<LocalSeatVO> getSeats(String strStoreNo) {
		return new LocalSeatDAO().TM_GET_SEAT_STATUS_TOTAL(strStoreNo);
	}
}
