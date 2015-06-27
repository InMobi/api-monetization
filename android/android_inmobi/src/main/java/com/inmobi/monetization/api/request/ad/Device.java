package main.java.com.inmobi.monetization.api.request.ad;

import java.io.IOException;

import com.google.android.gms.ads.identifier.AdvertisingIdClient;
import com.google.android.gms.ads.identifier.AdvertisingIdClient.Info;
import com.google.android.gms.common.GooglePlayServicesNotAvailableException;

import main.java.com.inmobi.monetization.api.request.utils.Validator;
import main.java.com.inmobi.monetization.api.utils.InternalUtil;
import main.java.com.inmobi.monetization.api.utils.LogLevel;
import android.content.Context;
import android.webkit.WebView;

/**
 * The device  provides rmation pertaining to a device, including its
 * hardware, platform, location, and carrier.</br>
 * <p>
 * <b>Note:</b>
 * </p>
 * <b>1.</b> The User-Agent, and carrierIP are mandatory rmation, without
 * which a request will always be terminated.</br> <b>2.</b> The Carrier IP must
 * be a valid Mobile Country code, and <b>not</b> of your
 * local-wifi/LAN/WAN.</br> Please refer for additional details:
 * http://en.wikipedia.org/wiki/Mobile_country_code</br> For eg: 10.14.x.y, or
 * 192.168.x.y are internal IPs, and hence passing them would terminate the
 * request.</br> <b>3.</b>The User Agent string passed should be a valid,
 * WebView User Agent of the device, for which ads are being requested.
 * 
 * @author rishabhchowdhary
 * 
 */
public class Device implements Validator {

	private String carrierIP = null;
	private String userAgent = null;
	private String gpId = null;
	private Geo geo = null;

	/**
	 * 
	 * @return The String value containing the carrier IP.
	 */
	public String getCarrierIP() {
		return carrierIP;
	}

	/**
	 * The String value of the carrier IP, for which the ad thus obtained would
	 * be send.
	 * 
	 * @param carrierIP
	 *            Must not be empty.
	 */
	public void setCarrierIP(String carrierIP) {
		if (!InternalUtil.isBlank(carrierIP)) {
			this.carrierIP = carrierIP;
		}

	}

	/**
	 * 
	 * 
	 * @return The User-Agent value as set.
	 */
	public String getUserAgent() {
		return userAgent;
	}
	protected void setUserAgent(String ua) {
		this.userAgent = ua;
	}
	/**
	 * 
	 * @return The Google Play Identifier as set.
	 */
	public String getGpId() {
		return gpId;
	}

	/**
	 * 
	 * @param gpId
	 *            The Google Play Advertising Identifier, as obtained from your
	 *            device.
	 */
	protected void setGpId(String gpId) {
		if (!InternalUtil.isBlank(gpId)) {
			this.gpId = gpId;
		}

	}

	/**
	 * 
	 * @return The Geo, as set for this instance.
	 */
	public Geo getGeo() {
		return geo;
	}

	/**
	 * 
	 * @param geo
	 *            The Geo, having the accurate geo coordinate .</br>
	 *            <p>
	 *            <b>Note:</b>
	 *            </p>
	 *            Passing the accurate values increases targeting accuracy.
	 */
	public void setGeo(Geo geo) {
		this.geo = geo;
	}

	public Device(String carrierIP,final Context ctx) {
		setCarrierIP(carrierIP);
		if(ctx != null) {
			setUserAgent(new WebView(ctx).getSettings().getUserAgentString());
			(new Thread() {
				public void run() {
					setGpId(getIdThread(ctx));
				}
			}).start();
		}
	}
	public  String getIdThread(Context ctx) {

		Info adInfo = null;
		String ID = null;
		try {
			adInfo = AdvertisingIdClient.getAdvertisingIdInfo(ctx);
			ID = adInfo.getId();
		} catch (IOException e) {
			// Unrecoverable error connecting to Google Play services (e.g.,
			// the old version of the service doesn't support getting
			// AdvertisingId).

		} catch (GooglePlayServicesNotAvailableException e) {
			// Google Play services is not available entirely.
		} catch (Exception e) {
			e.printStackTrace();
		}
		// final String id = adInfo.getId();
		// final boolean isLAT = adInfo.isLimitAdTrackingEnabled();
		return ID;
	}

	/**
	 * Use this method to check if this Object has all the required parameters
	 * present, to be used to construct a JSON request. The required parameters
	 * would be specific to an ad-format.
	 * 
	 * @return If the mandatory params are present, then true, otherwise false.
	 */
	public boolean isValid() {
		boolean isValid = false;
		if (carrierIP != null && userAgent != null) {
			isValid = true;
		} else {
			if (carrierIP == null) {
				InternalUtil.Log("Carrier IP is mandatory in the request",LogLevel.ERROR);
			}
			if (userAgent == null) {
				InternalUtil.Log("Valid Mobile User Agent is mandatory in the request",LogLevel.ERROR);
			}
		}

		return isValid;
	}
}
