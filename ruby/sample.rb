
require 'json'
require_relative 'com/inmobi/monetization/ads/Banner.rb'
require_relative 'com/inmobi/monetization/ads/Native.rb'
require_relative 'com/inmobi/monetization/api/net/ErrorCode.rb'


banner = Banner.new();
r = Request.new();
property = Property.new("YOUR_PROPERTY_ID");
slot = Slot.new(15,"top");
impression = Impression.new(slot);
device = Device.new();
device.userAgent = "USER_WEBVIEW_USER_AGENT";
device.carrierIP = "USER_CARRIER_IP";
r = Request.builder(property,impression,device,nil);
#puts r.toJSON();
adsArray = nil
#adsArray = banner.loadRequest(r);
p = Hash.new();
puts p.empty?;
puts "here"
if(adsArray != nil)
	adsArray.each { |ad|
		puts ad.to_s
	}
end

native = Native.new()
r.property.propertyId = "YOUR_PROPERTY_ID";
ads = native.loadRequest(r);
if(ads != nil)
	ads.each { |ad|
		puts ad.namespace
	}
end
