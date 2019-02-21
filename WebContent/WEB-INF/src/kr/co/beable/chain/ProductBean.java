package kr.co.beable.chain;

import java.util.ArrayList;

public class ProductBean {

	public ArrayList<ProductVO> PM_PRODUCT_LIST_PROC(String strStoreNo, String strRoomCd){
		return new ProductDAO().PM_PRODUCT_LIST_PROC(strStoreNo, strRoomCd);
	}
	
	public ArrayList<ProductVO> PM_PRODUCT_LIST_PROC(String strStoreNo, String strRoomCd, String strProductNo){
		return new ProductDAO().PM_PRODUCT_LIST_PROC(strStoreNo, strRoomCd, strProductNo);
	}
	
	public ArrayList<ProductVO> PM_ROOM_LIST_PROC(int strStoreNo, int strPrdCd){
		return new ProductDAO().PM_ROOM_LIST_PROC(strStoreNo, strPrdCd);
	}
}
