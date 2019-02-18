package kr.co.beable.settle;

public class InipayVO {
	public class reqPgSettleVO {
		public int STORE_NO;
		public String USR_PHONE_NO;
		public int CARD_NO;
		public String DATA_XML;
	}
	
	public class reqSmSettleVO {
		public int STORE_NO;
		public int SEAT_NO;
		public String ROOM_CD;
		public int PRD_CD;
		public String USR_PHONE_NO;
		public int CARD_NO;
		public String PRICE;
		public String PG_NO;
		public String PAY_AMT;
		public String METHOD_CD;
		public String STATUS_CD;
		public String PAY_DT;
	}
}
