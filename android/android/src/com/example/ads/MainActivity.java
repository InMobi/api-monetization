
package com.example.ads;


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

import com.example.ads.R;

import android.app.Activity;
import android.os.Bundle;
import android.util.Log;

public class MainActivity extends Activity {

	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		
		Request request = new Request();
		//property 
		Property property = null;
		property = new Property("YOUR_PROPERTY_ID");
		request.setProperty(property);
		
		//device 
		Device device = new Device("DEVICE_CARRIER_IP",this);
		request.setDevice(device);
		
		//impression 
		Impression imp = new Impression(new Slot(14,"top"));
		request.setImpression(imp);
		
		//user 
		
		User user = new User(1980,Gender.MALE,new Data("1", "Test provider", null));
		request.setUser(user);
		
		final Native nativeAd = new Native();
		
		final Banner banner = new Banner();
		final Request r = request;
		final Interstitial interstitial = new Interstitial();
		(new Thread(){
			public void run() {
				//ArrayList<BannerResponse> ads1 = interstitial.loadRequest(r);
				ArrayList<NativeResponse> ads1 = nativeAd.loadRequest(r);
				for(NativeResponse br : ads1) {
					Log.d("","action name:" + br.contextCode);
					Log.d("","action type:" + br.pubContent);
					Log.d("","action cdata:" + br.ns);
				}
				
			}
		}).start();
		
	}
}
