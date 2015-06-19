InMobiAPIMonetizationLibrary-NodeJS
=================================

This is the API library, build for Server integrations which use NodeJS technology

Component dependencies, required to use this library code:
- Enum(Install uisng: “npm install enum”)
- Request( Install using: “npm install request”)
- xml2js(Install using: “npm install xml2js”)
- Unit.js(For Unit testing purpose only) - Install using “npm install unit.js”


API usage examples:

Dependencies:

require_relative 'com/inmobi/monetization/ads/Banner.rb'
require_relative 'com/inmobi/monetization/ads/Interstitial.rb'
require_relative 'com/inmobi/monetization/ads/Native.rb'


###Create request object stubs

#Create a property object
property = Property.new("YOUR_PROPERTY_ID");

#Create a slot object. Default slot size is 320x50 for banner ads
slot = Slot.new(15,nil);

#Create an impression object
impression = Impression.new(slot);

#Create a device object.
device = Device.new();
device.userAgent = "MOBILE_USER_AGENT"
device.carrierIP = "MOBILE_CARRIER_IP";
##Create a request object
request = Request.builder(property,impression,device,nil); #user is optional

#create a banner object
banner = Banner.new();

adsArray = banner.loadRequest(request);

if(adsArray != nil)
	adsArray.each { |ad| # Instance of BannerResponse class
		puts ad.to_s ## 
	}
end

#Create an interstitial object
interstitial = Interstitial.new();
request.impression.slot = new Slot(14,nil); # Impression default slot size is 320x480, or 14

adsArray = interstitial.loadRequest(request);

if(adsArray != nil)
	adsArray.each { |ad| # Instance of BannerResponse class
		puts ad.to_s ## 
	}
end

#Create a native object
native = Native.new()

adsArray = native.loadRequest(request);
if(adsArray != nil)
	adsArray.each { |ad| # Instance of NativeResponse class
		puts ad.to_s ## 
	}
end


