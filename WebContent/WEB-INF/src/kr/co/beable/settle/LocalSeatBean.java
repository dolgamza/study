package kr.co.beable.settle;

import java.util.ArrayList;

public class LocalSeatBean {
	
	public ArrayList<LocalSeatVO> getSeats(String strStoreNo) {
		return new LocalSeatDAO().TM_GET_SEAT_STATUS_TOTAL(strStoreNo);
	}
	
	public ArrayList<LocalSeatVO> getReservationStudyRoom(String strStoreNo, String strSeatNo) {
		return new LocalSeatDAO().TM_GET_RESERVATION_STUDYROOM(strStoreNo, strSeatNo);
	}
	
	public int getUsingStudyRoom(String strStoreNo, String strSeatNo, String strSDate, int intUseMinute) {
		return new LocalSeatDAO().TM_GET_USING_CHK(strStoreNo, strSeatNo, strSDate, intUseMinute);
	}
}
