var Banner =  require("../../com/inmobi/monetization/ads/Banner.js");
var Interstitial =  require("../../com/inmobi/monetization/ads/Interstitial.js");
var Native = require("../../com/inmobi/monetization/ads/Native.js");
var Request = require("../../com/inmobi/monetization/api/request/Request.js");
var Property = require("../../com/inmobi/monetization/api/request/ad/Property.js");
var Device = require("../../com/inmobi/monetization/api/request/ad/Device.js");
var Geo = require("../../com/inmobi/monetization/api/request/ad/Geo.js");
var Impression = require("../../com/inmobi/monetization/api/request/ad/Impression.js");
var Slot = require("../../com/inmobi/monetization/api/request/ad/Slot.js");

var test = require('unit.js');

describe('testAds', function () {
    it('should correctly run the Banner test cases', function () {
        banner = new Banner();
        test.assert(null == banner.loadRequest(null));
        test.assert(null == banner.loadRequest(new Request()));

        request = new Request();
        request.property = new Property("sdf")
        test.assert(null == banner.loadRequest(request));
        request.device = new Device();
        test.assert(null == banner.loadRequest(request));
        request.impression = new Impression(null);
        test.assert(null == banner.loadRequest(request));
        request.impression = new Impression(new Slot(null,null));
        test.assert(null == banner.loadRequest(request));
        request.impression = new Impression(new Slot(-1,"top"));
        test.assert(null == banner.loadRequest(request));
        request.impression = new Impression(new Slot(10,"top"));
        test.assert(null == banner.loadRequest(request));
        request.device.useragent = "Mozilla/5.0 (iPhone; CPU iPhone OS 8_0 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A334 Safari/7534.48.3";
        request.device.carrierIP = "6.0.0.0"
        test.assert(null == banner.loadRequest(request));
    });
    it('should correctly run the Interstitial test cases', function () {
        interstitial = new Interstitial();
        test.assert(null == interstitial.loadRequest(null));
        test.assert(null == interstitial.loadRequest(new Request()));

        request = new Request();
        request.property = new Property("sdf")
        test.assert(null == interstitial.loadRequest(request));
        request.device = new Device();
        test.assert(null == interstitial.loadRequest(request));
        request.impression = new Impression(null);
        test.assert(null == interstitial.loadRequest(request));
        request.impression = new Impression(new Slot(null,null));
        test.assert(null == interstitial.loadRequest(request));
        request.impression = new Impression(new Slot(-1,"top"));
        test.assert(null == interstitial.loadRequest(request));
        request.impression = new Impression(new Slot(14,"top"));
        test.assert(null == interstitial.loadRequest(request));
        request.device.useragent = "Mozilla/5.0 (iPhone; CPU iPhone OS 8_0 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A334 Safari/7534.48.3";
        request.device.carrierIP = "6.0.0.0"
        test.assert(null == interstitial.loadRequest(request));
    });
    it('should correctly run the Native test cases', function () {
        native = new Native();
        test.assert(null == native.loadRequest(null));
        test.assert(null == native.loadRequest(new Request()));
        
        request = new Request();
        request.property = new Property("sdf")
        test.assert(null == native.loadRequest(request));
        request.device = new Device();
        test.assert(null == native.loadRequest(request));
        request.impression = new Impression(null);
        test.assert(null == native.loadRequest(request));
        request.impression = new Impression(new Slot(null,null));
        test.assert(null == native.loadRequest(request));
        request.impression = new Impression(new Slot(-1,"top"));
        test.assert(null == native.loadRequest(request));
        request.impression = new Impression(new Slot(14,"top"));
        test.assert(null == native.loadRequest(request));
        request.device.useragent = "Mozilla/5.0 (iPhone; CPU iPhone OS 8_0 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A334 Safari/7534.48.3";
        request.device.carrierIP = "6.0.0.0"
        test.assert(null == native.loadRequest(request));
    });
});