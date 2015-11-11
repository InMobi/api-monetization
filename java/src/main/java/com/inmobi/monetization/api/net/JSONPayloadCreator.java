package main.java.com.inmobi.monetization.api.net;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParseException;

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



public class JSONPayloadCreator {

	/**
	 * This method constructs a JsonObject, depending on the request parameters passed.
	 * @note The request object needs to have valid arguments, depending on the AdRequestType
	 * You should check if the request.isValid() returns true, as this method internally
	 * validates the request & proceeds if & only the request object is valid for the AdRequestType.
	 * @param request The request object, for which a JSON would be constructed
	 * @param type The request type, one of Banner, Interstitial or Native ads
	 * @return JsonObject which is used as POST Body in the InMobi API 2.0 Ad Request. 
	 * TODO User demography as part of JSON API request.
	 */
	public static JsonObject generateInMobiAdRequestPayload(Request request) {

		if (request == null) {
			InternalUtil.Log("Request object cannot be null",LogLevel.ERROR);
			return null;
		}
		if(!request.isValid()) {
			InternalUtil.Log("Please provide valid parameters in the request object",LogLevel.ERROR);
			return null;
		}
		JsonObject mainObject = new JsonObject();
		// request format
		try {
			if (request.getRequestType() != AdRequest.NATIVE) {
				
				mainObject.addProperty("responseformat", "axml");
			} else {
				mainObject.addProperty("responseformat", "native");
			}

			// site format

			JsonObject propertyObject = getPropertyJSON(request.getProperty());
			if (propertyObject != null) {
				
				mainObject.add("site", propertyObject);
			}

			JsonArray impArray = getImpressionJSON(request.getImpression(), request.getRequestType());
			if(impArray != null) {
				mainObject.add("imp", impArray);
			}
			
			JsonObject userObject = getUserJSON(request.getUser());
			if(userObject != null) {
				mainObject.add("user", userObject);
			}
			
			JsonObject deviceObject = getDeviceJSON(request.getDevice());
			if(deviceObject != null) {
				mainObject.add("device", deviceObject);
			}
		} catch(JsonParseException e) {}
		  

		return mainObject;

	}

	private static JsonObject getPropertyJSON(Property property)  throws JsonParseException {
		JsonObject siteObject = null;
		if (property != null) {
			siteObject = new JsonObject();
			String propertyId = property.getPropertyId();
			if (propertyId != null) {
				siteObject.addProperty("id", propertyId);
			}

		}
		return siteObject;
	}

	private static JsonArray getImpressionJSON(Impression imp,
			AdRequest type) throws JsonParseException {
		JsonArray impArray = null;
		if (imp != null) {
			JsonObject impressionObject = new JsonObject();

			Slot banner = imp.getSlot();
			if (type != AdRequest.NATIVE) {
				JsonObject bannerObject = new JsonObject();

				String pos = banner.getPosition();
				if (pos != null) {
					bannerObject.addProperty("pos", pos);
				}
				bannerObject.addProperty("adsize", banner.getAdSize());
				impressionObject.add("banner", bannerObject);
			}
			// displaymanager/ver values have a default value, ads too has a
			// default value.
			impressionObject.addProperty("ads", imp.getNoOfAds());
			impressionObject.addProperty("displaymanager",
					imp.getDisplayManager());
			impressionObject.addProperty("displaymanagerver",
					imp.getDisplayManagerVersion());

			// adtype=int, for interstitial ads.
			if (type == AdRequest.INTERSTITIAL) {
				impressionObject.addProperty("adtype", "int");
			}
			// impression object is an array
			impArray = new JsonArray();
			impArray.add(impressionObject);

		}
		return impArray;
	}
	
	private static JsonObject getDeviceJSON(Device device) throws JsonParseException {
		JsonObject deviceObject = null;
		if(device != null) {
			deviceObject = new JsonObject();
			if (device != null) {
				String ip = device.getCarrierIP();
				if (ip != null) {
					deviceObject.addProperty("ip", ip);
				}
				String ua = device.getUserAgent();
				if (ua != null) {
					deviceObject.addProperty("ua", ua);
				}
				//for Android sites..
				String gpid = device.getGpId();
				if (gpid != null) {
					deviceObject.addProperty("gpid", gpid);
				}
				//for iOS sites..
				String ida = device.getIda();
				if(ida != null) {
					deviceObject.addProperty("ida", ida);
				}
			}

			Geo geo = device.getGeo();
			if (geo != null && geo.isValid()) {
				JsonObject geoObject = new JsonObject();
				geoObject.addProperty("lat", geo.getLatitude());
				geoObject.addProperty("lon", geo.getLongitude());
				geoObject.addProperty("accu", geo.getAccuracy());
				deviceObject.add("geo", geoObject);
			}
		}
		return deviceObject;
	}
	
	private static JsonObject getUserJSON(User user) throws JsonParseException {
		JsonObject userObject = null;
		if(user != null) {
			userObject = new JsonObject();
			if (user.getYearOfBirth() > 0) {
				userObject.addProperty("yob", user.getYearOfBirth());
			}
			Gender gender = user.getGender();
			if (gender != Gender.UNKNOWN) {
				if (gender == Gender.MALE) {
					userObject.addProperty("gender", "M");
				} else {
					userObject.addProperty("gender", "F");
				}
			}
			JsonObject dataObject = new JsonObject();
			Data data = user.getData();
			if(data != null) {
				String ID = data.getID();
				if (ID != null) {
					dataObject.addProperty("id", ID);
				}
				String name = data.getName();
				if (name != null) {
					dataObject.addProperty("name", name);
				}
				UserSegment segmentObject = data.getUserSegment();
				if (segmentObject != null) {
					if (segmentObject.getUserSegmentArray() != null) {
						// dataObject.addProperty("segment",new JsonObject());
						JsonArray dataArray = new JsonArray();
						dataArray.add(dataObject);
						userObject.add("data", dataArray);
					}
				}
			}
		}
		return userObject;
	}

}
