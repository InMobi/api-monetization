require_relative "../../com/inmobi/monetization/ads/Interstitial.rb"
require_relative "../../com/inmobi/monetization/ads/Native.rb"

require "test/unit"

class TestAds < Test::Unit::TestCase
  def testBanner
    banner = Banner.new();
    assert_equal(nil,banner.loadRequest(nil));
    assert_equal(nil,banner.loadRequest(Request.new()));

    request = Request.new();
    request.property = Property.new("sdf")
    assert_equal(nil,banner.loadRequest(request));
    request.device = Device.new();
    assert_equal(nil,banner.loadRequest(request));
    request.impression = Impression.new(nil);
    assert_equal(nil,banner.loadRequest(request));
    request.impression = Impression.new(Slot.new(nil,nil));
    assert_equal(nil,banner.loadRequest(request));
    request.impression = Impression.new(Slot.new(-1,"top"));
    assert_equal(nil,banner.loadRequest(request));
    request.impression = Impression.new(Slot.new(10,"top"));
    assert_equal(nil,banner.loadRequest(request));
    request.device.userAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 8_0 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A334 Safari/7534.48.3";
    request.device.carrierIP = "6.0.0.0"
    assert_equal(nil,banner.loadRequest(request));

  end
  def testInterstitial
    interstitial = Interstitial.new();
    assert_equal(nil,interstitial.loadRequest(nil));
    assert_equal(nil,interstitial.loadRequest(Request.new()));

    request = Request.new();
    request.property = Property.new("sdf")
    assert_equal(nil,interstitial.loadRequest(request));
    request.device = Device.new();
    assert_equal(nil,interstitial.loadRequest(request));
    request.impression = Impression.new(nil);
    assert_equal(nil,interstitial.loadRequest(request));
    request.impression = Impression.new(Slot.new(nil,nil));
    assert_equal(nil,interstitial.loadRequest(request));
    request.impression = Impression.new(Slot.new(-1,"top"));
    assert_equal(nil,interstitial.loadRequest(request));
    request.impression = Impression.new(Slot.new(14,"top"));
    assert_equal(nil,interstitial.loadRequest(request));
    request.device.userAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 8_0 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A334 Safari/7534.48.3";
    request.device.carrierIP = "6.0.0.0"
    assert_equal(nil,interstitial.loadRequest(request));
  end
  def testNative
    native = Native.new();
    assert_equal(nil,native.loadRequest(nil));
    assert_equal(nil,native.loadRequest(Request.new()));
    
    request = Request.new();
    request.property = Property.new("sdf")
    assert_equal(nil,native.loadRequest(request));
    request.device = Device.new();
    assert_equal(nil,native.loadRequest(request));
    request.impression = Impression.new(nil);
    assert_equal(nil,native.loadRequest(request));
    request.impression = Impression.new(Slot.new(nil,nil));
    assert_equal(nil,native.loadRequest(request));
    request.impression = Impression.new(Slot.new(-1,"top"));
    assert_equal(nil,native.loadRequest(request));
    request.impression = Impression.new(Slot.new(14,"top"));
    assert_equal(nil,native.loadRequest(request));
    request.device.userAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 8_0 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A334 Safari/7534.48.3";
    request.device.carrierIP = "6.0.0.0"
    assert_equal(nil,native.loadRequest(request));
  end
  
end