package main.java.com.inmobi.monetization.api.net;

import main.java.com.inmobi.monetization.api.request.ad.Data;
import main.java.com.inmobi.monetization.api.request.ad.Device;
import main.java.com.inmobi.monetization.api.request.ad.Geo;
import main.java.com.inmobi.monetization.api.request.ad.Impression;
import main.java.com.inmobi.monetization.api.request.ad.Property;
import main.java.com.inmobi.monetization.api.request.ad.Request;
import main.java.com.inmobi.monetization.api.request.ad.Slot;
import main.java.com.inmobi.monetization.api.request.ad.User;
import main.java.com.inmobi.monetization.api.request.ad.UserSegment;
import main.java.com.inmobi.monetization.api.request.enums.AdRequest;
import main.java.com.inmobi.monetization.api.request.enums.Gender;
import main.java.com.inmobi.monetization.api.utils.InternalUtil;
import main.java.com.inmobi.monetization.api.utils.LogLevel;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;



public class JSONPayloadCreator {

	/**
	 * This method constructs a JSONObject, depending on the request parameters passed.
	 * @note The request object needs to have valid arguments, depending on the AdRequestType
	 * You should check if the request.isValid() returns true, as this method internally
	 * validates the request & proceeds if & only the request object is valid for the AdRequestType.
	 * @param request The request object, for which a JSON would be constructed
	 * @param type The request type, one of Banner, Interstitial or Native ads
	 * @return JSONObject which is used as POST Body in the InMobi API 2.0 Ad Request. 
	 * TODO User demography as part of JSON API request.
	 */
	public static JSONObject generateInMobiAdRequestPayload(Request request) {

		if (request == null) {
			InternalUtil.Log("Request object cannot be null",LogLevel.ERROR);
			return null;
		}
		if(!request.isValid()) {
			InternalUtil.Log("Please provide valid parameters in the request object",LogLevel.ERROR);
			return null;
		}
		JSONObject mainObject = new JSONObject();
		// request format
		try {
			if (request.getRequestType() != AdRequest.NATIVE) {
				
				mainObject.put("responseformat", "axml");
			} else {
				mainObject.put("responseformat", "native");
			}

			// site format

			JSONObject propertyObject = getPropertyJSON(request.getProperty());
			if (propertyObject != null) {
				
				mainObject.put("site", propertyObject);
			}

			JSONArray impArray = getImpressionJSON(request.getImpression(), request.getRequestType());
			if(impArray != null) {
				mainObject.put("imp", impArray);
			}
			
			JSONObject userObject = getUserJSON(request.getUser());
			if(userObject != null) {
				mainObject.put("user", userObject);
			}
			
			JSONObject deviceObject = getDeviceJSON(request.getDevice());
			if(deviceObject != null) {
				mainObject.put("device", deviceObject);
			}
		} catch(JSONException e) {}

		return mainObject;

	}

	private static JSONObject getPropertyJSON(Property property) throws JSONException {
		JSONObject siteObject = null;
		if (property != null) {
			siteObject = new JSONObject();
			String propertyId = property.getPropertyId();
			if (propertyId != null) {
				siteObject.put("id", propertyId);
			}

		}
		return siteObject;
	}

	private static JSONArray getImpressionJSON(Impression imp,
			AdRequest type) throws JSONException {
		JSONArray impArray = null;
		if (imp != null) {
			JSONObject impressionObject = new JSONObject();

			Slot banner = imp.getSlot();
			if (type != AdRequest.NATIVE) {
				JSONObject bannerObject = new JSONObject();

				String pos = banner.getPosition();
				if (pos != null) {
					bannerObject.put("pos", pos);
				}
				bannerObject.put("adsize", banner.getAdSize());
				impressionObject.put("banner", bannerObject);
			}
			// displaymanager/ver values have a default value, ads too has a
			// default value.
			impressionObject.put("ads", imp.getNoOfAds());
			impressionObject.put("displaymanager",
					imp.getDisplayManager());
			impressionObject.put("displaymanagerver",
					imp.getDisplayManagerVersion());

			// adtype=int, for interstitial ads.
			if (type == AdRequest.INTERSTITIAL) {
				impressionObject.put("adtype", "int");
			}
			// impression object is an array
			impArray = new JSONArray();
			impArray.put(impressionObject);

		}
		return impArray;
	}
	
	private static JSONObject getDeviceJSON(Device device) throws JSONException {
		JSONObject deviceObject = null;
		if(device != null) {
			deviceObject = new JSONObject();
			if (device != null) {
				String ip = device.getCarrierIP();
				if (ip != null) {
					deviceObject.put("ip", ip);
				}
				String ua = device.getUserAgent();
				if (ua != null) {
					deviceObject.put("ua", ua);
				}
				//for Android sites..
				String gpid = device.getGpId();
				if (gpid != null) {
					deviceObject.put("gpid", gpid);
				}
			}

			Geo geo = device.getGeo();
			if (geo != null && geo.isValid()) {
				JSONObject geoObject = new JSONObject();
				geoObject.put("lat", geo.getLatitude());
				geoObject.put("lon", geo.getLongitude());
				geoObject.put("accu", geo.getAccuracy());
				deviceObject.put("geo", geoObject);
			}
		}
		return deviceObject;
	}
	
	private static JSONObject getUserJSON(User user) throws JSONException{
		JSONObject userObject = null;
		if(user != null) {
			userObject = new JSONObject();
			if (user.getYearOfBirth() > 0) {
				userObject.put("yob", user.getYearOfBirth());
			}
			Gender gender = user.getGender();
			if (gender != Gender.UNKNOWN) {
				if (gender == Gender.MALE) {
					userObject.put("gender", "M");
				} else {
					userObject.put("gender", "F");
				}
			}
			JSONObject dataObject = new JSONObject();
			Data data = user.getData();
			if(data != null) {
				String ID = data.getID();
				if (ID != null) {
					dataObject.put("id", ID);
				}
				String name = data.getName();
				if (name != null) {
					dataObject.put("name", name);
				}
				UserSegment segmentObject = data.getUserSegment();
				if (segmentObject != null) {
					if (segmentObject.getUserSegmentArray() != null) {
						// dataObject.put("segment",new JSONObject());
						JSONArray dataArray = new JSONArray();
						dataArray.put(dataObject);
						userObject.put("data", dataArray);
					}
				}
			}
		}
		return userObject;
	}

}
