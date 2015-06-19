package main.java.com.inmobi.monetization.api.request.ad;

import main.java.com.inmobi.monetization.api.request.enums.AdRequest;
import main.java.com.inmobi.monetization.api.request.utils.Validator;
import main.java.com.inmobi.monetization.api.utils.InternalUtil;
import main.java.com.inmobi.monetization.api.utils.LogLevel;

/**
 * The top-level ad request is required to contain at least the site containing
 * the unique site ID, and the device containing the client IP address and user
 * agent information. </br>
 * 
 * <p>
 * <b>Note:</b>
 * </p>
 * If you're using one of the classes under com.inmobi.monetization.ads to
 * request ads, you must provide a valid Request.
 * 
 * @author rishabhchowdhary
 * 
 */
public class Request implements Validator {

	private Impression impression;
	private User user;
	private Property property;
	private Device device;
	private AdRequest requestType = AdRequest.NONE;

	/**
	 * 
	 * @return The Impression, as set.
	 */
	public Impression getImpression() {
		return impression;
	}

	/**
	 * 
	 * @param impression
	 *            The impression , having the required Banner as well.
	 */
	public void setImpression(Impression impression) {
		this.impression = impression;
	}

	/**
	 * 
	 * @return The User, as set.
	 */
	public User getUser() {
		return user;
	}

	/**
	 * 
	 * @param user
	 *            The User, with the necessary demographic . This is optional.
	 */
	public void setUser(User user) {
		this.user = user;
	}

	/**
	 * 
	 * @return The Property, as set.
	 */
	public Property getProperty() {
		return property;
	}

	/**
	 * 
	 * @param property
	 *            sets the Property. Property must have the correct propertyId,
	 *            as obtained from InMobi.
	 */
	public void setProperty(Property property) {
		this.property = property;
	}

	/**
	 * 
	 * @return The Device as set.
	 */
	public Device getDevice() {
		return device;
	}

	/**
	 * 
	 * @param device
	 *            The Device with the required as obtained from the actual
	 *            device.Please make sure the mandatory (Carrier IP, User Agent)
	 *            is passed correctly. Passing the required Geo would help in
	 *            additional targeting.
	 */
	public void setDevice(Device device) {
		this.device = device;
	}

	public Request(Impression impression, User user, Property property,
			Device device) {
		setImpression(impression);
		setUser(user);
		setProperty(property);
		setDevice(device);
	}

	public AdRequest getRequestType() {
		return requestType;
	}

	public void setRequestType(AdRequest requestType) {
		this.requestType = requestType;
	}

	public Request() {

	}

	/**
	 * This method basically checks for mandatory parameters, which should not
	 * be null, and are required in a request:<br/>
	 * <b>InMobi Property ID:</b> should be valid String, as obtained from
	 * InMobi, present in Property <br/>
	 * <b>Carrier IP:</b> should be valid Mobile Country Code, present in device <br/>
	 * <b>User Agent:</b> should be valid Mobile UA string, present in device <br/>
	 * <b>gpID/AndroidId/IDA:</b> A valid device ID is <i>strongly
	 * recommended.</i> Ignore the value if you're developing for Mobile Web.
	 * 
	 * @param type
	 *            The AdRequest Type, one of Native,Banner or Interstitial
	 * @note Passing in garbage values for any of mandatory parameters would
	 *       terminate the request from server side. UA is actually
	 * @return
	 */
	public boolean isValid() {
		boolean isValid = false;
		if (property != null && property.isValid()) {
			if (device != null && device.isValid()) {

				if (requestType == AdRequest.NATIVE) {
					// impression is not mandatory for native ads.
					if (user != null) {
						isValid = user.isValid();
					} else {
						isValid = true;
					}
				} else if (requestType == AdRequest.BANNER
						|| requestType == AdRequest.INTERSTITIAL) {
					if (impression != null && impression.isValid()) {

						if (user != null) {
							isValid = user.isValid();
						} else {
							isValid = true;
						}
					} else {
						InternalUtil.Log("Please provide a valid Impression in the request",LogLevel.ERROR);
					}
				} else {
					InternalUtil.Log("Valid AdRequest enum not found.",LogLevel.ERROR);
				}
			} else {
				InternalUtil.Log("Please provide a valid Device in the request",LogLevel.ERROR);
			}
		} else {
			InternalUtil.Log("Please provide a valid Property in the request",LogLevel.ERROR);
		}

		return isValid;
	}

}
