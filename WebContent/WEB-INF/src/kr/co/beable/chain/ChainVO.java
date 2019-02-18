package kr.co.beable.chain;

public class ChainVO {
	
	/**
	 * location TapList VO
	 * @author user
	 *
	 */
	public class resLocationTapVO {
		public String TOT_CNT;
		public String SIDO_CD;
		public String SIDO_NM;
		public String LOC_COORDINATE;
		public String LOC_LATITUDE;
		public String LOC_LONGITUDE;
		public String CNT;
	}
	
	/**
	 * location MapList VO
	 * @author user
	 *
	 */
	public class resLocationMapVO {
		public String TCNT;
		public String RN;
		public String STORE_NO;
		public String STORE_NM;
		public String PHONE_NO;
		public String ADDR;
		public String ZIP_CODE;
		public String COORDINATE;
		public String WEB_URL;
		public String IMG_URL;
		public String SIDO_CD;
	}
	
	/**
	 * Center List param VO
	 * @author DataWarehouse
	 *
	 */
	public class reqCenterListVO {
		public int PAGE;
		public int BLOCKSIZE;
		public String SEL_FG;
		public String SEL_VAL;
		public String USR_PHONE_NO;
	}
	
	/**
	 * Center List VO
	 * @author DataWarehouse
	 *
	 */
	public class resCenterListVO {
		public int TCNT;
		public int RN;
		public String STORE_NO;
		public String STORE_NM;
		public String PHONE_NO;
		public String ADDR;
		public String ZIP_CODE;
		public String COORDINATE;
		public String WEB_URL;
		public String IMG_URL;
		public String USR_PHONE_NO;
		public String CARD_NO;
		public String USR_MSG;
		public String USR_CODE;
	}
	
	public class reqContactUsVO {
		public String F_NAME;
		public String F_MAIL;
		public String F_MAIL_DOMAIN;
		public String F_PHONE;
		public String F_BIGO;
	}
	
	public class resContactUsVO {
		public String SEQ_NO;
		public String SEND_NM;
		public String SEND_EMAIL;
		public String SEND_TEL;
		public String SEND_MEMO;
		public String SEND_WRITE_DT;
		public String WRITE_YN;
	}
}
