package main.java.com.inmobi.monetization.api.request.ad;

import main.java.com.inmobi.monetization.api.request.utils.Validator;
import main.java.com.inmobi.monetization.api.utils.InternalUtil;

/**
 * The imp object describes the ad position or the impression being requested.
 * 
 * @author rishabhchowdhary
 * 
 */
public class Impression implements Validator {

	public static final int DEFAULT_AD_COUNT = 1;
	public static final int MAX_AD_COUNT = 3;
	private int noOfAds = DEFAULT_AD_COUNT;
	private boolean isInterstitial;
	private String displayManager = "s_im_java";
	private String displayManagerVersion = InternalUtil.LIB_VERSION;
	private Slot slot;

	public int getNoOfAds() {
		return noOfAds;
	}

	/**
	 * Sets the no. of ads, to be requested in one ad.
	 * 
	 * @param noOfAds
	 *            Available range: [1-3]. Default value is 1.
	 */
	public void setNoOfAds(int noOfAds) {
		if (noOfAds > 0) {
			if (noOfAds <= MAX_AD_COUNT) {
				this.noOfAds = noOfAds;
			} else {
				this.noOfAds = DEFAULT_AD_COUNT;
			}
		}

	}

	/**
	 * 
	 * @return If the impression object created is of AdRequestType.INTERSTITIAL
	 *         then true, false otherwise.
	 */
	public boolean isInterstitial() {
		return isInterstitial;
	}

	/**
	 * 
	 * @param isInterstitial
	 *            Set this flag to true if the request is of type
	 *            AdRequestType.INTERSTITIAL. Else false otherwise.</br>
	 *            <p>
	 *            <b>Note:</b>
	 *            </p>
	 *            If you're using one of com.inmobi.monetization.ads class, this
	 *            flag can be ignored. The classes internally setup the required
	 *            flag.
	 * 
	 */
	public void setInterstitial(boolean isInterstitial) {
		this.isInterstitial = isInterstitial;
	}

	/**
	 * 
	 * @return The display Manager String value as set.
	 */
	public String getDisplayManager() {
		return displayManager;
	}

	/**
	 * Set the display manager string as per your request environment.</br>
	 * <p>
	 * Examples:
	 * </p>
	 * Use <i>c_</i> prefix if your request environment is native iOS/Android
	 * client.</br> Use <i>s_</i> prefix if your request environment is from
	 * your server side.</br> Default value is <b>s_imapi</b>.</br>
	 * <p>
	 * <b>Note:</b>
	 * </p>
	 * Must not be empty.
	 * 
	 * @param displayManager
	 */
	public void setDisplayManager(String displayManager) {
		if (!InternalUtil.isBlank(displayManager)) {
			this.displayManager = displayManager;
		}
	}

	/**
	 * 
	 * 
	 * @return Returns the String value of the display manager version.
	 */
	public String getDisplayManagerVersion() {
		return displayManagerVersion;
	}

	/**
	 * 
	 * @param displayManagerVersion
	 *            The String version of your display manager, as per your
	 *            specification. Ex "1.0", "2.2.1", etc.
	 */
	public void setDisplayManagerVersion(String displayManagerVersion) {
		if (!InternalUtil.isBlank(displayManagerVersion)) {
			this.displayManagerVersion = displayManagerVersion;
		}
	}

	/**
	 * 
	 * @return The BannerObject, associated with this ImpressionObject instance.
	 */
	public Slot getSlot() {
		return slot;
	}

	/**
	 * 
	 * @param bannerObj
	 *            The BannerObject, associated with this instance.
	 */
	public void setSlot(Slot slot) {
		this.slot = slot;
	}

	public Impression(Slot slot) {
		setSlot(slot);
	}

	public Impression() {

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
		boolean isValid = false;
		// display manager values are optional, and have a default value
		// assigned..
		// check & return if BannerObject is valid.
		if (slot != null) {
			isValid = slot.isValid();
		}
		return isValid;
	}

}
