package test.java.com.inmobi.monetization.api.net;

import static org.junit.Assert.*;

import java.util.HashMap;

import main.java.com.inmobi.monetization.api.net.JSONPayloadCreator;
import main.java.com.inmobi.monetization.api.request.ad.Slot;
import main.java.com.inmobi.monetization.api.request.ad.Data;
import main.java.com.inmobi.monetization.api.request.ad.Device;
import main.java.com.inmobi.monetization.api.request.ad.Impression;
import main.java.com.inmobi.monetization.api.request.ad.Property;
import main.java.com.inmobi.monetization.api.request.ad.Request;
import main.java.com.inmobi.monetization.api.request.ad.User;
import main.java.com.inmobi.monetization.api.request.ad.UserSegment;
import main.java.com.inmobi.monetization.api.request.enums.AdRequest;
import main.java.com.inmobi.monetization.api.request.enums.Gender;

import org.json.JSONObject;
import org.junit.Test;

public class JSONPayloadCreatorTest {

	@Test
	public void testInvalidValues() {
		JSONObject payload = null;
		Request request = new Request();
		payload = JSONPayloadCreator.generateInMobiAdRequestPayload(null);
		assertNull(payload);
		payload = JSONPayloadCreator.generateInMobiAdRequestPayload(null);
		assertNull(payload);
		payload = JSONPayloadCreator.generateInMobiAdRequestPayload(null);
		assertNull(payload);
		payload = JSONPayloadCreator.generateInMobiAdRequestPayload(request);
		assertNull(payload);
		payload = JSONPayloadCreator.generateInMobiAdRequestPayload(request);
		assertNull(payload);
		payload = JSONPayloadCreator.generateInMobiAdRequestPayload(request);
		assertNull(payload);
		request.setRequestType(AdRequest.BANNER);
		payload = JSONPayloadCreator.generateInMobiAdRequestPayload(request);
		assertNull(payload);
		
		request.setRequestType(AdRequest.INTERSTITIAL);
		payload = JSONPayloadCreator.generateInMobiAdRequestPayload(request);
		assertNull(payload);
		
		request.setRequestType(AdRequest.NATIVE);
		payload = JSONPayloadCreator.generateInMobiAdRequestPayload(request);
		assertNull(payload);
	}
	@Test
	public void testInvalidRequestParam() {
		JSONObject payload = null;
		Request request = new Request();
		request.setProperty(new Property());
		payload = JSONPayloadCreator.generateInMobiAdRequestPayload(request);
		assertNull(payload);
		payload = JSONPayloadCreator.generateInMobiAdRequestPayload(request);
		assertNull(payload);
		payload = JSONPayloadCreator.generateInMobiAdRequestPayload(request);
		assertNull(payload);
		request.setProperty(new Property("sdf"));
		payload = JSONPayloadCreator.generateInMobiAdRequestPayload(request);
		assertNull(payload);
		payload = JSONPayloadCreator.generateInMobiAdRequestPayload(request);
		assertNull(payload);
		payload = JSONPayloadCreator.generateInMobiAdRequestPayload(request);
		assertNull(payload);
		request.setDevice(new Device(null,null));
		payload = JSONPayloadCreator.generateInMobiAdRequestPayload(request);
		assertNull(payload);
		payload = JSONPayloadCreator.generateInMobiAdRequestPayload(request);
		assertNull(payload);
		payload = JSONPayloadCreator.generateInMobiAdRequestPayload(request);
		assertNull(payload);
		request.setDevice(new Device("carrier", null));
		payload = JSONPayloadCreator.generateInMobiAdRequestPayload(request);
		assertNull(payload);
		payload = JSONPayloadCreator.generateInMobiAdRequestPayload(request);
		assertNull(payload);
		request.setRequestType(AdRequest.NATIVE);
		payload = JSONPayloadCreator.generateInMobiAdRequestPayload(request);
		assertNotNull(payload); //native doesn't require imp 
		
		request.setImpression(new Impression());
		request.setRequestType(AdRequest.NONE);
		payload = JSONPayloadCreator.generateInMobiAdRequestPayload(request);
		assertNull(payload);
		payload = JSONPayloadCreator.generateInMobiAdRequestPayload(request);
		assertNull(payload);
		request.setRequestType(AdRequest.NATIVE);
		payload = JSONPayloadCreator.generateInMobiAdRequestPayload(request);
		assertNotNull(payload); //native doesn't require imp 
		
		request.setImpression(new Impression());
		request.setRequestType(AdRequest.INTERSTITIAL);
		payload = JSONPayloadCreator.generateInMobiAdRequestPayload(request);
		assertNotNull(payload);
		payload = JSONPayloadCreator.generateInMobiAdRequestPayload(request);
		assertNotNull(payload);
		payload = JSONPayloadCreator.generateInMobiAdRequestPayload(request);
		assertNotNull(payload); //native doesn't require imp 
		
		request.setUser(new User());
		payload = JSONPayloadCreator.generateInMobiAdRequestPayload(request);
		assertNotNull(payload);
		payload = JSONPayloadCreator.generateInMobiAdRequestPayload(request);
		assertNotNull(payload);
		payload = JSONPayloadCreator.generateInMobiAdRequestPayload(request);
		assertNotNull(payload); //native doesn't require imp 
		
		request.setUser(new User(1980, Gender.FEMALE, null));
		payload = JSONPayloadCreator.generateInMobiAdRequestPayload(request);
		assertNotNull(payload);
		payload = JSONPayloadCreator.generateInMobiAdRequestPayload(request);
		assertNotNull(payload);
		payload = JSONPayloadCreator.generateInMobiAdRequestPayload(request);
		assertNotNull(payload); //native doesn't require imp 
		
		UserSegment seg = new UserSegment();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("key1", "value1");
		seg.setUserSegmentArray(map);
		request.getUser()
				.setData(new Data("ID", "temp", seg));
		payload = JSONPayloadCreator.generateInMobiAdRequestPayload(request);
		assertNotNull(payload);
		payload = JSONPayloadCreator.generateInMobiAdRequestPayload(request);
		assertNotNull(payload);
		payload = JSONPayloadCreator.generateInMobiAdRequestPayload(request);
		assertNotNull(payload);
	}

}
