require_relative "../../com/inmobi/monetization/api/response/BannerResponseParser.rb"
require_relative "../../com/inmobi/monetization/api/response/NativeResponseParser.rb"
require 'base64'

require "test/unit"

class TestResponse < Test::Unit::TestCase
 	def testBannerResponseParser
 		parser = BannerResponseParser.new();
 		assert_equal(nil,parser.parseResponse(nil))
 		assert_equal(nil,parser.parseResponse(""))
 		assert_equal(nil,parser.parseResponse("   "))
 		assert_equal(nil,parser.parseResponse(1))
 		assert_equal(nil,parser.parseResponse(false))
 		assert_equal(0,parser.parseResponse("nil").length)
 		assert_equal(0,parser.parseResponse("<AdResponse></AdResponse>").length)
 		assert_equal(0,parser.parseResponse("<AdResponse><Ads></Ads></AdResponse>").length)
 		assert_equal(0,parser.parseResponse("<AdResponse><Ads></Ads><Ad></Ad></AdResponse>").length)
 		assert_equal(0,parser.parseResponse("<AdResponse><Ads><Ad width='320' height='50'></Ad></Ads></AdResponse>").length)
 		assert_equal(0,parser.parseResponse("<AdResponse><Ads><Ad width='320' height='50' actionName='appStore'></Ad></Ads></AdResponse>").length)
 		assert_equal(0,parser.parseResponse("<AdResponse><Ads><Ad width='320' height='50' actionName='appStore'><AdURL>http://inmobi.com</AdURL></Ad></Ads></AdResponse>").length)
 		assert_equal(0,parser.parseResponse("<AdResponse><Ads><Ad width='320' height='50' actionName='appStore' actionType='1'><AdURL>http://inmobi.com</AdURL></Ad></Ads></AdResponse>").length)
 		assert_equal(0,parser.parseResponse("<AdResponse><Ads><Ad width='320' height='50' actionName='appStore' actionType='1'><AdURL>http://inmobi.com</AdURL><![CDATA[]]></Ad></Ads></AdResponse>").length)
 		assert_equal(1,parser.parseResponse("<AdResponse><Ads><Ad width='320' height='50' actionName='appStore' actionType='1'><AdURL>http://inmobi.com</AdURL><![CDATA[This is an ad]]></Ad></Ads></AdResponse>").length)
 		assert_equal(1,parser.parseResponse("<AdResponse><Ads><Ad width='320' height='50' actionName='appStore' actionType='1'><![CDATA[This is an ad]]></Ad></Ads></AdResponse>").length)
 	end
 	def testBannerResponse
 		br = BannerResponse.new()
 		cdata = "this is cdata"
 		br.CDATA = cdata;
 		assert_equal(cdata,br.CDATA);
 		br.actionType = 1
 		assert_equal(1,br.actionType);
 		name = "appStore"
 		br.actionName = name;
 		assert_equal(name,br.actionName);
 		url = "http://inmobi.com"
 		br.adURL = url;
 		assert_equal(url,br.adURL);
 		rm = false;
 		br.isRichMedia = rm;
 		assert_equal(rm,br.isRichMedia);
 		adsize = AdSize.new(320,50);
 		br.adSize = adsize
 		assert_equal(adsize,br.adSize);

 		assert_equal(true,br.isValid())
 		br.CDATA = nil;
 		assert_equal(false,br.isValid())
 		br = BannerResponse.new();
 		assert_equal(false,br.isValid())

 		width = "320";height="50"
 		adsize = AdSize.new(width,nil);
		assert_equal(Fixnum,adsize.width.class);

		adsize = AdSize.new(nil,height);
		assert_equal(Fixnum,adsize.height.class);
		adsize = AdSize.new(width,height);
		assert_equal(Fixnum,adsize.width.class);
		assert_equal(Fixnum,adsize.height.class);
		assert_equal(width.to_i,adsize.width)
		assert_equal(height.to_i,adsize.height)

 	end
 	def testNativeResponse
 		nr = NativeResponse.new();
 		assert_equal(false,nr.isValid());
 		pubcontent = "pubcontent";
 		nr.pubContent = pubcontent;
 		assert_equal(pubcontent,nr.pubContent);

 		contextcode = "contextcode"
 		nr.contextCode = contextcode;
 		assert_equal(contextcode,nr.contextCode);

 		ns = "namespace"
 		nr.namespace = ns;
 		assert_equal(ns,nr.namespace);

 		assert_equal(true,nr.isValid())
 		nr.pubContent = 1;
 		assert_equal(false,nr.isValid())
 		nr.pubContent = nil;
 		assert_equal(false,nr.isValid())

 		nr.contextCode = 1;
 		assert_equal(false,nr.isValid())
 		nr.contextCode = nil;
 		assert_equal(false,nr.isValid())

 		nr.namespace = 1;
 		assert_equal(false,nr.isValid())
 		nr.namespace = nil;
 		assert_equal(false,nr.isValid())

 		nr.namespace = "namespace"
		assert_equal(false,nr.isValid())
		nr.contextCode = "contextcode";
		assert_equal(false,nr.isValid())

		nr.pubContent = "pubContent"
		assert_equal(true,nr.isValid()) 

		nr.pubContent = 1;
		assert_equal(nil,nr.convertPubContentToJSON())
		nr.pubContent = nil;
		assert_equal(nil,nr.convertPubContentToJSON())		
		nr.pubContent = "";
		assert_equal(nil,nr.convertPubContentToJSON())
		nr.pubContent = "   ";
		assert_equal(nil,nr.convertPubContentToJSON())
		sdf = "sdf"
		nr.pubContent = sdf;
		assert_equal("",nr.convertPubContentToJSON())

		nr.pubContent = Base64.encode64(sdf);
		assert_equal(sdf,nr.convertPubContentToJSON())

		sdf = "eyJ0aXRsZSI6Ilp5bmdhIFBva2VyIC0gVGV4YXMgSG9sZGUiLCJkZXNjcmlwdGlvbiI6IuKAnFRoZSBsYXJnZXN0IHBva2VyIHNpdGUgaW4gdGhlIHdvcmxk4oCm4oCdIOKAkyBFU1BOLkNPTSBaeW5nYSBQb2tlciBvZmZlcnMgYW4gYXV0aGVudGljIHBva2VyIGV4cGVyaWVuY2UiLCJpY29uIjp7ImhlaWdodCI6MTUwLCJ3aWR0aCI6MTUwLCJhc3BlY3RSYXRpbyI6MSwidXJsIjoiaHR0cDovL21raG9qLWF2LnMzLmFtYXpvbmF3cy5jb20vMzU0OTAyMzE1LXVzLTE0MjQyMDA5MTg3NjUifSwic2NyZWVuc2hvdHMiOnsiaGVpZ2h0IjozMDAsIndpZHRoIjoyNTAsImFzcGVjdFJhdGlvIjowLjgzLCJ1cmwiOiJodHRwOi8vYWR0b29scy1hLmFrYW1haWhkLm5ldC9uYXRpdmVhZHMvcHJvZC9pbWFnZXMvNjY5NzM3MDIwOTE1NTkyODk3MzM4ZmMxZi01ZTM5LTRjNzYtYTkyNC03ZjA5NTNjMmZkZmEuanBnIn0sImxhbmRpbmdfdXJsIjoiaHR0cHM6Ly9pdHVuZXMuYXBwbGUuY29tL2FwcC9wb2tlci1ieS16eW5nYS9pZDM1NDkwMjMxNT9tdFx1MDAzZDgiLCJjdGEiOiJJbnN0YWxsIn0="
		nr.pubContent = sdf;
		assert_equal(Base64.decode64(sdf),nr.convertPubContentToJSON())
 	end
 	def testNativeParser
 		parser = NativeResponseParser.new();
 		assert_equal(nil,parser.parseResponse(nil));
 		assert_equal(nil,parser.parseResponse(1));
 		assert_equal(nil,parser.parseResponse(""));
 		assert_equal(nil,parser.parseResponse("  "));
 		assert_equal(nil,parser.parseResponse("sdf")); #Invalid json
 		assert_equal(nil,parser.parseResponse("<AdResponse><Ads><Ad></Ads></AdResponse>")); #Invalid json
 		assert_equal(nil,parser.parseResponse("<AdResponse><Ads><Ad width='320' height='50' actionName='appStore' actionType='1'><![CDATA[This is an ad]]></Ad></Ads></AdResponse>"));
 		assert_equal(0,parser.parseResponse("{}").length);
 		assert_equal(0,parser.parseResponse("{\"ads\":[]}").length);
 		assert_equal(0,parser.parseResponse("{\"ads\":[{}]}").length);
 		assert_equal(0,parser.parseResponse("{\"ads\":[{\"pubContent\":\"\",\"contextCode\":\"\",\"namespace\":\"\"}]}").length);
 		assert_equal(0,parser.parseResponse("{\"ads\":[{\"pubContent\":\"pubContent\",\"contextCode\":\"contextCode\",\"namespace\":\"\"}]}").length);
 		assert_equal(1,parser.parseResponse("{\"ads\":[{\"pubContent\":\"pubContent\",\"contextCode\":\"contextCode\",\"namespace\":\"ns\"}]}").length);

 	end
end