package test.java.com.inmobi.monetization.ads;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;

import java.util.ArrayList;

import main.java.com.inmobi.monetization.ads.Native;
import main.java.com.inmobi.monetization.api.request.ad.Slot;
import main.java.com.inmobi.monetization.api.request.ad.Device;
import main.java.com.inmobi.monetization.api.request.ad.Impression;
import main.java.com.inmobi.monetization.api.request.ad.Property;
import main.java.com.inmobi.monetization.api.request.ad.Request;
import main.java.com.inmobi.monetization.api.response.ad.NativeResponse;

import org.junit.Test;

public class NativeTest {

	@Test
	public void test() {
		Native nativeAd = new Native();
		Request request = new Request();
		ArrayList<NativeResponse> ads;
		
		ads = nativeAd.loadRequest(request);
		assertNull(ads);
		
		nativeAd = new Native();
		ads = nativeAd.loadRequest(request);
		assertNull(ads);
		
		ads = nativeAd.loadRequest(request);
		assertNull(ads);
		
		Property property = null;
		property = new Property("4028cbff3b187e27013b4d4a431d08f2");
		request.setProperty(property);
		
		//device 
		Device device = new Device("87.84.221.50",
				"Mozilla/5.0 (iPhone; CPU iPhone OS 7_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10B350");
		request.setDevice(device);
		
		ads = nativeAd.loadRequest(request);
		assertEquals(0,ads.size());
		
		request.setImpression(new Impression(null));
		ads = nativeAd.loadRequest(request);
		assertEquals(0,ads.size());
		
		request.getImpression().setSlot(new Slot(15, null));
		ads = nativeAd.loadRequest(request);
		assertEquals(0,ads.size());
	}

}
