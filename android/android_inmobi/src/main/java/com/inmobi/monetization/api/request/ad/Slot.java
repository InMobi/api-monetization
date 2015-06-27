package main.java.com.inmobi.monetization.api.request.ad;

import main.java.com.inmobi.monetization.api.request.utils.Validator;
import main.java.com.inmobi.monetization.api.utils.InternalUtil;

/**
 * This class represents the "banner" object, required under the "imp" object to
 * describe the type of ad requested.</br>
 * 
 * <p>
 * <b>Note:</b>
 * </p>
 * It is a must to provide a valid ad-slot if you're requesting
 * Banner/Interstitial ads. If in case you have not provided a valid value, the
 * back end system would choose a default value.
 * 
 * @author rishabhchowdhary
 * 
 */
public class Slot implements Validator {

	private int adSize = 0;
	private String position = null;

	/**
	 * 
	 * @return The int value corresponding to the slot size.
	 * 
	 */
	public int getAdSize() {
		return adSize;
	}

	/**
	 * Use this setter to provide an ad-size.
	 * 
	 * @param adSize
	 *            The integer value to represent the requested ad-size.</br>
	 *            <b>Note:</b> Must be greater than zero.
	 */
	public void setAdSize(int adSize) {
		if (adSize > 0) {
			this.adSize = adSize;
		}
	}

	/**
	 * 
	 * @return Returns the String value of the position specified.
	 */
	public String getPosition() {
		return position;
	}

	/**
	 * 
	 * @param position
	 *            The position in your app where the banner is placed.</br>
	 *            <b>Example:</b> "top", "center", "bottom", etc.
	 */
	public void setPosition(String position) {
		if (!InternalUtil.isBlank(position)) {
			this.position = position;
		}

	}

	public Slot(int adSize, String position) {
		setAdSize(adSize);
		setPosition(position);
	}

	public Slot() {

	}

	/**
	 * Use this method to check if this object has all the required parameters
	 * present, to be used to construct a JSON request. The required parameters
	 * would be specific to an ad-format.
	 * 
	 * @param type
	 *            The AdRequestType - one of Banner,Interstitial or Native.
	 * @return If the mandatory params are present, then true, otherwise false.
	 */
	public boolean isValid() {
		boolean isValid = true;
		if (adSize <= 0) {
			isValid = false;
		}
		return isValid;
	}
}
