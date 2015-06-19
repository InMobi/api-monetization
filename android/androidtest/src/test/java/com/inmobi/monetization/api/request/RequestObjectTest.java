package test.java.com.inmobi.monetization.api.request;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;
import main.java.com.inmobi.monetization.api.request.ad.Data;
import main.java.com.inmobi.monetization.api.request.ad.Device;
import main.java.com.inmobi.monetization.api.request.ad.Geo;
import main.java.com.inmobi.monetization.api.request.ad.Impression;
import main.java.com.inmobi.monetization.api.request.ad.Property;
import main.java.com.inmobi.monetization.api.request.ad.Request;
import main.java.com.inmobi.monetization.api.request.ad.Slot;
import main.java.com.inmobi.monetization.api.request.ad.User;
import main.java.com.inmobi.monetization.api.request.ad.UserSegment;
import main.java.com.inmobi.monetization.api.request.enums.AdRequest;
import main.java.com.inmobi.monetization.api.request.enums.Gender;

import org.junit.Test;

public class RequestObjectTest {

	@Test
	public void test() {
		// fail("Not yet implemented");
	}

	@Test
	public void testBanner() {
		Slot bannerObj = new Slot();
		// fail("this is failed");
		// check for adSize
		int adSize = -1;
		bannerObj.setAdSize(adSize);
		assertEquals(0, bannerObj.getAdSize()); // Ad Size < 0 shouldn't be
												// allowed

		adSize = 15; // default 320x50
		bannerObj.setAdSize(adSize);
		assertEquals(adSize, bannerObj.getAdSize()); // Ad Size > 0 should be
														// same

		// check for position
		String pos = "";
		bannerObj.setPosition(pos);
		assertNull("Blank position shouldn't be allowed",
				bannerObj.getPosition());

		pos = "   ";
		bannerObj.setPosition(pos);
		assertNull("Blank position shouldn't be allowed",
				bannerObj.getPosition());

		pos = "top";
		bannerObj.setPosition(pos);
		assertNotNull("Position set values do not match!" + "pos=" + pos
				+ "\tbannerObj.pos=" + bannerObj.getPosition(),
				bannerObj.getPosition());

		// constructor test cases
		adSize = -1;
		pos = "  ";
		bannerObj = new Slot(adSize, pos);
		assertEquals(0, bannerObj.getAdSize()); // Ad Size < 0 shouldn't be
												// allowed
		assertNull("Blank position shouldn't be allowed",
				bannerObj.getPosition());

		adSize = 5;
		pos = "bottom";
		bannerObj = new Slot(adSize, pos);
		assertEquals(adSize, bannerObj.getAdSize()); // Ad Size < 0 shouldn't be
														// allowed
		assertEquals(pos, bannerObj.getPosition()); // Ad Size < 0 shouldn't be

		// isValid method test cases
		bannerObj = new Slot(-1, "pos");
		assertFalse("adSize is  mandatory parameter for banner/int ad request",
				bannerObj.isValid());

		bannerObj = new Slot(15, " ");
		assertTrue(
				"Banner  is valid even if position passed is not valid string",
				bannerObj.isValid());

	}

	@Test
	public void testData() {
		Data dataObj = new Data();

		String iD = " ";
		String name = "";
		dataObj.setID(iD);
		dataObj.setName(name);
		assertNull("Blank ID shouldn't be allowed", dataObj.getID());
		assertNull("Blank name shouldn't be allowed", dataObj.getName());

		// test constructor
		dataObj = new Data(iD, name, null);
		assertNull("Blank ID shouldn't be allowed", dataObj.getID());
		assertNull("Blank name shouldn't be allowed", dataObj.getName());
		assertNull("Empty user  can be allowed",
				dataObj.getUserSegment());

		iD = "testId 123";
		name = "test name";
		UserSegment seg = new UserSegment();
		dataObj = new Data(iD, name, seg);
		assertEquals(iD, dataObj.getID());
		assertEquals(name, dataObj.getName());
		assertEquals(seg, dataObj.getUserSegment());

		// test is valid
		dataObj = new Data();
		assertTrue(dataObj.isValid());

		dataObj = new Data(iD, name, seg);
		assertTrue(dataObj.isValid());
	}

	@Test
	public void testDevice() {
		Device device = new Device(null,null);

		// ip
		String ip = "  ";
		device.setCarrierIP(ip);
		assertNull(device.getCarrierIP());
		ip = "ip";
		device.setCarrierIP(ip);
		assertEquals(ip, device.getCarrierIP());

		device = new Device(ip, null);
		assertEquals(ip, device.getCarrierIP());
		// geo
		device.setGeo(new Geo());
		assertNotNull(device.getGeo());

		device = new Device("", null);
		assertFalse(device.isValid());
		device = new Device("  ", null);
		assertFalse(device.isValid());
		device = new Device(null, null);
		assertFalse(device.isValid());
	}

	@Test
	public void testGeo() {
		Geo geo = new Geo();
		// test valid values
		float delta = 1;
		float lat, lon;
		int accu;
		assertEquals(Geo.NOT_VALID, geo.getLatitude(), delta);
		assertEquals(Geo.NOT_VALID, geo.getLongitude(), delta);
		assertEquals(Geo.NOT_VALID, geo.getAccuracy(), delta);

		lat = 92;
		geo.setLatitude(lat);
		assertNotEquals(lat, geo.getLatitude());
		lat = -92;
		geo.setLatitude(lat);
		assertNotEquals(lat, geo.getLatitude());
		lat = 12;
		geo.setLatitude(lat);
		assertEquals(lat, geo.getLatitude(), delta);
		lat = -12;
		geo.setLatitude(lat);
		assertEquals(lat, geo.getLatitude(), delta);

		lon = 183;
		geo.setLongitude(lon);
		assertNotEquals(lon, geo.getLongitude());
		lon = -183;
		geo.setLongitude(lon);
		assertNotEquals(lon, geo.getLongitude());
		lon = 120;
		geo.setLongitude(lon);
		assertEquals(lon, geo.getLongitude(), delta);
		lon = -120;
		geo.setLongitude(lon);
		assertEquals(lon, geo.getLongitude(), delta);

		accu = -2;
		geo.setAccuracy(accu);
		assertNotEquals(accu, geo.getAccuracy());
		accu = 2;
		geo.setAccuracy(accu);
		assertEquals(accu, geo.getAccuracy());

		lat = 12;
		lon = 114;
		accu = 50;
		geo = new Geo(lat, lon, accu);
		assertTrue(geo.isValid());

		lat = -12;
		lon = 114;
		accu = 50;
		geo = new Geo(lat, lon, accu);
		assertTrue(geo.isValid());
		lat = -12;
		lon = -114;
		accu = 50;
		geo = new Geo(lat, lon, accu);
		assertTrue(geo.isValid());
		lat = 12;
		lon = -114;
		accu = 50;
		geo = new Geo(lat, lon, accu);
		assertTrue(geo.isValid());

		lat = -112;
		lon = 114;
		accu = 50;
		geo = new Geo(lat, lon, accu);
		assertFalse(geo.isValid());
		lat = 112;
		lon = 114;
		accu = 50;
		geo = new Geo(lat, lon, accu);
		assertFalse(geo.isValid());
		lat = 12;
		lon = -183;
		accu = 50;
		geo = new Geo(lat, lon, accu);
		assertFalse(geo.isValid());
		lat = -12;
		lon = 183;
		accu = 50;
		geo = new Geo(lat, lon, accu);
		assertFalse(geo.isValid());
		lat = -12;
		lon = 114;
		accu = -50;
		geo = new Geo(lat, lon, accu);
		assertFalse(geo.isValid());

	}

	@Test
	public void testProperty() {
		Property prop = new Property();
		String property = "";
		prop.setPropertyId(property);
		assertNull(prop.getPropertyId());
		assertFalse(prop.isValid());

		property = "   ";
		prop.setPropertyId(property);
		assertNull(prop.getPropertyId());
		assertFalse(prop.isValid());

		property = "asdfasdfs";
		prop.setPropertyId(property);
		assertEquals(property, prop.getPropertyId());
		assertTrue(prop.isValid());

		prop = new Property("");
		assertNull(prop.getPropertyId());
		assertFalse(prop.isValid());

		prop = new Property("  ");
		assertNull(prop.getPropertyId());
		assertFalse(prop.isValid());

		prop = new Property(property);
		assertEquals(property, prop.getPropertyId());
		assertTrue(prop.isValid());
	}

	@Test
	public void testUserSegment() {
		UserSegment segment = new UserSegment();
		assertTrue(segment.isValid());

		segment.setUserSegmentArray(null);
		assertNull(segment.getUserSegmentArray());

	}

	@Test
	public void testUser() {
		User userObj = new User();
		int yob = -123;
		Gender gender = Gender.FEMALE;
		userObj.setYearOfBirth(yob);
		assertEquals(0, userObj.getYearOfBirth());
		yob = 1985;
		userObj.setYearOfBirth(yob);
		assertEquals(yob, userObj.getYearOfBirth());

		userObj.setGender(gender);
		assertEquals(gender, userObj.getGender());

		userObj.setData(new Data());
		assertNotNull(userObj.getData());

		yob = -123;
		gender = Gender.MALE;
		userObj = new User(yob, gender, null);
		assertEquals(0, userObj.getYearOfBirth());
		assertEquals(gender, userObj.getGender());

		assertTrue(userObj.isValid());
	}

	@Test
	public void testImpression() {
		Impression imp = new Impression();
		int no = -1;
		imp.setNoOfAds(no);
		assertNotEquals(no, imp.getNoOfAds());
		no = 5;
		imp.setNoOfAds(no);
		assertNotEquals(no, imp.getNoOfAds());
		no = 2;
		imp.setNoOfAds(no);
		assertEquals(no, imp.getNoOfAds());

		imp.setDisplayManager("  ");
		imp.setDisplayManagerVersion("  ");
		imp.setInterstitial(true);

		Slot banner = new Slot();
		imp.setSlot(banner);

		no = 3;
		boolean isInt = false;
		String display_mgr = "display_mgr";
		String display_mgr_ver = "display_mgr_ver";
		imp = new Impression(banner);
		assertEquals(no, imp.getNoOfAds());
		assertEquals(display_mgr, imp.getDisplayManager());
		assertEquals(display_mgr_ver, imp.getDisplayManagerVersion());
		assertEquals(isInt, imp.isInterstitial());

		// check isValid
		imp = new Impression(banner);
		assertFalse(imp.isValid());
	}

	@Test
	public void testRequest() {
		Request request = new Request();
		assertFalse(request.isValid());
		request = new Request(null, null, null, null);
		assertFalse(request.isValid());

		request.setProperty(new Property());
		assertFalse(request.isValid());

		request.setProperty(new Property("sdf"));
		assertFalse(request.isValid());

		request.setDevice(new Device("ca", null));
		request.setRequestType(AdRequest.BANNER);
		assertFalse(request.isValid());

		request.setImpression(new Impression());
		assertFalse(request.isValid());
	}
}
