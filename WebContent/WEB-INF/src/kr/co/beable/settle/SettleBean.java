package kr.co.beable.settle;

import java.util.ArrayList;

public class SettleBean {
	private SettleDAO dao;
	
	public SettleBean() {
		this.dao = new SettleDAO();
	}
	
	public ArrayList<SettleVO.resSettleListVO> SM_SETTLE_LIST_PROC (SettleVO.reqSettleListVO req) {
		return dao.SM_SETTLE_LIST_PROC(req);
	}
}
