package kr.co.dw.util;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2003.08.20</p>
 * <p>Company: duzon</p>
 * @author bjkim@duzon.co.kr
 * @version 1.0
 */

import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.text.ParseException;
import java.util.Locale;


public class CurrencyUtil
{
	private static DecimalFormat df = null;

	private CurrencyUtil()
	{
		
	}

	/**
	 * 세자리 단위로 콤마(,)를 표시한다.
	 * 금액표시 (###,##0.##)
	 * @param won double
	 * @return java.lang.String
	 */
	public static String getCurrency(double won)
	{
		return getCurrency(won, Locale.KOREA);
	}
	/**
	 * 세자리 단위로 콤마(,)를 표시한다.
	 * @param won long
	 * @return java.lang.String
	 */
	public static String getCurrency(long won)
	{
		return getCurrency(won, Locale.KOREA);
	}
	/**
	 * 세자리 단위로 콤마(,)를 표시한다.
	 * @param won int
	 * @return java.lang.String
	 */
	public static String getCurrency(int won)
	{
		return getCurrency(won, Locale.KOREA);
	}
	/**
	 * 세자리 단위로 콤마(,)를 표시한다.
	 * @param won java.lang.String
	 * @return java.lang.String
	 */
	public static String getCurrency(String won)
	{
		return getCurrency(won, Locale.KOREA);
	}
	/**
	 * 세자리 단위로 콤마(,)를 표시한다.
	 * @param won java.math.BigDecimal
	 * @return java.lang.String
	 */
	public static String getCurrency(java.math.BigDecimal won)
	{
		return getCurrency(won, Locale.KOREA);
	}
	/**
	 * 세자리 단위로 콤마(,)를 표시한다.
	 * @param won double
	 * @param loc java.util.Locale
	 * @return java.lang.String
	 */
	public static String getCurrency(double won, Locale loc)
	{
		getDecimalFormat(loc);
		return df.format(won);
	}
	/**
	 * 세자리 단위로 콤마(,)를 표시한다.
	 * @param won long
	 * @param loc java.util.Locale
	 * @return java.lang.String
	 */
	public static String getCurrency(long won, Locale loc)
	{
		getDecimalFormat(Locale.KOREA);
		return df.format(won);
	}
	/**
	 * 세자리 단위로 콤마(,)를 표시한다.
	 * @param won int
	 * @param loc java.util.Locale
	 * @return java.lang.String
	 */
	public static String getCurrency(int won, Locale loc)
	{
		getDecimalFormat(loc);
		return df.format(won);
	}
	/**
	 * 세자리 단위로 콤마(,)를 표시한다.
	 * @param won java.lang.String
	 * @param loc java.util.Locale
	 * @return java.lang.String
	 */
	public static String getCurrency(String won, Locale loc)
	{
		getDecimalFormat(loc);

		if (won == null)
		{
			return "0";
		}

		double doubleWon = 0;
		try {
			doubleWon = Double.valueOf(won).doubleValue();
		}
		catch(Exception e) {
			doubleWon=0;
		}
	
		return getCurrency(doubleWon);
	}
	/**
	 * 세자리 단위로 콤마(,)를 표시한다.
	 * @param won java.math.BigDecimal
	 * @param loc java.util.Locale
	 * @return java.lang.String
	 */
	public static String getCurrency(java.math.BigDecimal won, Locale loc)
	{
		getDecimalFormat(loc);

		if(won == null){
			return "0";
		}
			return df.format(won.doubleValue());
	}

	/**
	 * 세자리 단위로 콤마(,)를 표시한다.
	 * @param won java.lang.String
	 * @return java.lang.Number
	 */
	public static Number getCurrencyNumber(String won)
	{
		Number num = null;
		if(won == null){
			won = "0";
		}
		try
		{
			num = df.parse(won);
		}
		catch (ParseException pe){}
		
		return num;
	}

	private static void getDecimalFormat(Locale loc)
	{
		if (df == null)
		{
			df = new DecimalFormat("###,##0.##", new DecimalFormatSymbols(loc));
		}
	}
	
	public static String numberToHan(double number)
	{
		return getNumberToHan(String.valueOf(Math.round(number)));
	}
	
	public static String numberToHan(int number)
	{
		return getNumberToHan(Integer.toString(number));
	}
	
	public static String numberToHan(String number)
	{
		return getNumberToHan(number);
	}
	
	private static String getNumberToHan(String number)
	{ 
		StringBuffer sb = new StringBuffer();
		String[] numArr = {"","일","이","삼","사","오","육","칠","팔","구"};

		try
		{
			int len = number.length();

			if(len > 16){
				throw new Exception("자릿수가 초과했습니다");
			}

			int[] snum = new int[16];

			for(int i = (snum.length-(len)); i< snum.length; i++)
			{
				int k = i - (snum.length-len);
				String a = String.valueOf(number.charAt(k));
				snum[i] = Integer.parseInt(a);
			}
			
			for(int j=0; j<4; j++)
			{
				int k = (j*4);
				if(snum[k]+snum[k+1]+snum[k+2]+snum[k+3] >0)
				{
					if(snum[k] >0)
					{
						sb.append(numArr[snum[k]]).append("천");
					}
					if(snum[k+1] >0)
					{
						sb.append(numArr[snum[k+1]]).append("백");
					}
					if(snum[k+2] >0)
					{
						sb.append(numArr[snum[k+2]]).append("십");
					}
					if(snum[k+3] >0)
					{
						sb.append(numArr[snum[k+3]]);
					}
					
					switch(j)
					{
						case 0 : sb.append("조"); break;
						case 1 : sb.append("억"); break;
						case 2 : sb.append("만"); break;
						case 3 : sb.append("원"); break;
					}
				}
			}
		}
		catch(NumberFormatException ex)
		{
			ex.printStackTrace();
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		
		return sb.toString();
	}
}
