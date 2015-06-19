package test.java.com.inmobi.monetization.api.response;

import static org.junit.Assert.*;

import java.util.ArrayList;

import main.java.com.inmobi.monetization.api.response.ad.NativeResponse;
import main.java.com.inmobi.monetization.api.response.parser.JSONNativeResponseParser;

import org.junit.Test;

public class JSONResponseParserTest {

	@Test
	public void testInvalidResponse() {
		JSONNativeResponseParser parser = new JSONNativeResponseParser();
		ArrayList<NativeResponse> response = null;
		response = parser.fetchNativeAdsFromResponse(" ");
		assertEquals(0, response.size());
		response = parser.fetchNativeAdsFromResponse(null);
		assertEquals(0, response.size());
		response = parser.fetchNativeAdsFromResponse("This is a response");
		assertEquals(0, response.size());
	}

	@Test
	public void testInvalidParams() {

		JSONNativeResponseParser parser = new JSONNativeResponseParser();
		ArrayList<NativeResponse> response = null;
		String invalidJson = "{\"key1\" : 1, \"key2\":\"value2\"}";
		response = parser.fetchNativeAdsFromResponse(invalidJson);
		assertEquals(0, response.size());

		invalidJson = "{\"pubContent\":\"pubContent\",\"contextCode\":\"ContextCode\",\"namespace\":\"im_1154_\"}";
		response = parser.fetchNativeAdsFromResponse(invalidJson);
		assertEquals(0, response.size());

		// check if response returned is 0 if in case valid values are not
		// returned in string
		invalidJson = "{ \"ads\":[{\"a\":\"\",\"contextCode\":\"b\",\"namespace\":\"im_1154_\"}]}";
		response = parser.fetchNativeAdsFromResponse(invalidJson);
		assertEquals(0, response.size());
		invalidJson = "{ \"ads\":[{\"pubContent\":\"\",\"c\":\"b\",\"namespace\":\"im_1154_\"}]}";
		response = parser.fetchNativeAdsFromResponse(invalidJson);
		assertEquals(0, response.size());
		invalidJson = "{ \"ads\":[{\"pubContent\":\"   \",\"contextCode\":\"ctx\",\"ns\":\"im_1154_\"}]}";
		response = parser.fetchNativeAdsFromResponse(invalidJson);
		assertEquals(0, response.size());
		invalidJson = "{ \"ads\":[{\"pubContent\":\"pub\",\"contextCode\":\"\",\"ns\":\"im_1154_\"}]}";
		response = parser.fetchNativeAdsFromResponse(invalidJson);
		assertEquals(0, response.size());
		invalidJson = "{ \"ads\":[{\"pubContent\":\"pub\",\"contextCode\":\"  \",\"ns\":\"im_1154_\"}]}";
		response = parser.fetchNativeAdsFromResponse(invalidJson);
		assertEquals(0, response.size());
		invalidJson = "{ \"ads\":[{\"pubContent\":\"pub\",\"contextCode\":\"ctx\",\"ns\":\"\"}]}";
		response = parser.fetchNativeAdsFromResponse(invalidJson);
		assertEquals(0, response.size());
		invalidJson = "{ \"ads\":[{\"pubContent\":\"pub\",\"contextCode\":\"ctx\",\"ns\":\"  \"}]}";
		response = parser.fetchNativeAdsFromResponse(invalidJson);
		assertEquals(0, response.size());
		invalidJson = "{ \"ads\":[{\"pubContent\":\"pub\",\"contextCode\":\"ctx\",\"namespace\":\" \"}]}";
		response = parser.fetchNativeAdsFromResponse(invalidJson);
		assertEquals(0, response.size());
	}

	@Test
	public void testValidParams() {
		JSONNativeResponseParser parser = new JSONNativeResponseParser();
		ArrayList<NativeResponse> response = null;
		// valid 1 response
		String invalidJson = "{ \"ads\":[{\"pubContent\":\"pub\",\"contextCode\":\"ctx\",\"namespace\":\"ns\"}]}";
		response = parser.fetchNativeAdsFromResponse(invalidJson);
		assertEquals(1, response.size());

		// valid 2 response
		invalidJson = "{ \"ads\":[{\"pubContent\":\"pub\",\"contextCode\":\"ctx\",\"namespace\":\"ns\"},{\"pubContent\":\"pub1\",\"contextCode\":\"ctx1\",\"namespace\":\"ns1\"}]}";
		response = parser.fetchNativeAdsFromResponse(invalidJson);
		assertEquals(2, response.size());

		// valid 3 response
		invalidJson = "{ \"ads\":[{\"pubContent\":\"pub\",\"contextCode\":\"ctx\",\"namespace\":\"ns\"},{\"pubContent\":\"pub1\",\"contextCode\":\"ctx1\",\"namespace\":\"ns1\"},"
				+ "{\"pubContent\":\"pub2\",\"contextCode\":\"ctx2\",\"namespace\":\"ns2\"}]}";
		response = parser.fetchNativeAdsFromResponse(invalidJson);
		assertEquals(3, response.size());

		// 2 valid,1 invalid response
		invalidJson = "{ \"ads\":[{\"pubContent\":\"pub\",\"contextCode\":\"ctx\",\"namespace\":\"ns\"},{\"pubContent\":\"pub1\",\"contextCode\":\"ctx1\",\"namespace\":\"ns1\"},"
				+ "{\"pubContent\":\"\",\"contextCode\":\"ctx2\",\"namespace\":\"ns2\"}]}";
		response = parser.fetchNativeAdsFromResponse(invalidJson);
		assertEquals(2, response.size());
		// 1 valid,2 invalid response
		invalidJson = "{ \"ads\":[{\"pubContent\":\"pub\",\"contextCode\":\"ctx\",\"namespace\":\"ns\"},{\"pubContent\":\"pub1\",\"contextCode\":\"  \",\"namespace\":\"ns1\"},"
				+ "{\"pubContent\":\"\",\"contextCode\":\"ctx2\",\"namespace\":\"ns2\"}]}";
		response = parser.fetchNativeAdsFromResponse(invalidJson);
		assertEquals(1, response.size());
	}
	@Test
	public void testNativeResponseObject() {
		NativeResponse response = new NativeResponse();
		assertFalse(response.isValid());
		
		response.ns = "  "; response.contextCode = ""; response.pubContent = null;
		assertFalse(response.isValid());
		response.ns = "ns"; response.contextCode = "ctx"; response.pubContent = null;
		assertFalse(response.isValid());
		response.ns = "ns"; response.contextCode = "ctx"; response.pubContent = "pc";
		assertTrue(response.isValid());
	}
	@Test
	public void testNativeJSONResponseObject() {
		NativeResponse response = new NativeResponse();
		JSONNativeResponseParser parser = new JSONNativeResponseParser();
		ArrayList<NativeResponse> ads = null;
		response.ns = "ns"; response.contextCode = "ctx"; response.pubContent = "pc";
		String jsonResponse = "{\"ads\":[" 
		+ response.toString() 
		+ "]}";
		System.out.println(jsonResponse);
		ads = parser.fetchNativeAdsFromResponse(jsonResponse);
		if(ads.size() == 1) {
			NativeResponse r = ads.get(0);
			System.out.println(response.toString());
			System.out.println(r.toString());
			assertEquals(response.ns, r.ns);
			assertEquals(response.contextCode, r.contextCode);
			assertEquals(response.pubContent, r.pubContent);
		} else {
			fail("Expected ads size should be 1, returned size:" + ads.size());
		}
	}

}
