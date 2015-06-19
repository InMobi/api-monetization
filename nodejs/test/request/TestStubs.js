//require_relative "../../com/inmobi/monetization/api/request/Stubs.rb"
var Request = require("../../com/inmobi/monetization/api/request/Request.js");
var Property = require("../../com/inmobi/monetization/api/request/ad/Property.js");
var Device = require("../../com/inmobi/monetization/api/request/ad/Device.js");
var Geo = require("../../com/inmobi/monetization/api/request/ad/Geo.js");
var Impression = require("../../com/inmobi/monetization/api/request/ad/Impression.js");
var Slot = require("../../com/inmobi/monetization/api/request/ad/Slot.js");
var test = require('unit.js');

describe('testStubs', function () {
	it('should correctly run the Property test cases', function () {
		prop = new Property(null);
		property = "";
		prop.propertyId = property;
		test.assert(property == prop.propertyId);
		test.assert(false == prop.isValid());

		property = "   ";
		prop.propertyId = property;
		test.assert(property == prop.propertyId);
		test.assert(false == prop.isValid());

		property = "asdfasdfs";
		prop.propertyId = property;
		test.assert(property == prop.propertyId);
		test.assert(true == prop.isValid());

		prop = new Property("");
		test.assert("" == prop.propertyId);
		test.assert(false == prop.isValid());

		prop = new Property("  ");
		test.assert("  " == prop.propertyId);
		test.assert(false == prop.isValid());

		prop = new Property(property);
		test.assert(property, prop.propertyId);
		test.assert(true == prop.isValid());
	});
	it('should correctly run the Impression test cases', function () {
		slot = new Slot(null,null);
		imp = new Impression(slot);

		test.assert(false == imp.isValid());

		slot = new Slot(15, "");
		imp.slot = slot;
		test.assert(true == imp.isValid());

		slot = new Slot(10, "top");
		imp.slot = slot;
		test.assert(true == imp.isValid());

		slot = new Slot(-10, "top");
		imp.slot = slot;
		test.assert(false == imp.isValid());
	});
	it('should correctly run the Slot test cases', function () {
		slotObj = new Slot(10,null);
		adSize = -1;
		slotObj.adSize = adSize;

		// adSize must be >= 1
		test.assert(false == slotObj.isValid()); 

		adSize = 15; 
		slotObj.adSize = adSize;
		test.assert(true == slotObj.isValid()); 
		test.assert(15,slotObj.adSize); 

		pos = "top";
		slotObj.position = pos;
		test.assert(pos,slotObj.position); 

		adSize = -1;
		pos = "  ";
		slotObj = new Slot(adSize,pos)
		test.assert(false ==  slotObj.isValid());

		adSize = 5;
		pos = "bottom";
		slotObj = new Slot(adSize,pos)
		test.assert(true ==  slotObj.isValid());

		adSize = 5;
		pos = "";
		slotObj = new Slot(adSize,pos)
		test.assert(true ==  slotObj.isValid());

		adSize = 5;
		pos = "   ";
		slotObj = new Slot(adSize,pos)
		test.assert(true ==  slotObj.isValid());

		adSize = 5;
		slotObj = new Slot(adSize,null)
		test.assert(true ==  slotObj.isValid());

		slotObj = new Slot("asdf",null)
		test.assert(false ==  slotObj.isValid());

		slotObj = new Slot(10,false)
		test.assert(true ==  slotObj.isValid());
	});
	it('should correctly run the Geo test cases', function () {
		// test valid values
  		geo = new Geo(0,0,0);

		lat = 92;
		geo.latitude = lat;
		test.assert(lat ==  geo.latitude);
		lat = -92;
		geo.latitude = lat;
		test.assert(lat ==  geo.latitude);
		lat = 12;
		geo.latitude = lat;
		test.assert(lat ==  geo.latitude);
		lat = -12;
		geo.latitude = lat;
		test.assert(lat ==  geo.latitude);

		lon = 183;
		geo.longitude = lon;
		test.assert(lon == geo.longitude);
		lon = -183;
		geo.longitude = lon;
		test.assert(lon == geo.longitude);
		lon = 120;
		geo.longitude = lon;
		test.assert(lon == geo.longitude);
		lon = -120;
		geo.longitude = lon;
		test.assert(lon == geo.longitude);

		accu = -2;
		geo.accuracy = accu;
		test.assert(accu ==  geo.accuracy);
		accu = 2;
		geo.accuracy = accu;
		test.assert(accu ==  geo.accuracy);

		lat = 12.37;
		lon = 114.11;
		accu = 50;
		geo = new Geo(lat,lon,accu);
		test.assert(true == geo.isValid());

		lat = -12.11;
		lon = 114.11;
		accu = 50;
		geo = new Geo(lat,lon,accu);
		test.assert(true == geo.isValid());
		lat = -12.11;
		lon = -114.37;
		accu = 50;
		geo = new Geo(lat,lon,accu);
		test.assert(true == geo.isValid());
		lat = 12.11;
		lon = -114.11;
		accu = 50;
		geo = new Geo(lat,lon,accu);
		test.assert(true == geo.isValid());

		lat = -112.11;
		lon = 114.12;
		accu = 50;
		geo = new Geo(lat,lon,accu);
		test.assert(false == geo.isValid());
		lat = 112.99;
		lon = 114.11;
		accu = 50;
		geo = new Geo(lat,lon,accu);
		test.assert(false == geo.isValid());
		lat = 12.37;
		lon = -183.11;
		accu = 50;
		geo = new Geo(lat,lon,accu);
		test.assert(false == geo.isValid());
		lat = -12.11;
		lon = 183.23;
		accu = 50;
		geo = new Geo(lat,lon,accu);
		test.assert(false == geo.isValid());
		lat = -12.11;
		lon = 114.12;
		accu = -50;
		geo = new Geo(lat,lon,accu);
		test.assert(false == geo.isValid());
	});
	it('should correctly run the Device test cases', function () {
		device = new Device();
		test.assert(false == device.isValid());

		// gpid
		gpid = "dsfsoadsdfasdfasdfsdfsd";
		device.gpid = gpid;
		test.assert(gpid == device.gpid);
		test.assert(false == device.isValid());
		// ida
		idfa = "asdfasdfasfsdfsdfsdfs";
		device.idfa = idfa;
		test.assert(idfa == device.idfa);	
		test.assert(false == device.isValid());
		// ua
		ua = "Mozilla/5.0 (iPhone; CPU iPhone OS 8_0 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A334 Safari/7534.48.3"
		device.useragent = ua;
		test.assert(ua == device.useragent);
		test.assert(false == device.isValid());

		// geo
		device.geo = new Geo(null,null,null);
		test.assert(false == device.isValid());
		// ip
		ip = "6.0.0.0";
		device.carrierIP =ip;
		test.assert(ip == device.carrierIP);

		test.assert(true == device.isValid());

		device = new Device();
		device.carrierIP = 15 //test Fixnum, non String value
		test.assert(false == device.isValid());
		
		device.carrierIP = ip;
		device.useragent = 15;
		test.assert(false == device.isValid());

		device.useragent = ua;
		test.assert(true == device.isValid());
	});
	
});

describe('testRequest', function () {
	it('should correctly run the Request test cases', function () {

		request = new Request();
		test.assert(false == request.isValid());
		request = new Request(null, null, null, null);
		test.assert(false == request.isValid());

		request.property = new Property(null);
		test.assert(false == request.isValid());

		request.property = new Property("sdf");
		test.assert(false == request.isValid());

		request.device = new Device();
		test.assert(false == request.isValid());

		device = new Device();
		device.useragent = "useragent";
		device.carrierIP = "carrierIP;"
		request.device = device;
		
		test.assert(false == request.isValid());

		request.impression = new Impression(null);
		test.assert(false == request.isValid());
		
		request.impression = new Impression(new Slot(null,null));
		test.assert(false == request.isValid());
		
		request.impression = new Impression(new Slot(null,"top"));
		test.assert(false == request.isValid());
		
		request.impression = new Impression(new Slot(-1,"top"));
		test.assert(false == request.isValid());
		
		request.impression = new Impression(new Slot(15,"top"));
		test.assert(false == request.isValid());
	});
});
