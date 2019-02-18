package kr.co.dw.des;

import java.security.Key;
import java.util.ResourceBundle;

import javax.crypto.Cipher;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import javax.crypto.spec.DESedeKeySpec;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class DESCrypto {
	
	private static String key = getkeyProp() ;
	
	private static String getkeyProp() {
		String propertyfile = "kr.co.dw.des.desKey";
		String keys = "";
		try {
			
			ResourceBundle resrcBundle = ResourceBundle.getBundle(propertyfile);
			keys = resrcBundle.getString("key");
			
		} catch(java.util.MissingResourceException me) {
			System.out.println("Resource Not Found.");
			keys="err";
		}
		
		return keys;
	}
	
	/**
	 * �궎 �젙蹂�
	 * @return
	 */
	public static String key()
	{
		return key;
	}

	public static void setKey(String keyValue)
	{
		key = keyValue;
	}

	/**
	 * �궎媛�
	 * 24諛붿씠�듃�씤 寃쎌슦 TripleDES �븘�땲硫� DES
	 * @return
	 * @throws Exception
	 */
	public static Key getKey() throws Exception {
		return (key().length() == 24) ? getKey2(key()) : getKey1(key());
	}

	/**
	 * �궎媛�
	 * 24諛붿씠�듃�씤 寃쎌슦 TripleDES �븘�땲硫� DES
	 * @return
	 * @throws Exception
	 */
	public static Key getKey(String keyValue) throws Exception {
		setKey(keyValue);
		return (key().length() == 24) ? getKey2(key()) : getKey1(key());
	}

	/**
	 * 吏��젙�맂 鍮꾨��궎瑜� 媛�吏�怨� �삤�뒗 硫붿꽌�뱶 (DES)
	 * require Key Size : 16 bytes
	 *
	 * @return Key 鍮꾨��궎 �겢�옒�뒪
	 * @exception Exception
	 */
	public static Key getKey1(String keyValue) throws Exception {
		DESKeySpec desKeySpec = new DESKeySpec(keyValue.getBytes());
		SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
		Key key = keyFactory.generateSecret(desKeySpec);
		return key;
	}

	/**
	 * 吏��젙�맂 鍮꾨��궎瑜� 媛�吏�怨� �삤�뒗 硫붿꽌�뱶 (TripleDES)
	 * require Key Size : 24 bytes
	 * @return
	 * @throws Exception
	 */
	public static Key getKey2(String keyValue) throws Exception {
		DESedeKeySpec desKeySpec = new DESedeKeySpec(keyValue.getBytes());
		SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DESede");
		Key key = keyFactory.generateSecret(desKeySpec);
		return key;
	}

	/**
	 * 臾몄옄�뿴 ��移� �븫�샇�솕
	 *
	 * @param ID
	 *			鍮꾨��궎 �븫�샇�솕瑜� �씗留앺븯�뒗 臾몄옄�뿴
	 * @return String �븫�샇�솕�맂 ID
	 * @exception Exception
	 */
	public static String encrypt(String ID) throws Exception {
		return encrypt(ID, getKey());
	}

	/**
	 * 臾몄옄�뿴 ��移� �븫�샇�솕
	 *
	 * @param ID
	 *			鍮꾨��궎 �븫�샇�솕瑜� �씗留앺븯�뒗 臾몄옄�뿴
	 * @return String �븫�샇�솕�맂 ID
	 * @exception Exception
	 */
	public static String encrypt(String ID, Key key) throws Exception {
		if (ID == null || ID.length() == 0)
			return "";

		String instance = (key().length() == 24) ? "DESede/ECB/PKCS5Padding" : "DES/ECB/PKCS5Padding";
		Cipher cipher = Cipher.getInstance(instance);
		//cipher.init(Cipher.ENCRYPT_MODE, key);
		cipher.init(1, key);
		String amalgam = ID;

		byte[] inputBytes1 = amalgam.getBytes("UTF8");
		byte[] outputBytes1 = cipher.doFinal(inputBytes1);
		
		BASE64Encoder encoder = new BASE64Encoder();
		String outputStr1 = encoder.encode(outputBytes1);
		return outputStr1;
	}

	/**
	 * 臾몄옄�뿴 ��移� 蹂듯샇�솕
	 *
	 * @param codedID
	 *			鍮꾨��궎 蹂듯샇�솕瑜� �씗留앺븯�뒗 臾몄옄�뿴
	 * @return String 蹂듯샇�솕�맂 ID
	 * @exception Exception
	 */
	public static String decrypt(String codedID) throws Exception {
		return decrypt(codedID, getKey());
	}

	/**
	 * 臾몄옄�뿴 ��移� 蹂듯샇�솕
	 *
	 * @param codedID
	 *			鍮꾨��궎 蹂듯샇�솕瑜� �씗留앺븯�뒗 臾몄옄�뿴
	 * @return String 蹂듯샇�솕�맂 ID
	 * @exception Exception
	 * 
	 */
	public static String decrypt(String codedID, Key key) throws Exception {
		if (codedID == null || codedID.length() == 0)
			return "";

		String instance = (key().length() == 24) ? "DESede/ECB/PKCS5Padding" : "DES/ECB/PKCS5Padding";
		Cipher cipher = Cipher.getInstance(instance);
		//cipher.init(Cipher.DECRYPT_MODE, key);
		cipher.init(2, key);
		BASE64Decoder decoder = new BASE64Decoder();

		byte[] inputBytes1 = decoder.decodeBuffer(codedID);
		byte[] outputBytes2 = cipher.doFinal(inputBytes1);

		String strResult = new String(outputBytes2, "UTF8");
		return strResult;
	}
	
	public static void main(String[] args) throws Exception{
		System.out.println(DESCrypto.encrypt("min2019!"));
		//System.out.println(DESCrypto.decrypt("Rwfflfu/9E="));
		String str = "aaaa\\nbbbb";
		//str += "'";
		//str += "bbbb";
		str = str.replaceAll("'", "n");	
		System.out.println(str);
	}
}
