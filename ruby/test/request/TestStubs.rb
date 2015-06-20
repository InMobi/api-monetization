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

require_relative "../../com/inmobi/monetization/api/request/Stubs.rb"
require_relative "../../com/inmobi/monetization/api/request/Request.rb"
require "test/unit"

class TestStubs < Test::Unit::TestCase

  def testSlot
		
		slotObj = Slot.new(10,nil);
		adSize = -1;
		slotObj.adSize = adSize;

		# adSize must be >= 1
		assert_equal(false,slotObj.isValid()); 

		adSize = 15; 
		slotObj.adSize = adSize;
		assert_equal(true,slotObj.isValid()); 
		assert_equal(15,slotObj.adSize); 

		pos = "top";
		slotObj.position = pos;
		assert_equal(pos,slotObj.position); 

		adSize = -1;
		pos = "  ";
		slotObj = Slot.new(adSize,pos)
		assert_equal(false, slotObj.isValid());

		adSize = 5;
		pos = "bottom";
		slotObj = Slot.new(adSize,pos)
		assert_equal(true, slotObj.isValid());

		adSize = 5;
		pos = "";
		slotObj = Slot.new(adSize,pos)
		assert_equal(true, slotObj.isValid());

		adSize = 5;
		pos = "   ";
		slotObj = Slot.new(adSize,pos)
		assert_equal(true, slotObj.isValid());

		adSize = 5;
		slotObj = Slot.new(adSize,nil)
		assert_equal(true, slotObj.isValid());

		slotObj = Slot.new("asdf",nil)
		assert_equal(false, slotObj.isValid());

		slotObj = Slot.new(10,false)
		assert_equal(true, slotObj.isValid());
		
  end
  def testDevice
  		device = Device.new()
		assert_equal(false,device.isValid());

		# gpid
		gpid = "dsfsoadsdfasdfasdfsdfsd";
		device.gpid = gpid;
		assert_equal(gpid,device.gpid);
		assert_equal(false,device.isValid());
		# ida
		idfa = "asdfasdfasfsdfsdfsdfs";
		device.idfa = idfa;
		assert_equal(idfa,device.idfa);	
		assert_equal(false,device.isValid());
		# ua
		ua = "Mozilla/5.0 (iPhone; CPU iPhone OS 8_0 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A334 Safari/7534.48.3"
		device.userAgent = ua;
		assert_equal(ua,device.userAgent);
		assert_equal(false,device.isValid());

		# geo
		device.geo = Geo.new(nil,nil,nil);
		assert_equal(false,device.isValid());
		# ip
		ip = "6.0.0.0";
		device.carrierIP =ip;
		assert_equal(ip,device.carrierIP);

		assert_equal(true,device.isValid());

		device = Device.new();
		device.carrierIP = 15 #test Fixnum, non String value
		assert_equal(false,device.isValid());
		
		device.carrierIP = ip;
		device.userAgent = 15
		assert_equal(false,device.isValid());

		device.userAgent = ua;
		assert_equal(true,device.isValid());
		
  end

  def testGeo
  		# test valid values
  		geo = Geo.new(0,0,0);

		lat = 92;
		geo.latitude = lat;
		assert_equal(lat, geo.latitude);
		lat = -92;
		geo.latitude = lat;
		assert_equal(lat, geo.latitude);
		lat = 12;
		geo.latitude = lat;
		assert_equal(lat, geo.latitude);
		lat = -12;
		geo.latitude = lat;
		assert_equal(lat, geo.latitude);

		lon = 183;
		geo.longitude = lon;
		assert_equal(lon, geo.longitude);
		lon = -183;
		geo.longitude = lon;
		assert_equal(lon, geo.longitude);
		lon = 120;
		geo.longitude = lon;
		assert_equal(lon, geo.longitude);
		lon = -120;
		geo.longitude = lon;
		assert_equal(lon, geo.longitude);

		accu = -2;
		geo.accuracy = accu;
		assert_equal(accu, geo.accuracy);
		accu = 2;
		geo.accuracy = accu;
		assert_equal(accu, geo.accuracy);

		lat = 12.37;
		lon = 114.11;
		accu = 50;
		geo = Geo.new(lat,lon,accu);
		assert_equal(true,geo.isValid());

		lat = -12.11;
		lon = 114.11;
		accu = 50;
		geo = Geo.new(lat,lon,accu);
		assert_equal(true,geo.isValid());
		lat = -12.11;
		lon = -114.37;
		accu = 50;
		geo = Geo.new(lat,lon,accu);
		assert_equal(true,geo.isValid());
		lat = 12.11;
		lon = -114.11;
		accu = 50;
		geo = Geo.new(lat,lon,accu);
		assert_equal(true,geo.isValid());

		lat = -112.11;
		lon = 114.12;
		accu = 50;
		geo = Geo.new(lat,lon,accu);
		assert_equal(false,geo.isValid());
		lat = 112.99;
		lon = 114.11;
		accu = 50;
		geo = Geo.new(lat,lon,accu);
		assert_equal(false,geo.isValid());
		lat = 12.37;
		lon = -183.11;
		accu = 50;
		geo = Geo.new(lat,lon,accu);
		assert_equal(false,geo.isValid());
		lat = -12.11;
		lon = 183.23;
		accu = 50;
		geo = Geo.new(lat,lon,accu);
		assert_equal(false,geo.isValid());
		lat = -12.11;
		lon = 114.12;
		accu = -50;
		geo = Geo.new(lat,lon,accu);
		assert_equal(false,geo.isValid());
  end
  def testProperty
  		prop = Property.new(nil);
		property = "";
		prop.propertyId = property;
		assert_equal(property,prop.propertyId);
		assert_equal(false,prop.isValid());

		property = "   ";
		prop.propertyId = property;
		assert_equal(property,prop.propertyId);
		assert_equal(false,prop.isValid());

		property = "asdfasdfs";
		prop.propertyId = property;
		assert_equal(property, prop.propertyId);
		assert_equal(true,prop.isValid());

		prop = Property.new("");
		assert_equal("",prop.propertyId);
		assert_equal(false,prop.isValid());

		prop = Property.new("  ");
		assert_equal("  ",prop.propertyId);
		assert_equal(false,prop.isValid());

		prop = Property.new(property);
		assert_equal(property, prop.propertyId);
		assert_equal(true,prop.isValid());
  end
  def testImpression
  		slot = Slot.new(nil,nil);
		imp = Impression.new(slot);

		assert_equal(false,imp.isValid());

		slot = Slot.new(15, "");
		imp.slot = slot;
		assert_equal(true,imp.isValid());

		slot = Slot.new(10, "top");
		imp.slot = slot;
		assert_equal(true,imp.isValid());

		slot = Slot.new(-10, "top");
		imp.slot = slot;
		assert_equal(false,imp.isValid());
	
  end
 	def testRequest

		request = Request.new();
		assert_equal(false,request.isValid());
		request = Request.builder(nil, nil, nil, nil);
		assert_equal(false,request.isValid());

		request.property = Property.new(nil);
		assert_equal(false,request.isValid());

		request.property = Property.new("sdf");
		assert_equal(false,request.isValid());

		request.device = Device.new();
		assert_equal(false,request.isValid());

		device = Device.new();
		device.userAgent = "useragent";
		device.carrierIP = "carrierIP;"
		request.device = device;
		
		assert_equal(false,request.isValid());

		request.impression = Impression.new(nil);
		assert_equal(false,request.isValid());
		
		request.impression = Impression.new(Slot.new(nil,nil));
		assert_equal(false,request.isValid());
		
		request.impression = Impression.new(Slot.new(nil,"top"));
		assert_equal(false,request.isValid());
		
		request.impression = Impression.new(Slot.new(-1,"top"));
		assert_equal(false,request.isValid());
		
		request.impression = Impression.new(Slot.new(15,"top"));
		assert_equal(false,request.isValid());
	
 	end
 
end