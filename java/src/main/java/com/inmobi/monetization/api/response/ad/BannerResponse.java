package main.java.com.inmobi.monetization.api.response.ad;

import main.java.com.inmobi.monetization.api.request.utils.Validator;
import main.java.com.inmobi.monetization.api.utils.InternalUtil;

/**
 * This class is used to construct Banner/Interstitial response as a plain Java object.
 * @author rishabhchowdhary
 *
 */
public class BannerResponse extends AdResponse implements Validator {

	/**
	 * The CDATA String, as obtained from the banner ad response from InMobi.
	 * 
	 * @warning <b>Please do not tamper with this String, and load it as it is
	 *          on the client side. Tampering with the String to scrape out any
	 *          specific html/javascript components may result in incorrect
	 *          results on our portal, or may also lead to your site being
	 *          marked as invalid.</b>
	 */
	public String CDATA = null;
	/**
	 * The Click URL, as obtained from the banner ad response from InMobi.
	 * 
	 * @note The click URL is an optional value, and may be null in case of
	 *       specific ad response. Publishers are expected to refer to the click
	 *       URL only if its available, and open in the <b>device browser for
	 *       which the requests was fired.</b> <br/>
	 *       <i>Firing the click URL from your server side may result in click
	 *       being not counted correctly.</i>
	 */
	public String adUrl = null;
	/**
	 * The general value of the action, associated with this ad unit.
	 * 
	 * @eg appStore, call, sms, calender, etc..
	 */
	public String actionName = null;
	/**
	 * The actionType is an integer value which defines the action, associated
	 * with this banner response. The associated action here implies the
	 * methodology to be followed, to open the post click action.</br>
	 * <b>General values:</b></br> <b>1</b>: Implies the click URL can be opened
	 * as a "full screen embedded browser" within the app.</br> For any other
	 * integer value, you may open the associated action as a general Intent,
	 * and let the device OS open the associated app( iTunes, GP, Default
	 * browser, etc.)</br>
	 * 
	 */
	public int actionType;
	/**
	 * The ad dimensions associated with this ad unit. Use adsize.width,
	 * adsize.height to obtain the specific width/height parameters.
	 */
	public AdSize adsize = null;
	/**
	 * true - If the ad response is an interstitial ad unit, no - If the ad
	 * resposne is a banner ad unit.
	 */
	public boolean isInterstitial;
	public boolean isRichMedia;

	/**
	 * This class represents the width/height parameter of served banner ad.
	 * 
	 * @author rishabhchowdhary
	 * 
	 */
	public static class AdSize {
		public int width = 0;
		public int height = 0;

		public AdSize(int w, int h) {
			if (w > 0)
				this.width = w;
			if (h > 0)
				this.height = h;
		}
	}

	/**
	 * Use this method to check if this object has all the required parameters
	 * present. If this method returns false, the object generated after XML
	 * parsing would be discarded.
	 * 
	 * @return True, If the mandatory params are present.False, otherwise.
	 */
	public boolean isValid() {
		boolean isValid = true;
		if (InternalUtil.isBlank(CDATA) || adsize == null)
			isValid = false;
		else if (adsize.width <= 0 || adsize.height <= 0)
			isValid = false;
		return isValid;
	}

	@Override
	public String toString() {
		int width = (adsize != null) ? adsize.width : 0;
		int height = (adsize != null) ? adsize.height : 0;
		return "<Ad actionType=\"" + actionType + "\" " + "actionName=\""
				+ actionName + "\" " + "width=\"" + width + "\" " + "height=\""
				+ height + "\" >" + "<![CDATA[" + CDATA + "]]>" + "<AdURL>"
				+ adUrl + "</AdURL>" + "</Ad>";
	}
}
