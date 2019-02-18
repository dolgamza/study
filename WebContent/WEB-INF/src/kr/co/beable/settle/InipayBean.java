package kr.co.beable.settle;

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
}
