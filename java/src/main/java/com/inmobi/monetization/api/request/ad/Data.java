package main.java.com.inmobi.monetization.api.request.ad;

import main.java.com.inmobi.monetization.api.request.utils.Validator;
import main.java.com.inmobi.monetization.api.utils.InternalUtil;

/**
 * This class represents the data and segment s together allow data about
 * the user to be passed to the ad server through the ad request.
 * 
 * Data can be from multiple sources, as specified by the data Õs id
 * field. This , and all of its parameters, are optional.
 * 
 * @author rishabhchowdhary
 * 
 */
public class Data implements Validator {

	private String ID = null;
	private String name = null;
	private UserSegment userSegment = null;

	/**
	 * 
	 * @return The data provider ID String, as set.
	 */
	public String getID() {
		return ID;
	}

	/**
	 * 
	 * @param ID
	 *            The data provider ID, must not be null.
	 */
	public void setID(String ID) {
		if (!InternalUtil.isBlank(ID)) {
			this.ID = ID;
		}
	}

	/**
	 * 
	 * @return The data provider Name, as set.
	 */
	public String getName() {
		return name;
	}

	/**
	 * 
	 * @param name
	 *            The data provider String, must not be null.
	 */
	public void setName(String name) {
		if (!InternalUtil.isBlank(name)) {
			this.name = name;
		}

	}

	/**
	 * 
	 * @return UserSegment, as set.
	 */
	public UserSegment getUserSegment() {
		return userSegment;
	}

	/**
	 * 
	 * @param userSegment
	 *            The UserSegment info, having the required demographic,
	 *            for additional targeting purposes. This is an optional field.
	 * 
	 */
	public void setUserSegment(UserSegment userSegment) {
		this.userSegment = userSegment;
	}

	public Data(String ID, String name,
			UserSegment userSegment) {
		setID(ID);
		setName(name);
		setUserSegment(userSegment);
	}

	public Data() {

	}

	/**
	 * TODO
	 * @return true, always.
	 */
	public boolean isValid() {

		// ID,name etc are optional
		return true;
	}
}
