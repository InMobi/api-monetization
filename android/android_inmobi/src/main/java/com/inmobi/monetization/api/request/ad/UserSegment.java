package main.java.com.inmobi.monetization.api.request.ad;

import java.util.HashMap;

import main.java.com.inmobi.monetization.api.request.utils.Validator;

/**
 * TODO
 * This class defines the user segments, to be passed as an optional parameter
 * in InMobi Ad request. Segment objects convey specific units of information
 * from the provider identified, in the parent data object
 * 
 * @author rishabhchowdhary
 * 
 */
public class UserSegment implements Validator {

	private HashMap<String, String> userSegmentArray;

	public HashMap<String, String> getUserSegmentArray() {
		return userSegmentArray;
	}

	/**
	 * Use this setter to set the user segment array.
	 * 
	 * @param userSegmentArray
	 */
	public void setUserSegmentArray(HashMap<String, String> userSegmentArray) {
		this.userSegmentArray = userSegmentArray;
	}

	/**
	 * TODO
	 * 
	 * @return true, always
	 */
	public boolean isValid() {
		return true;
	}
}
