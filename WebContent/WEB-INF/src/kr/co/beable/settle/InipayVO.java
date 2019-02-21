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
	
	public class reqSmProductSeatVO {
		public int STORE_NO;
		public int SEAT_NO;
		public String ROOM_CD;
		public int PRD_CD;
	}
	
	public class resSmProductSeatVO {
		public String PRD_GRP_CD;
		public String PRD_GRP_NM;
		public int PRD_CD;
		public String PRD_NM;
		public int STORE_NO;
		public String PRD_MATCHING_CD;
		public String METHOD_NM;
		public String ROOM_CD;
		public int PRD_TIME;
		public int MEM_CNT;
		public int SEAT_NO;
		public String SEAT_CD;
	}
	
	public class reqIudRefillVO {
		public String STORE_NO;
		public String RFID;
		public String RECEIPT;
		public String CASH;
		public String CASHGUBUN;
		public String METHOD;
		public int TMR;
		public String HP;
	}
	
	public class reqIudRecordVO {
		public String STORE_NO;
		public String RECEIPT;
		public String SEAT;
		public String RFID;
		public String FEE;
		public String CASHERTYPE;
		public int TMR;
		public String HP;
		public String ROOMTMR;
		public int MEMCNT;
	}
	
	public class reqIudDelayVO {
		public String STORE_NO;
		public String RFID;
		public int SEAT;
		public int TMR;
		public int CASH;
		public int CARD;
		public int POINT;
		public int RFIDFEE;
	}
}
