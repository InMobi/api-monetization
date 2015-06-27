package main.java.com.inmobi.monetization.api.request.ad;

import main.java.com.inmobi.monetization.api.request.utils.Validator;

/**
 * The geo object collects the userÕs latitude, longitude, and accuracy details.
 * This object, and all of its parameters, are optional.
 * 
 * @author rishabhchowdhary
 * 
 */
public class Geo implements Validator {

	public static int NOT_VALID = 0;
	private float latitude = NOT_VALID;
	private float longitude = NOT_VALID;
	private int accuracy = NOT_VALID;
	private static double DELTA = 0.001;

	/**
	 * 
	 * @return The latitude value as set. Default value is 0
	 */
	public float getLatitude() {
		return latitude;
	}

	/**
	 * Latitude float value can accept in the range [-90,90]. Outside range
	 * values will be ignored.
	 * 
	 * @param lat
	 *            The latitude value, as obtained from the device.
	 */
	public void setLatitude(float lat) {
		if (lat > -90 && lat < 90) {
			this.latitude = lat;
		} else {
			// throw exception here?
		}

	}

	/**
	 * 
	 * @return The longitude value as set.
	 */
	public float getLongitude() {
		return longitude;
	}

	/**
	 * Longitude float value can accept in the range [-180,180]. Outside range
	 * values will be ignored.
	 * 
	 * @param lon
	 *            The Longitude value, as obtained from the device.
	 */
	public void setLongitude(float lon) {
		if (lon > -180 && lon < 180) {
			this.longitude = lon;
		} else {
			// throw exception
		}

	}

	/**
	 * The accuracy range, of the co-ordinates thus obtained. 
	 * @return
	 */
	public int getAccuracy() {
		return accuracy;
	}

	/**
	 * Must be a positive integer value. Accepted range is [1,1000]
	 * @param accu
	 */
	public void setAccuracy(int accu) {
		if (accu > 0 && accu < 1000) {
			this.accuracy = accu;
		} else {
			// throw exception?
		}

	}

	public Geo() {

	}

	public Geo(float lat, float lon, int accu) {
		setLatitude(lat);
		setLongitude(lon);
		setAccuracy(accu);
	}

	/**
	 * Use this method to check if this object has all the required parameters
	 * present, to be used to construct a JSON request. The required parameters
	 * would be specific to an ad-format.
	 * 
	 * @return If the mandatory params are present, then true, otherwise false.
	 */
	public boolean isValid() {
		boolean isValid = false;
		if (accuracy != NOT_VALID && (Math.abs(latitude - NOT_VALID) > DELTA)
				&& (Math.abs(longitude - NOT_VALID) > DELTA)) {
			isValid = true;
		}
		return isValid;
	}
}
