package kr.co.beable.chain;

import java.util.ArrayList;

public class ProductBean {

	public ArrayList<ProductVO> PM_PRODUCT_LIST_PROC(String strStoreNo, String strRoomCd){
		return new ProductDAO().PM_PRODUCT_LIST_PROC(strStoreNo, strRoomCd);
	}
}
