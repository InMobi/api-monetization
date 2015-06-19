package main.java.com.inmobi.monetization.api.response.parser;

import java.lang.reflect.Type;
import java.util.ArrayList;

import main.java.com.inmobi.monetization.api.response.ad.NativeResponse;
import main.java.com.inmobi.monetization.api.utils.InternalUtil;
import main.java.com.inmobi.monetization.api.utils.LogLevel;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;

/**
 * This class can be used to obtain an ArrayList of NativeResponse objects, from
 * the raw response(as String), obtained from the InMobi API 2.0 Server
 * response.
 * 
 * @author rishabhchowdhary
 * 
 */
public class JSONNativeResponseParser {

	private final Gson GSON = new Gson();

	/**
	 * This function converts the String response to NativeResponse
	 * objects.</br>
	 * 
	 * <p>
	 * <b>Note:</b>
	 * </p>
	 * If the server returned a no-fill, or there was a parsing error, this
	 * function would return an empty arraylist.
	 * 
	 * @param response
	 *            The String response as obtained from InMobi ad server.
	 * @return ArrayList of NativeResponse objects.
	 */
	public ArrayList<NativeResponse> fetchNativeAdsFromResponse(String response) {
		ArrayList<NativeResponse> ads = new ArrayList<NativeResponse>();
		if (!InternalUtil.isBlank(response)) {
			try {
				JsonObject rootObject = toNativeResponseJson(response);
				if (rootObject != null) {
					JsonArray adsArray = (JsonArray) rootObject.get("ads");
					for (JsonElement ad : adsArray) {
						NativeResponse nativeAd = new NativeResponse();
						JsonObject obj = (JsonObject) ad.getAsJsonObject();
						nativeAd.contextCode = obj.get("contextCode")
								.getAsString().trim();
						nativeAd.ns = obj.get("namespace").getAsString().trim();
						nativeAd.pubContent = obj.get("pubContent")
								.getAsString().trim();
						if (nativeAd.isValid())
							ads.add(nativeAd);
					}
				}
			} catch (Exception e) {
				 InternalUtil.Log(e.getStackTrace().toString(), LogLevel.DEBUG);
			}

		}
		return ads;
	}

	private JsonObject toNativeResponseJson(String response) {

		return GSON.fromJson(response,
				JSONNativeResponseParser.getNativeRootObjectClassToken());
	}

	private static Type getNativeRootObjectClassToken() {
		return new TypeToken<JsonObject>() {
		}.getType();
	}
}
