package test.java.com.inmobi.monetization.ads;

import static org.junit.Assert.*;

import java.util.ArrayList;

import org.junit.Test;

import main.java.com.inmobi.monetization.ads.Banner;
import main.java.com.inmobi.monetization.api.request.ad.Device;
import main.java.com.inmobi.monetization.api.request.ad.Impression;
import main.java.com.inmobi.monetization.api.request.ad.Property;
import main.java.com.inmobi.monetization.api.request.ad.Request;
import main.java.com.inmobi.monetization.api.request.ad.Slot;
import main.java.com.inmobi.monetization.api.response.ad.BannerResponse;

public class BannerTest {

	@Test
	public void test() {
		Banner banner = new Banner();
		Request request = new Request();
		ArrayList<BannerResponse> ads;
		
		ads = banner.loadRequest(request);
		assertNull(ads);
		
		banner = new Banner();
		ads = banner.loadRequest(request);
		assertNull(ads);
		
		
		ads = banner.loadRequest(request);
		assertNull(ads);
		
		Property property = null;
		property = new Property("4028cbff3b187e27013b4d4a431d08f2");
		request.setProperty(property);
		
		//device 
		Device device = new Device("87.84.221.50",null);
		request.setDevice(device);
		
		ads = banner.loadRequest(request);
		assertNull(ads);
		
		request.setImpression(new Impression(null));
		ads = banner.loadRequest(request);
		assertNull(ads);
		
		
		request.getImpression().setSlot(null);
		ads = banner.loadRequest(request);
		assertNull(ads);
		
		request.getImpression().setSlot(new Slot(15, null));
		ads = banner.loadRequest(request);
		assertEquals(0, ads.size());
	}

}
