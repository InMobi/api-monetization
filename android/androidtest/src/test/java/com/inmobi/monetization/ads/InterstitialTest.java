package test.java.com.inmobi.monetization.ads;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;

import java.util.ArrayList;

import main.java.com.inmobi.monetization.ads.Interstitial;
import main.java.com.inmobi.monetization.api.request.ad.Slot;
import main.java.com.inmobi.monetization.api.request.ad.Device;
import main.java.com.inmobi.monetization.api.request.ad.Impression;
import main.java.com.inmobi.monetization.api.request.ad.Property;
import main.java.com.inmobi.monetization.api.request.ad.Request;
import main.java.com.inmobi.monetization.api.response.ad.BannerResponse;

import org.junit.Test;

public class InterstitialTest {

	@Test
	public void test() {
		Interstitial interstitial = new Interstitial();
		Request request = new Request();
		ArrayList<BannerResponse> ads;
		
		ads = interstitial.loadRequest(request);
		assertNull(ads);
		
		interstitial = new Interstitial();
		ads = interstitial.loadRequest(request);
		assertNull(ads);
		
		ads = interstitial.loadRequest(request);
		assertNull(ads);
		
		Property property = null;
		property = new Property("4028cbff3b187e27013b4d4a431d08f2");
		request.setProperty(property);
		
		//device 
		Device device = new Device("87.84.221.50",null);
		request.setDevice(device);
		
		ads = interstitial.loadRequest(request);
		assertNull(ads);
		
		request.setImpression(new Impression(null));
		ads = interstitial.loadRequest(request);
		assertNull(ads);
		
		request.getImpression().setSlot(new Slot(14, null));
		ads = interstitial.loadRequest(request);
		assertEquals(0,ads.size());
	}

}
