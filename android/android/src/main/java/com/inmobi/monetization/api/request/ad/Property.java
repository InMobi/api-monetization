package main.java.com.inmobi.monetization.api.request.ad;

import main.java.com.inmobi.monetization.api.request.utils.Validator;
import main.java.com.inmobi.monetization.api.utils.InternalUtil;
import main.java.com.inmobi.monetization.api.utils.LogLevel;

/**
 * This class contains info about the InMobi Property, which is mandatory as
 * part of the InMobi Ad Request.
 * 
 * @author rishabhchowdhary
 * 
 */
public class Property implements Validator {

	private String propertyId = null;

	/**
	 * 
	 * @return The String value of the Property ID, as set.
	 */
	public String getPropertyId() {
		return propertyId;
	}

	/**
	 * 
	 * @param propertyId
	 *            The Property ID, as obtained from the InMobi UI.
	 *          <p>
	 *          <b>Note:</b>
	 *          </p>
	 * 
	 *          The Property ID is an alphanumeric String.
	 * 
	 */
	public void setPropertyId(String propertyId) {
		if (!InternalUtil.isBlank(propertyId)) {
			this.propertyId = propertyId;
		}
	}

	/**
	 * 
	 * @param propertyId
	 *            Must be the alphanumeric ID as obtained from your InMobi
	 *            dashboard
	 * @note The paramter must not be null
	 */
	public Property(String property) {
		setPropertyId(property);
	}

	public Property() {

	}

	/**
	 * Use this method to check if this object has all the required parameters
	 * present, to be used to construct a JSON request. The required parameters
	 * would be specific to an ad-format.
	 * 
	 * @return true, if the Property ID set is not empty. False, otherwise.
	 */
	public boolean isValid() {
		boolean isValid = false;
		if (propertyId != null) {
			isValid = true;
		} else {
			InternalUtil.Log(
					"Please provide a valid Property ID in the request.",
					LogLevel.ERROR);
		}
		return isValid;
	}
}
