package main.java.com.inmobi.monetization.ads;

import java.util.ArrayList;
import java.util.concurrent.atomic.AtomicBoolean;

import main.java.com.inmobi.monetization.ads.listener.AdFormatListener;
import main.java.com.inmobi.monetization.api.net.ErrorCode;
import main.java.com.inmobi.monetization.api.net.RequestResponseManager;
import main.java.com.inmobi.monetization.api.request.ad.Request;
import main.java.com.inmobi.monetization.api.request.enums.AdRequest;
import main.java.com.inmobi.monetization.api.response.ad.AdResponse;

/**
 * This is the abstract base class for InMobi ad formats. The class must be
 * extended( please look at Banner,Interstitial classes for perusal.
 * 
 * @author rishabhchowdhary
 * 
 */
public abstract class AdFormat {

	protected AtomicBoolean isRequestInProgress = new AtomicBoolean();
	protected ErrorCode errorCode;
	protected AdFormatListener listener = null;
	protected RequestResponseManager manager = new RequestResponseManager();
	protected AdRequest requestType;

	/**
	 * 
	 * @return The errorCode object, if any for this class instance.
	 */
	public ErrorCode getErrorCode() {
		return errorCode;
	}
	/**
	 * Override this method to trigger a synchronous request.
	 * @param request
	 * @return
	 */
	public abstract ArrayList<? extends AdResponse> loadRequest(Request request);
	
	protected boolean canLoadRequest(Request request,AdRequest requestType) {
		boolean valid = false;
		if(request == null) {
			return false;
		}
		request.setRequestType(requestType);
		if(!request.isValid()) {
			valid = false;
		}
		else if(isRequestInProgress.compareAndSet(false, true)) {
			valid = true;
		}
		return valid;
	}

}
