package kr.co.beable.center;

public class CenterVO {
	
	/**
	 * location MapList VO
	 * @author user
	 *
	 */
	public class resLocationMapVO {
		public int TCNT;
		public int RN;
		public String FC_NO;
		public String FC_NM;
		public String FC_MAIN_TEL_NO;
		public String FC_ADDR;
		public String FC_ZIP_CODE;
		public String FC_COORDINATE;
		public String FC_HOMEPAGE;
		public String FC_THUMBNAIL;
	}
	
	public class reqLocationMapVO {
		public int PAGE;
		public int BLOCKSIZE;
		public String SEL_FG;
		public String SEL_VAL;
	}
}
