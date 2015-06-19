package test.java.com.inmobi.monetization.api.net;

import static org.junit.Assert.*;

import java.io.InputStream;
import java.util.HashMap;

import main.java.com.inmobi.monetization.api.net.RequestResponseManager;
import main.java.com.inmobi.monetization.api.request.ad.Slot;
import main.java.com.inmobi.monetization.api.request.ad.Data;
import main.java.com.inmobi.monetization.api.request.ad.Device;
import main.java.com.inmobi.monetization.api.request.ad.Geo;
import main.java.com.inmobi.monetization.api.request.ad.Impression;
import main.java.com.inmobi.monetization.api.request.ad.Property;
import main.java.com.inmobi.monetization.api.request.ad.Request;
import main.java.com.inmobi.monetization.api.request.ad.User;
import main.java.com.inmobi.monetization.api.request.ad.UserSegment;
import main.java.com.inmobi.monetization.api.request.enums.AdRequest;
import main.java.com.inmobi.monetization.api.request.enums.Gender;

import org.junit.Test;

public class RequestResponseManagerTest {

	@Test
	public void testInvalidRequestResponse() {
		RequestResponseManager mgr = new RequestResponseManager();
		String response = mgr.fetchAdResponseAsString(null);
		assertNull(response);
		response = mgr.fetchAdResponseAsString(null);
		assertNull(response);
		response = mgr
				.fetchAdResponseAsString(null);
		assertNull(response);

		InputStream is = mgr
				.fetchAdResponseAsStream(null);
		assertNull(is);
		is = mgr.fetchAdResponseAsStream(null);
		assertNull(is);
		is = mgr.fetchAdResponseAsStream(null);
		assertNull(is);

		response = mgr.fetchAdResponseAsString(new Request());
		assertNull(response);
		response = mgr.fetchAdResponseAsString(new Request());
		assertNull(response);
		response = mgr.fetchAdResponseAsString(new Request());
		assertNull(response);

		is = mgr.fetchAdResponseAsStream(new Request());
		assertNull(is);
		is = mgr.fetchAdResponseAsStream(new Request());
		assertNull(is);
		is = mgr.fetchAdResponseAsStream(new Request());
		assertNull(is);

	}

	@Test
	public void testValidRequestObjectWithInvalidParams() {
		RequestResponseManager mgr = new RequestResponseManager();
		Property prop = new Property("sdf");
		Impression imp = new Impression(null);
		Device device = new Device("carrier ip", null);
		Request request = new Request(imp, null, prop, device);

		InputStream is = mgr.fetchAdResponseAsStream(request);
		assertNull(is);
		is = mgr.fetchAdResponseAsStream(request);
		assertNull(is);
		is = mgr.fetchAdResponseAsStream(request);
		assertNull(is);
		String response = mgr.fetchAdResponseAsString(request);
		assertNull(response);
		response = mgr.fetchAdResponseAsString(request);
		assertNull(response);
		response = mgr.fetchAdResponseAsString(request);
		assertNull(response);

		request.setUser(new User(1980, Gender.MALE, null));
		response = mgr.fetchAdResponseAsString(request);
		assertNull(response);
		response = mgr.fetchAdResponseAsString(request);
		assertNull(response);
		response = mgr.fetchAdResponseAsString(request);
		assertNull(response);
		is = mgr.fetchAdResponseAsStream(request);
		assertNull(is);
		is = mgr.fetchAdResponseAsStream(request);
		assertNull(is);
		is = mgr.fetchAdResponseAsStream(request);
		assertNull(is);
		device.setGeo(new Geo(-37, 122, 1));
		imp.getSlot().setPosition("top");
		UserSegment seg = new UserSegment();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("key1", "value1");
		seg.setUserSegmentArray(map);
		request.getUser()
				.setData(new Data("ID", "temp", seg));

		response = mgr.fetchAdResponseAsString(request);
		assertNull(response);
		response = mgr.fetchAdResponseAsString(request);
		assertNull(response);
		response = mgr.fetchAdResponseAsString(request);
		assertNull(response);
		is = mgr.fetchAdResponseAsStream(request);
		assertNull(is);
		is = mgr.fetchAdResponseAsStream(request);
		assertNull(is);
		is = mgr.fetchAdResponseAsStream(request);
		assertNull(is);
	}

	@Test
	public void testValidRequestResponseWithValidParams() {
		RequestResponseManager mgr = new RequestResponseManager();
		Property prop = new Property("4028cbff3b187e27013b4d4a431d08f2");
		Impression imp = new Impression(null);
		Device device = new Device(
				"6.0.0.0",null);
		Request request = new Request(imp, null, prop, device);
		request.setRequestType(AdRequest.BANNER);
		String response = mgr.fetchAdResponseAsString(request);
		assertNotNull(response);
		request.setRequestType(AdRequest.INTERSTITIAL);
		response = mgr.fetchAdResponseAsString(request);
		assertNotNull(response);
		request.setRequestType(AdRequest.NATIVE);
		response = mgr.fetchAdResponseAsString(request);
		assertNotNull(response);
		
		InputStream is = mgr.fetchAdResponseAsStream(request);
		assertNotNull(is);
		is = mgr.fetchAdResponseAsStream(request);
		assertNotNull(is);
		is = mgr.fetchAdResponseAsStream(request);
		assertNotNull(is);
		
	}

}
