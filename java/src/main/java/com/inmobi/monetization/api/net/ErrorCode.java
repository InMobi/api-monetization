package main.java.com.inmobi.monetization.api.net;

/**
 * This class describes the ErrorCode, so obtained when requesting an ad-format
 * to InMobi.
 * 
 * @author rishabhchowdhary
 * 
 */
public class ErrorCode {

	/**
	 * The error is unknown. Please look at responseMsg for any further details.
	 */
	public static final int UNKNOWN = 0;
	/**
	 * An I/O exception occured. Please check if the response is coming from a
	 * valid InMobi production endpoint.
	 */
	public static final int IO_EXCEPTION = 1;
	/**
	 * Please check if the endpoint is correct.
	 */
	public static final int MALFORMED_URL = 2;
	/**
	 * The request contains invalid parameters, or the parameters couldn't be
	 * identified by InMobi. <br/>
	 * <b>InMobi property ID</b>: Please check if the passed String value is
	 * 'activated' on InMobi UI.<br/>
	 * <b> Carrier IP</b: Please check if a valid Mobile Country code was passed
	 * in the request. Localhost values such as "10.x.y.z" or "192.x.y.z" are
	 * disallowed.<br/>
	 * <b> User Agent</b>: Please pass in a valid Mobile User Agent. Passing any
	 * desktop User Agent is disallowed, and request will be terminated by
	 * InMobi.
	 */
	public static final int INVALID_REQUEST = 3;
	/**
	 * Served has returned a no-fill, no action required here. Publishers are
	 * expected to try requesting ads in future.
	 */
	public static final int NO_FILL = 4;
	/**
	 * Coulnd't connect to the server, or the request timed out.
	 */
	public static final int TIME_OUT = 5;
	/**
	 * InMobi server gateway experienced too many requests, and hence a gateway
	 * time out occured. Please ignore this error, and try requesting ads after some time.
	 */
	public static final int GATEWAY_TIME_OUT = 6;

	private int responseCode = UNKNOWN;
	private String responseMsg;

	public int getResponseCode() {
		return responseCode;
	}

	public void setResponseCode(int responseCode) {
		this.responseCode = responseCode;
	}

	public String getResponseMsg() {
		return responseMsg;
	}

	public void setResponseMsg(String responseMsg) {
		this.responseMsg = responseMsg;
	}

	public ErrorCode() {

	}

	public ErrorCode(int responseCode, String responseMsg) {
		this.responseCode = responseCode;
		this.responseMsg = responseMsg;
	}

}
