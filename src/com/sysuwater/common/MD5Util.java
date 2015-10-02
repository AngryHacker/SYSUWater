package com.sysuwater.common;

import java.security.MessageDigest;

public class MD5Util
{
	public final static String String2MD5( String str )
	{
		try
		{
			byte[] buf = str.getBytes();
			MessageDigest md5 = MessageDigest.getInstance( "MD5" );
			md5.update(buf);
			byte [] tmp = md5.digest();
			StringBuilder sb = new StringBuilder();
			for (byte b:tmp)
			{
				sb.append(Integer.toHexString(b&0xff));
			}
			return sb.toString();
		}
		catch( Exception e )
		{
			e.printStackTrace();
			return null;
		}
	}
}
