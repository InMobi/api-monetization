#######################################################################################
#Copyright © 2015 InMobi Technologies Pte. Ltd. All rights reserved.
#
#                           MIT License
#
#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in
#all copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#THE SOFTWARE.
#
#InMobi Monetization Library SUBCOMPONENTS:
#
#The InMobi Monetization Library contains subcomponents with separate copyright
#notices and license terms. Your use of the source code for the these
#subcomponents is subject to the terms and conditions of the following
#licenses.
#
#————————-————————-————————-————————-————————-————————-————————-————————-————————-————————-
#License for REXML:
#
#REXML is copyrighted free software by Sean Russell <ser@germane-software.com>.
#You can redistribute it and/or modify it under either the terms of the GPL
#(see GPL.txt file), or the conditions below:
#
# 1. You may make and give away verbatim copies of the source form of the
#     software without restriction, provided that you duplicate all of the
#     original copyright notices and associated disclaimers.
#
# 2. You may modify your copy of the software in any way, provided that
#     you do at least ONE of the following:
#
#      a) place your modifications in the Public Domain or otherwise
#        make them Freely Available, such as by posting said
#	  modifications to Usenet or an equivalent medium, or by allowing
#	  the author to include your modifications in the software.
#
#       b) use the modified software only within your corporation or
#          organization.
#
#       c) rename any non-standard executables so the names do not conflict
#	  with standard executables, which must also be provided.
#
#       d) make other distribution arrangements with the author.
#
#  3. You may distribute the software in object code or executable
#     form, provided that you do at least ONE of the following:
#
#       a) distribute the executables and library files of the software,
#	  together with instructions (in the manual page or equivalent)
#	  on where to get the original distribution.
#
#      b) accompany the distribution with the machine-readable source of
#	  the software.
#
#       c) give non-standard executables non-standard names, with
#          instructions on where to get the original software distribution.
#
#       d) make other distribution arrangements with the author.
#
#  4. You may modify and include the part of the software into any other
#     software (possibly commercial).  But some files in the distribution
#     are not written by the author, so that they are not under this terms.
#
#     All files of this sort are located under the contrib/ directory.
#     See each file for the copying condition.
#
#  5. The scripts and library files supplied as input to or produced as 
#     output from the software do not automatically fall under the
#     copyright of the software, but belong to whomever generated them, 
#     and may be sold commercially, and may be aggregated with this
#     software.
#
#  6. THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR
#     IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
#     WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
#     PURPOSE.

#######################################################################################

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