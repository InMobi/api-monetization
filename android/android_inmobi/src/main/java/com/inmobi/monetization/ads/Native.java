package main.java.com.inmobi.monetization.ads;

import java.util.ArrayList;

import main.java.com.inmobi.monetization.ads.listener.AdFormatListener;
import main.java.com.inmobi.monetization.api.net.ErrorCode;
import main.java.com.inmobi.monetization.api.request.ad.Request;
import main.java.com.inmobi.monetization.api.request.enums.AdRequest;
import main.java.com.inmobi.monetization.api.response.ad.NativeResponse;
import main.java.com.inmobi.monetization.api.response.parser.JSONNativeResponseParser;

/**
 * Publishers may use this class to request Native ads from InMobi.
 * 
 * @author rishabhchowdhary
 * 
 */
public class Native extends AdFormat {

	private JSONNativeResponseParser jsonParser = new JSONNativeResponseParser();

	public Native() {
		requestType = AdRequest.NATIVE;
	}
	
	private ArrayList<NativeResponse> loadRequestInternal(Request request) {
		errorCode = null;
		ArrayList<NativeResponse> ads = null;
		request.setRequestType(requestType);
		String response = manager.fetchAdResponseAsString(request);
		errorCode = manager.getErrorCode();
		ads = jsonParser.fetchNativeAdsFromResponse(response);
		isRequestInProgress.set(false);
		if (ads == null) {
			errorCode = new ErrorCode(ErrorCode.NO_FILL,
					"Server returned a no-fill.");
		} else if (ads.size() == 0) {
			errorCode = new ErrorCode(ErrorCode.NO_FILL,
					"Server returned a no-fill.");
		}
		return ads;
	}

	/**
	 * This function loads native ads synchronously.
	 * 
	 * @note Please check for isRequestInProgress to false, before calling this
	 *       function.<br/>
	 *       The function returns null if the request was already in progress.
	 *       Please also provide a valid Request Object. You may check if the
	 *       IMAdRequest object is valid by calling isValid() on the object.
	 * @return ArrayList containing the NativeResponse objects.
	 */
	public synchronized ArrayList<NativeResponse> loadRequest(Request request) {
		ArrayList<NativeResponse> ads = null;
		
		if (canLoadRequest(request,requestType) == true) {
			ads = loadRequestInternal(request);
		}
		return ads;
	}

}
