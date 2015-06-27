package main.java.com.inmobi.monetization.api.utils;

import android.text.TextUtils;


/**
 * This class contains internal Utility methods.
 * 
 * @author rishabhchowdhary
 * 
 */
public class InternalUtil {

	/**
	 * Used for logging purpose.
	 */
	public static final String LIB_VERSION = "1.0";
	/**
	 * InMobi specific Logging tag.
	 */
	public static final String LOGGING_TAG = "InMobi_Lib_" + LIB_VERSION;

	private static LogLevel logLevel = LogLevel.DEBUG;
	/**
	 * Uses StringUtils.isBlank() API to check for blank strings.
	 * 
	 * @param cs
	 *            The String, for which the check has to be made.
	 * @return false, if the String passed is null or empty. True, otherwise.
	 */
	public static boolean isBlank(String cs) {
		return TextUtils.isEmpty(cs);
	}
	public static LogLevel getLogLevel() {
		return logLevel;
	}
	public static void setLogLevel(LogLevel logLevel) {
		InternalUtil.logLevel = logLevel;
	}
	
	public static void Log(String msg,LogLevel level) {
		if(level.value >= logLevel.value) {
			System.out.println(msg);
		}
	}
	
}
