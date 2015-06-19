package main.java.com.inmobi.monetization.api.response.ad;

import main.java.com.inmobi.monetization.api.request.utils.Validator;
import main.java.com.inmobi.monetization.api.utils.InternalUtil;

import org.apache.commons.codec.binary.Base64;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;
/**
 * This class is used to construct Native response as a plain Java object.
 * @author rishabhchowdhary
 *
 */
public class NativeResponse extends AdResponse implements Validator {

	/**
	 * The 'namespace' parameter associated with this native ad unit. Use this
	 * String value in the client side code to trigger javascript function
	 * callbacks in the WebView.
	 */
	public String ns;
	/**
	 * The html/javascript code, which is to be executed in a hidden WebView on
	 * the client side. Please note that this code doesn't perform any rendering
	 * of the Native ad itself(<i>that responsibility is yours</i>) but this
	 * code must be used to track impression/clicks from the html/js. <br/>
	 * <b>Refer:</b> <br/>
	 * iOS: https://github.com/InMobi/iOS-Native-Samplecode-InMobi/ <br/>
	 * Android: https://github.com/InMobi/android-Native-Samplecode-InMobi/ <br/>
	 * examples to understand triggering of InMobi impression/clicks.
	 * 
	 * @warning <b>Please do not tamper with this String, and load it as it is
	 *          on the client side. Tampering with the String to scrape out any
	 *          specific html/javascript components may result in incorrect
	 *          results on our portal, or may also lead to your site being
	 *          marked as invalid.</b>
	 */
	public String contextCode;

	/**
	 * The Base64 encoded String, which contains the native metadata info. This
	 * info is the same as the "template" created on the InMobi dashboard,
	 * containing the K-V pair info of fields such as "title", "subtitle",
	 * "icon", "screenshots" etc.
	 */
	public String pubContent;

	@Override
	public String toString() {
		return "{\"pubContent\"" + ":" + "\"" + pubContent + "\"" + ","
				+ "\"contextCode\"" + ":" + "\"" + contextCode + "\"" + ","
				+ "\"namespace\"" + ":" + "\"" + ns + "\"" + "}";
	}

	/**
	 * Use this method to check if this object has all the required parameters
	 * present. If this method returns false, the object generated after JSON
	 * parsing would be discarded.
	 * 
	 * @return True, If the mandatory params are present.False, otherwise.
	 */
	public boolean isValid() {
		boolean isValid = false;
		if (!InternalUtil.isBlank(contextCode) && !InternalUtil.isBlank(ns)
				&& !InternalUtil.isBlank(pubContent)) {
			isValid = true;
		}
		return isValid;
	}

	/**
	 * Use this method to convert the Base64 encoded pubContent to a JsonObject.
	 * You may use jsonObject.get("<key-name>") to obtain the required metadata
	 * value.
	 * 
	 * @return
	 */
	public JsonObject convertPubContentToJsonObject() {
		JsonObject jsonObject = null;
		if (pubContent != null) {
			byte[] bytes = Base64.decodeBase64(pubContent);
			String jsonString = new String(bytes);
			jsonObject = (new Gson()).fromJson(jsonString,
					new TypeToken<JsonObject>() {
					}.getType());
		}

		return jsonObject;
	}

}
