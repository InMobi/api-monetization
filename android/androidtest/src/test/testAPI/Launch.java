package test.testAPI;

import java.util.ArrayList;

import main.java.com.inmobi.monetization.ads.AdFormat;
import main.java.com.inmobi.monetization.ads.Banner;
import main.java.com.inmobi.monetization.ads.Interstitial;
import main.java.com.inmobi.monetization.ads.Native;
import main.java.com.inmobi.monetization.ads.listener.AdFormatListener;
import main.java.com.inmobi.monetization.api.net.ErrorCode;
import main.java.com.inmobi.monetization.api.request.ad.Data;
import main.java.com.inmobi.monetization.api.request.ad.Device;
import main.java.com.inmobi.monetization.api.request.ad.Impression;
import main.java.com.inmobi.monetization.api.request.ad.Property;
import main.java.com.inmobi.monetization.api.request.ad.Request;
import main.java.com.inmobi.monetization.api.request.ad.Slot;
import main.java.com.inmobi.monetization.api.request.ad.User;
import main.java.com.inmobi.monetization.api.request.enums.Gender;
import main.java.com.inmobi.monetization.api.response.ad.AdResponse;
import main.java.com.inmobi.monetization.api.response.ad.BannerResponse;
import main.java.com.inmobi.monetization.api.response.ad.NativeResponse;

public class Launch {

	public static void main(String args[]) {
		System.out.println("in launch main method");
		//RequestResponseManager mgr = new RequestResponseManager();
		Request request = new Request();
		//property 
		Property property = null;
		property = new Property("YOUR_PROPERTY_ID");
		request.setProperty(property);
		
		//device 
		Device device = new Device("CARRIER_IP",null);
		request.setDevice(device);
		
		//impression 
		Impression imp = new Impression(new Slot(15,"top"));
		request.setImpression(imp);
		
		//user 
		
		User user = new User(1980,Gender.MALE,new Data("1", "Test provider", null));
		request.setUser(user);
		
		Native nativeAd = new Native();
		
		Banner banner = new Banner();
		
		Interstitial interstitial = new Interstitial();
		ArrayList<BannerResponse> ads1 = banner.loadRequest(request);
		for(BannerResponse b : ads1) {
			//b.ad
		}
		//ArrayList<BannerResponse> ads = interstitial.loadSyncInterstitialAd();
//		for (BannerResponse b : ads) {
//			System.out.println(b.toString());
//		}
		//ArrayList<NativeResponse> ads = nativeAd.loadSyncRequest(request);
		AdFormatListener listener = new AdFormatListener() {
			

			@Override
			public void onSuccess(AdFormat adFormat,
					ArrayList<? extends AdResponse> response) {
				// TODO Auto-generated method stub
				System.out.println("adformat:" + adFormat.toString() + "\tresponse:" + response.toString());
			}

			@Override
			public void onFailure(AdFormat adFormat, ErrorCode error) {
				// TODO Auto-generated method stub
				
			}
		};
		//nativeAd.loadSyncRequest(request, listener);
		

		
		//nativeAd.loadAsyncNativeAd();
		//nativeAd.loadAsyncNativeAd();
		//nativeAd.loadAsyncNativeAd();
		System.out.println("here first!");
		
		
	}
}
