package kr.co.beable.customer;

public class MemberVO {
	
	public class reqMemberJoinVO {
		public String USR_PHONE_NO;
		public String USR_PW;
		public String STORE_NO;
		public String CARD_NO;
	}
	
	public class reqLoginVO {
		public String USR_PHONE_NO;
		public String USR_PW;
		public String GUBUN;
	}
	
	public class resLoginListVO {
		public String USR_PHONE_NO;
		public String USR_PW;
		public String DT;
		public String CARD_NO;
		public String STORE_NO;
	} 
	
	public class reqLoginHistoryVO {
		public String USR_PHONE_NO;
		public String USR_PW;
		public String IP_ADDR;
	}
	
}
