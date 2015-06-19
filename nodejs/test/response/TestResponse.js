var test = require('unit.js');
//var Buffer = require('Buffer.js');
var BannerResponseParser = require("../../com/inmobi/monetization/api/response/parser/BannerResponseParser.js");
var NativeResponseParser = require("../../com/inmobi/monetization/api/response/parser/NativeResponseParser.js");
var NativeResponse = require("../../com/inmobi/monetization/api/response/ad/NativeResponse.js");
var BannerResponse = require("../../com/inmobi/monetization/api/response/ad/BannerResponse.js");
var AdSize = require("../../com/inmobi/monetization/api/response/ad/AdSize.js");



describe('TestResponse', function () {

  it('should correctly run the BannerResponseParser test cases', function () {
  		var parser = new BannerResponseParser();
  	 	test.assert(parser.parseResponse(null) == null);
 		test.assert(parser.parseResponse("") == null)
 		test.assert(parser.parseResponse("   ") == null)
 		test.assert(parser.parseResponse(1,null) == null)
 		test.assert(parser.parseResponse(false,{}) == null)
 		test.assert(parser.parseResponse("null",1) == null);
 		test.assert(parser.parseResponse("<AdResponse></AdResponse>",{}) == null);
 		test.assert(parser.parseResponse("<AdResponse><Ads></Ads></AdResponse>",1.00) == null)
 		test.assert(parser.parseResponse("<AdResponse><Ads><Ad></Ad></Ads></AdResponse>","sdf") == null)
 		test.assert(parser.parseResponse("<AdResponse><Ads><Ad width='320' height='50'></Ad></Ads></AdResponse>","123") == null)
 		test.assert(parser.parseResponse("<AdResponse><Ads><Ad width='320' height='50' actionName='appStore'></Ad></Ads></AdResponse>") == null)
 		test.assert(parser.parseResponse("<AdResponse><Ads><Ad width='320' height='50' actionName='appStore'><AdURL>http://inmobi.com</AdURL></Ad></Ads></AdResponse>") == null)
 		test.assert(parser.parseResponse("<AdResponse><Ads><Ad width='320' height='50' actionName='appStore' actionType='1'><AdURL>http://inmobi.com</AdURL></Ad></Ads></AdResponse>") == null)
 		test.assert(parser.parseResponse("<AdResponse><Ads><Ad width='320' height='50' actionName='appStore' actionType='1'><AdURL>http://inmobi.com</AdURL><![CDATA[]]></Ad></Ads></AdResponse>") == null)
 		test.assert(parser.parseResponse("<AdResponse><Ads><Ad width='320' height='50' actionName='appStore' actionType='1'><AdURL>http://inmobi.com</AdURL><![CDATA[This is an ad]]></Ad></Ads></AdResponse>","this is a string") == null)
 		test.assert(parser.parseResponse("<AdResponse><Ads><Ad width='320' height='50' actionName='appStore' actionType='1'><![CDATA[This is an ad]]></Ad></Ads></AdResponse>",null) == null)

 		parser.parseResponse(null, function(value) {
 			test.assert(value == null);
 		});
 		parser.parseResponse(1, function(value) {
 			test.assert(value == null);
 		});
 		parser.parseResponse({}, function(value) {
 			test.assert(value == null);
 		});
 		parser.parseResponse("", function(value) {
 			test.assert(value == null);
 		});
 		parser.parseResponse("   ", function(value) {
 			test.assert(value == null);
 		});
 		parser.parseResponse("<AdResponse></AdResponse>", function(value) {
 			test.assert(value == null);
 		});
 		parser.parseResponse("<AdResponse><Ads></Ads></AdResponse>", function(value) {
 			test.assert(value.length == 0);
 		});
 		//malformed xml
 		parser.parseResponse("<AdResponse><Ads><Ad></Ad><</Ads></AdResponse>", function(value) {
 			test.assert(value == null);
 		});
 		parser.parseResponse("<AdResponse><Ads><Ad></Ad></Ads></AdResponse>", function(value) {
 			test.assert(value.length == 0);
 		});
 		parser.parseResponse("<AdResponse><Ads><Ad width='320' height='50' actionName='appStore'></Ad></Ads></AdResponse>", function(value) {
 			test.assert(value.length == 0);
 		});
 		parser.parseResponse("<AdResponse><Ads><Ad width='320' height='50' actionName='appStore'><AdURL>http://inmobi.com</AdURL></Ad></Ads></AdResponse>", function(value) {
 			test.assert(value.length == 0);
 		});
 		parser.parseResponse("<AdResponse><Ads><Ad width='320' height='50' actionName='appStore' actionType='1'><AdURL>http://inmobi.com</AdURL><![CDATA[]]></Ad></Ads></AdResponse>", function(value) {
 			test.assert(value.length == 0);
 		});
 		parser.parseResponse("<AdResponse><Ads><Ad width='320' height='50' actionName='appStore' actionType='1'><AdURL>http://inmobi.com</AdURL><![CDATA[This is an ad]]></Ad></Ads></AdResponse>", function(value) {
 			test.assert(value.length == 1);
 		});
 		parser.parseResponse("<AdResponse><Ads><Ad width='320' height='50' actionName='appStore' actionType='1'><![CDATA[This is an ad]]></Ad></Ads></AdResponse>", function(value) {
 			test.assert(value.length == 0);
 		});
 		
  });
	
  it('should correctly run the NativeResponseParser test cases', function () {
  		var parser = new NativeResponseParser();
  		test.assert(parser.parseResponse(null) == null);
 		test.assert(parser.parseResponse(1) == null);
 		test.assert(parser.parseResponse("") == null);
 		test.assert(parser.parseResponse("  ") == null);
 		test.assert(parser.parseResponse("sdf").length == 0); //Invalid json
 		test.assert(parser.parseResponse("<AdResponse><Ads><Ad></Ads></AdResponse>") .length == 0); //Invalid json
 		test.assert(parser.parseResponse("<AdResponse><Ads><Ad width='320' height='50' actionName='appStore' actionType='1'><![CDATA[This is an ad]]></Ad></Ads></AdResponse>") .length == 0);
 		test.assert(parser.parseResponse("{}").length == 0);
 		test.assert(parser.parseResponse("{\"ads\":[]}").length == 0);
 		test.assert(parser.parseResponse("{\"ads\":[{}]}").length == 0);
 		test.assert(parser.parseResponse("{\"ads\":[{\"pubContent\":\"\",\"contextCode\":\"\",\"namespace\":\"\"}]}").length == 0);
 		test.assert(parser.parseResponse("{\"ads\":[{\"pubContent\":\"pubContent\",\"contextCode\":\"contextCode\",\"namespace\":\"\"}]}").length == 0);
 		test.assert(parser.parseResponse("{\"ads\":[{\"pubContent\":\"pubContent\",\"contextCode\":\"contextCode\",\"namespace\":\"ns\"}]}").length == 1);
  });

  it('should correctly run the BannerResponse test cases', function () {
  		br = new BannerResponse();
 		cdata = "this is cdata";
 		br.CDATA = cdata;
 		test.assert(cdata == br.CDATA);
 		br.actionType = 1;
 		test.assert(1 == br.actionType);
 		name = "appStore";
 		br.actionName = name;
 		test.assert(name == br.actionName);
 		url = "http://inmobi.com";
 		br.adURL = url;
 		test.assert(url == br.adURL);
 		rm = false;
 		br.isRichMedia = rm;
 		test.assert(rm == br.isRichMedia);
 		adsize = new AdSize(320,50);
 		br.adSize = adsize;
 		test.assert(adsize == br.adSize);

 		test.assert(true == br.isValid());
 		br.CDATA = null;
 		test.assert(false == br.isValid());
 		br = new BannerResponse();

 		test.assert(false == br.isValid());

 		width = "320"; height = "50"
 		adsize = new AdSize(width,null);
		test.assert(typeof(adsize.width) == "number");

		adsize = new AdSize(null,height);
		test.assert(typeof(adsize.height) == "number");

		adsize = new AdSize(width,height);
		test.assert(typeof(adsize.width) == "number");
		test.assert(typeof(adsize.height) == "number");

		test.assert(width == adsize.width)
		test.assert(height == adsize.height)
  });
  
  it('should correctly run the NativeResponse test cases', function () {
  		nr = new NativeResponse();
 		test.assert(false == nr.isValid());
 		pubcontent = "pubcontent";
 		nr.pubContent = pubcontent;
 		test.assert(pubcontent == nr.pubContent);

 		contextcode = "contextcode"
 		nr.contextCode = contextcode;
 		test.assert(contextcode == nr.contextCode);

 		ns = "namespace"
 		nr.namespace = ns;
 		test.assert(ns,nr.namespace);

 		test.assert(true == nr.isValid())
 		nr.pubContent = 1;
 		test.assert(false == nr.isValid())
 		nr.pubContent = null;
 		test.assert(false == nr.isValid())

 		nr.contextCode = 1;
 		test.assert(false == nr.isValid())
 		nr.contextCode = null;
 		test.assert(false == nr.isValid())

 		nr.namespace = 1;
 		test.assert(false == nr.isValid())
 		nr.namespace = null;
 		test.assert(false == nr.isValid())

 		nr.namespace = "namespace"
		test.assert(false == nr.isValid())
		nr.contextCode = "contextcode";
		test.assert(false == nr.isValid())

		nr.pubContent = "pubContent"
		test.assert(true == nr.isValid()) 

		nr.pubContent = 1;
		test.assert(nr.convertPubContentToJSON() == null);
		nr.pubContent = null;
		test.assert(nr.convertPubContentToJSON() == null)		
		nr.pubContent = "";
		test.assert(nr.convertPubContentToJSON() == null)
		nr.pubContent = "   ";
		test.assert(nr.convertPubContentToJSON() == null)
		sdf = "Hello World";

		nr.pubContent = new Buffer(sdf).toString('base64');
		test.assert(sdf == nr.convertPubContentToJSON());

		sdf = "eyJ0aXRsZSI6Ilp5bmdhIFBva2VyIC0gVGV4YXMgSG9sZGUiLCJkZXNjcmlwdGlvbiI6IuKAnFRoZSBsYXJnZXN0IHBva2VyIHNpdGUgaW4gdGhlIHdvcmxk4oCm4oCdIOKAkyBFU1BOLkNPTSBaeW5nYSBQb2tlciBvZmZlcnMgYW4gYXV0aGVudGljIHBva2VyIGV4cGVyaWVuY2UiLCJpY29uIjp7ImhlaWdodCI6MTUwLCJ3aWR0aCI6MTUwLCJhc3BlY3RSYXRpbyI6MSwidXJsIjoiaHR0cDovL21raG9qLWF2LnMzLmFtYXpvbmF3cy5jb20vMzU0OTAyMzE1LXVzLTE0MjQyMDA5MTg3NjUifSwic2NyZWVuc2hvdHMiOnsiaGVpZ2h0IjozMDAsIndpZHRoIjoyNTAsImFzcGVjdFJhdGlvIjowLjgzLCJ1cmwiOiJodHRwOi8vYWR0b29scy1hLmFrYW1haWhkLm5ldC9uYXRpdmVhZHMvcHJvZC9pbWFnZXMvNjY5NzM3MDIwOTE1NTkyODk3MzM4ZmMxZi01ZTM5LTRjNzYtYTkyNC03ZjA5NTNjMmZkZmEuanBnIn0sImxhbmRpbmdfdXJsIjoiaHR0cHM6Ly9pdHVuZXMuYXBwbGUuY29tL2FwcC9wb2tlci1ieS16eW5nYS9pZDM1NDkwMjMxNT9tdFx1MDAzZDgiLCJjdGEiOiJJbnN0YWxsIn0="
		nr.pubContent = sdf;
		sdfDecode = new Buffer(sdf, 'base64').toString('ascii');
		test.assert(sdfDecode == nr.convertPubContentToJSON());
  });

  });