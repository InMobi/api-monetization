package main.java.com.inmobi.monetization.api.request.ad;

import main.java.com.inmobi.monetization.api.request.enums.Gender;
import main.java.com.inmobi.monetization.api.request.utils.Validator;

/**
 * This class represents the User, to be send as part of the inmobi ad
 * request. The optional values include - yob, gender, and Data.
 * 
 * @author rishabhchowdhary
 * 
 */
public class User implements Validator {

	private int yearOfBirth = 0;
	private Gender gender = Gender.UNKNOWN;
	private Data data;

	/**
	 * 
	 * @return the yob, as set.
	 */
	public int getYearOfBirth() {
		return yearOfBirth;
	}

	/**
	 * 
	 * @param yearOfBirth
	 *            The year-of-birth of the user, optional demo info.
	 */
	public void setYearOfBirth(int yearOfBirth) {
		if (yearOfBirth > 0) {
			this.yearOfBirth = yearOfBirth;
		}
	}

	/**
	 * 
	 * @return The GenderType enum info, as set. Default is GenderType.UNKNOWN.
	 */
	public Gender getGender() {
		return gender;
	}

	/**
	 * 
	 * @param genderType
	 *            The Gender of the user, optional demographic info.
	 */
	public void setGender(Gender gender) {
		this.gender = gender;
	}

	/**
	 * 
	 * @return The DataInfo, as set.
	 */
	public Data getData() {
		return data;
	}

	/**
	 * 
	 * @param dataInfo
	 *            The DataInfo, having the required data provider, and segment
	 *            info. This is optional.
	 */
	public void setData(Data data) {
		this.data = data;
	}

	public User(int yearOfBirth, Gender genderType,
			Data data) {
		setYearOfBirth(yearOfBirth);
		setGender(genderType);
		setData(data);
	}

	public User() {

	}

	/**
	 * Use this method to check if this Info has all the required parameters
	 * present, to be used to construct a JSON request. The required parameters
	 * would be specific to an ad-format.
	 * 
	 * @return If the mandatory params are present, then true, otherwise false.
	 */
	public boolean isValid() {
		boolean isValid = true;

		// UserInfo has optional arguments..
		if (data != null) {
			isValid = data.isValid();
		}
		return isValid;
	}
}
