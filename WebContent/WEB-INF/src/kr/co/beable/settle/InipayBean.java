package kr.co.beable.settle;

import java.util.ArrayList;

public class InipayBean {
	private InipayDAO dao;
	
	public InipayBean() {
		this.dao = new InipayDAO();
	}
	
	public int PG_SETTLE_INFO_INS_PROC (InipayVO.reqPgSettleVO req) {
		return dao.PG_SETTLE_INFO_INS_PROC(req);
	}
	
	public int SM_SETTLE_INS_PROC (InipayVO.reqSmSettleVO req) {
		return dao.SM_SETTLE_INS_PROC(req);
	}
	
	public ArrayList<InipayVO.resSmProductSeatVO> SM_PRODUCT_SEAT_INFO_PROC (InipayVO.reqSmProductSeatVO req) {
		return dao.SM_PRODUCT_SEAT_INFO_PROC(req);
	}
	
	public boolean IUD_REFILL_INS_PROC (InipayVO.reqIudRefillVO req) {
		return dao.IUD_REFILL_INS_PROC(req);
	}
	
	public int RFIDREFILL_SEL_PROC (InipayVO.reqIudRefillVO req) {
		return dao.RFIDREFILL_SEL_PROC(req);
	}
	
	public boolean IUD_RECORD_INS_PROC (InipayVO.reqIudRecordVO req) {
		return dao.IUD_RECORD_INS_PROC(req);
	}
	
	public int RECORD_SEL_PROC (InipayVO.reqIudRecordVO req) {
		return dao.RECORD_SEL_PROC(req);
	}
	
	public boolean IUD_DELAY_UPD_PROC (InipayVO.reqIudDelayVO req) {
		return dao.IUD_DELAY_UPD_PROC(req);
	}
}
