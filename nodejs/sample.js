var Request = require('./com/inmobi/monetization/api/request/Request.js');
var Impression = require('./com/inmobi/monetization/api/request/ad/Impression.js');
var Slot = require('./com/inmobi/monetization/api/request/ad/Slot.js');
var Device = require('./com/inmobi/monetization/api/request/ad/Device.js');
var Property = require('./com/inmobi/monetization/api/request/ad/Property.js');
var BannerResponse = require('./com/inmobi/monetization/api/response/ad/BannerResponse.js');
var NativeResponse = require('./com/inmobi/monetization/api/response/ad/NativeResponse.js');
var Banner = require('./com/inmobi/monetization/ads/Banner.js');
var Interstitial = require('./com/inmobi/monetization/ads/Interstitial.js');
var Native = require('./com/inmobi/monetization/ads/Native.js');

var property = new Property("YOUR_PROPERTY_ID");
var impression = new Impression(new Slot(15,null));
var device = new Device("USER_CARRIER_IP","USER_WEBVIEW_USER_AGENT");
request = new Request(property,impression,device,null);

var banner = new Banner();
var interstitial = new Interstitial();

banner.loadRequest(request,function success(ads) {
	console.log("receive success");
		for( i in ads) {
		console.log(ads[i].adURL);
	}
},function fail(error) {
	console.log("in fail:" + error)
});

var nativeAd = new Native();
request.property.propertyId = "YOUR_PROPERTY_ID";
