package main.java.com.inmobi.monetization.ads;

import main.java.com.inmobi.monetization.api.request.enums.AdRequest;

/**
 * Publishers may use this class to request for Interstitial ads.
 * 
 * @note Interstitials are full screen ads.
 * @author rishabhchowdhary
 * 
 */
public class Interstitial extends Banner {


	public Interstitial() {
		requestType = AdRequest.INTERSTITIAL;
	}
}
