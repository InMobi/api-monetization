package main.java.com.inmobi.monetization.api.net;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.Closeable;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;

import main.java.com.inmobi.monetization.api.request.ad.Request;
import main.java.com.inmobi.monetization.api.utils.InternalUtil;
import main.java.com.inmobi.monetization.api.utils.LogLevel;

import org.json.JSONObject;

import android.util.Log;

/**
 * This class can be used to request InMobi Ads, by passing in a valid
 * AdRequestObject, and a ad format type. You may use this class to obtain the
 * response as a String, or as a InputStream. You may also check the
 * <i>errorCode</i> value to check if in case an error had occurred, if the
 * response returned is invalid. This class makes use of the
 * java.net.HttpURLConnection, to request InMobi ads in a synchronous fashion.
 * Publishers may create new Threads themselves to fire http requests in an
 * asynchronous manner.
 * 
 * @note It is your responsibility to check if the request contains the
 *       mandatory required parameters. If the mandatory parameters are not
 *       present, the server would terminated the request. <br/>
 *       We recommend converting Request Object to JsonObject using <b>
 *       JSONPayloadCreator</b>, so that any missing parameter can be
 *       identified.<br/> 
 *       Publishers may also check 'isRequestInProgress' before
 *       calling any of request methods, to check if a request was in progress
 *       or not.
 * @author rishabhchowdhary
 * 
 */
public class RequestResponseManager {

	private ErrorCode errorCode = null;
	private static final String INMOBI_API_2_0_URL = "http://api.w.inmobi.com/showad/v2.1";
	private boolean isRequestInProgress;

	/**
	 * 
	 * This method internally calls the fetchAdResponseAsStream() to obtain the
	 * InputStream, and converts the InputStream to a String object to return
	 * the raw response.
	 * 
	 * @note This method runs in a synchronous manner.<br/>
	 *       You should also check for isRequestInProgres to false, before
	 *       calling this function. If called when the request is in progress,
	 *       this function would return null.
	 * 
	 * @param request
	 *            The AdRequest object, containing the required
	 *            User,Device,Impression info.
	 * @param requestType
	 *            One of banner/interstitial/native ad-format.
	 * @return The InputStream as the result of the HttpUrlConnection.
	 */
	public String fetchAdResponseAsString(Request request) {

		String response = null;
		errorCode = null;
		try {
			InputStream is = fetchAdResponseAsStream(request);
			response = convertStreamToString(is);
		} catch (Exception e) {
			setErrorCode(null);
		}
		return response;
	}

	/**
	 * This method returns the InputStream, as obtained from the response. If
	 * the server did not return a 200 HTTP OK response, please check the
	 * errorCode value to obtain any additional details about the connection
	 * error.
	 * 
	 * @note This method runs in a synchronous manner.
	 * 
	 * @param request
	 *            The AdRequest object, containing the required
	 *            User,Device,Impression info.
	 * @param requestType
	 *            One of banner/interstitial/native ad-format.
	 * @return The InputStream as the result of the HttpUrlConnection.
	 */
	public InputStream fetchAdResponseAsStream(Request request) {
		// TODO Auto-generated method stub
		isRequestInProgress = true;
		JSONObject obj = JSONPayloadCreator.generateInMobiAdRequestPayload(
				request);
		errorCode = null;
		InputStream is = null;

		if (obj != null) {
			try {
				String postBody = obj.toString();
				//Log.d("",postBody);
				URL serverUrl = new URL(INMOBI_API_2_0_URL);
				HttpURLConnection connection = (HttpURLConnection) serverUrl
						.openConnection();
				setConnectionParams(connection,request);
				postData(connection, postBody);
				if (connection.getResponseCode() == HttpURLConnection.HTTP_OK) {
					is = connection.getInputStream();
				} else {
					setErrorMessage(connection);
					;
				}

			} catch (MalformedURLException e) {
				// TODO Auto-generated catch block
				InternalUtil.Log(e.getStackTrace().toString(), LogLevel.ERROR);
				errorCode = new ErrorCode(ErrorCode.MALFORMED_URL,
						e.getLocalizedMessage());
			} catch (IOException e) {
				// TODO Auto-generated catch block
				InternalUtil.Log(e.getStackTrace().toString(), LogLevel.ERROR);
				errorCode = new ErrorCode(ErrorCode.IO_EXCEPTION,
						e.getLocalizedMessage());
			}

		}
		isRequestInProgress = false;
		return is;
	}

	private void setErrorMessage(HttpURLConnection connection) {
		int code = ErrorCode.UNKNOWN;
		String msg = "";
		try {
			int responseCode = connection.getResponseCode();
			switch (responseCode) {
			case 400:
				code = ErrorCode.INVALID_REQUEST;
				msg = "Invalid Request. Please check the mandatory parameters passed in the request.\n"
						+ "Mandatory params include:"
						+ "1. Property ID must be valid. Please check on InMobi portal\n"
						+ "2. User Agent string must be a valid Mobile User Agent.\n"
						+ "3. Carrier IP passed must be a valid Mobile Country Code.";
				break;
			case 204:
				code = ErrorCode.NO_FILL;
				msg = "Server returned a no fill. Please try again later.";
			case 504:
				code = ErrorCode.GATEWAY_TIME_OUT;
				msg = "Served timed out your request. Please try again later.";
			default:
				code = responseCode;
				msg = "Serve returned response code:" + responseCode;
				break;
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			InternalUtil.Log(e.getStackTrace().toString(), LogLevel.ERROR);
			code = ErrorCode.IO_EXCEPTION;
			msg = e.getLocalizedMessage();
		}
		errorCode = new ErrorCode(code, msg);
	}

	private static void setConnectionParams(HttpURLConnection connection,Request request)
			throws ProtocolException {
		connection.setDoOutput(true);
		connection.setDoInput(true);
		connection.setConnectTimeout(60 * 1000);
		connection.setReadTimeout(30 * 1000);
		connection.setUseCaches(false);
		connection.setRequestProperty("content-type", "application/json");
		connection.setRequestProperty("x-device-user-agent", request.getDevice().getUserAgent());
		connection.setRequestProperty("x-forwarded-for", request.getDevice().getCarrierIP());
	}

	private void postData(HttpURLConnection connection, String postBody)
			throws IOException {

		connection.setRequestProperty("Content-Length",
				Integer.toString(postBody.length()));

		BufferedWriter writer = null;
		try {
			writer = new BufferedWriter(new OutputStreamWriter(
					connection.getOutputStream()));
			writer.write(postBody);
		} finally {
			closeResource(writer);
		}
	}

	private void closeResource(Closeable resource) {
		if (resource != null) {
			try {
				resource.close();
			} catch (IOException e) {
				InternalUtil.Log(e.getStackTrace().toString(), LogLevel.ERROR);
			}
		}
	}

	private String convertStreamToString(InputStream is) {
		BufferedReader reader = null;
		String response = null;
		try {
			reader = new BufferedReader(new InputStreamReader(is, "UTF-8"));
			StringBuilder adResponseStrBuff = new StringBuilder();
			String line;

			while ((line = reader.readLine()) != null) {
				adResponseStrBuff.append(line).append("\n");
			}
			response = adResponseStrBuff.toString();
		} catch (IOException e) {
		} finally {
			closeResource(reader);
		}
		return response;
	}

	public ErrorCode getErrorCode() {
		return errorCode;
	}

	public void setErrorCode(ErrorCode errorCode) {
		this.errorCode = errorCode;
	}

	/**
	 * 
	 * @return true, if the request is in progress. else returns false.
	 */
	public boolean isRequestInProgress() {
		return isRequestInProgress;
	}

}
