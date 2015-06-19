package test.java.com.inmobi.monetization.api.response;

import static org.junit.Assert.*;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import main.java.com.inmobi.monetization.api.response.ad.BannerResponse;
import main.java.com.inmobi.monetization.api.response.ad.BannerResponse.AdSize;
import main.java.com.inmobi.monetization.api.response.parser.SAXBannerResponseParser;

import org.junit.Test;

public class XMLResponseParserTest {

	private InputStream getISFromString(String s) {
		
		try {
			return new ByteArrayInputStream(s.getBytes("UTF-8"));
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	@Test
	public void testInvalidXMLResponse() {
		
		ArrayList<BannerResponse> ads;
		SAXBannerResponseParser parser = new SAXBannerResponseParser();
		ads = parser.fetchBannerAdsFromResponse(null, false);
		assertEquals(0, ads.size());
		ads = parser.fetchBannerAdsFromResponse(null, true);
		assertEquals(0, ads.size());
		
		//convert unsupported string to IS
		ads = parser.fetchBannerAdsFromResponse(getISFromString("  "), false);
		assertEquals(0, ads.size());
		
		ads = parser.fetchBannerAdsFromResponse(getISFromString("<Ads></Ads>"), false);
		assertEquals(0, ads.size());
		ads = parser.fetchBannerAdsFromResponse(getISFromString("<AdResponse><Ads><Ad></Ad></Ads></AdResponse>"), false);
		assertEquals(0, ads.size());
		ads = parser.fetchBannerAdsFromResponse(getISFromString("<AdResponse><Ads><Ad></Ad></Ads></AdResponse>"), false);
		assertEquals(0, ads.size());
		ads = parser.fetchBannerAdsFromResponse(getISFromString("<AdResponse><Ads><Ad></Ad></Ads>"), false);
		assertEquals(0, ads.size());
		ads = parser.fetchBannerAdsFromResponse(getISFromString("<AdResponse><Ads><Ad></Ad></AdResponse>"), false);
		assertEquals(0, ads.size());
		ads = parser.fetchBannerAdsFromResponse(getISFromString("<AdResponse><Ads><Ad></Ads></AdResponse>"), false);
		assertEquals(0, ads.size());
	}
	@Test
	public void testBannerResponse() {
		BannerResponse response = new BannerResponse();
		response.adsize = new AdSize(320, 50);
		response.CDATA = " ";
		response.adUrl = null;
		assertFalse(response.isValid());
		
		response = new BannerResponse();
		response.CDATA = "cdata";
		assertFalse(response.isValid());
		
		response = new BannerResponse();
		response.adsize = new AdSize(320, 50);
		assertFalse(response.isValid());
		
		response = new BannerResponse();
		response.adsize = new AdSize(-320, 50);
		assertFalse(response.isValid());
		response = new BannerResponse();
		response.adsize = new AdSize(320, -50);
		assertFalse(response.isValid());
		response = new BannerResponse();
		response.adsize = new AdSize(-320, -50);
		assertFalse(response.isValid());
		
		response = new BannerResponse();
		response.adsize = new AdSize(-320, 50);
		response.CDATA = "this is a response";
		assertFalse(response.isValid());
		response = new BannerResponse();
		response.adsize = new AdSize(-320, -50);
		response.CDATA = "this is a response";
		assertFalse(response.isValid());
		
		response = new BannerResponse();
		response.adsize = new AdSize(320, 50);
		response.CDATA = "this is a response";
		assertTrue(response.isValid());
	}
	@Test
	public void testValidXMLResponse() {
		BannerResponse response = new BannerResponse();
		ArrayList<BannerResponse> ads;
		SAXBannerResponseParser parser = new SAXBannerResponseParser();
		response.adsize = new AdSize(320, 50);
		response.actionName  = "web";
		response.actionType = 1;
		response.adUrl = "http://inmobi.com";
		response.CDATA = "this is a response";
		
		String xmlstr = response.toString();
		System.out.println(xmlstr);
		ads = parser.fetchBannerAdsFromResponse(getISFromString(xmlstr), false);
		if(ads.size() == 1) {
			BannerResponse r = ads.get(0);
			assertEquals(response.actionName, r.actionName);
			assertEquals(response.actionType, r.actionType);
			assertEquals(response.adUrl, r.adUrl);
			assertEquals(response.CDATA, r.CDATA);
			assertEquals(response.adsize.width, r.adsize.width);
			assertEquals(response.adsize.height, r.adsize.height);
		} else {
			fail("The size of response returned should be 1, instead got size:" + ads.size());
		}
	}

}
