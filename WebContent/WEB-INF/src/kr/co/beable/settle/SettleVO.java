package kr.co.beable.settle;

public class SettleVO {
	public class reqSettleListVO {
		public int PAGE;
		public int BLOCKSIZE;
		public String USR_PHONE_NO;
		public String SEL_FG;
		public String SEL_VAL;
	}
	
	public class resSettleListVO {
		public int TCNT;
		public int RN;
		public int STORE_NO;
		public String STORE_NM;
		public String USR_PHONE_NO;
		public int CARD_NO;
		public String PRD_GRP_CD;
		public String PRD_GRP_NM;
		public int PRD_CD;
		public String PRD_NM;
		public String ROOM_CD;
		public String ROOM_NM;
		public int SEAT_NO;
		public String SEAT_NM;
		public String PAY_AMT;
		public String METHOD_CD;
		public String METHOD_NM;
		public String PAY_DT;
		public String PAY_DATE;
		public String STATUS_CD;
		public String STATUS_NM;
	}
}
