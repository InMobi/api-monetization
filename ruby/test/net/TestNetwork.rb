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
#   modifications to Usenet or an equivalent medium, or by allowing
#   the author to include your modifications in the software.
#
#       b) use the modified software only within your corporation or
#          organization.
#
#       c) rename any non-standard executables so the names do not conflict
#   with standard executables, which must also be provided.
#
#       d) make other distribution arrangements with the author.
#
#  3. You may distribute the software in object code or executable
#     form, provided that you do at least ONE of the following:
#
#       a) distribute the executables and library files of the software,
#   together with instructions (in the manual page or equivalent)
#   on where to get the original distribution.
#
#      b) accompany the distribution with the machine-readable source of
#   the software.
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
require_relative "../../com/inmobi/monetization/api/net/ErrorCode.rb"
require_relative "../../com/inmobi/monetization/api/net/RequestResponseManager.rb"

require "test/unit"

class TestStubs < Test::Unit::TestCase

  def testErrorCode
  	ec = ErrorCode.new(nil,nil);
  	code = ErrorCode::NO_FILL;
  	ec = ErrorCode.new("",code);
  	assert_equal(code,ec.errorCode);

  	code = ErrorCode::INVALID_REQUEST;
  	ec = ErrorCode.new("ERRORMSG",code);
  	assert_equal(code,ec.errorCode);
  	assert_equal("ERRORMSG",ec.errorMsg);
  	code = ErrorCode::TIME_OUT;
  	ec = ErrorCode.new("",code);
  	assert_equal(code,ec.errorCode);
  	code = ErrorCode::GATEWAY_TIME_OUT;
  	ec = ErrorCode.new("",code);
  	assert_equal(code,ec.errorCode);
	code = ErrorCode::IO_EXCEPTION;
  	ec = ErrorCode.new("",code);
  	assert_equal(code,ec.errorCode);
  end

  def testRequestResponseMgr
  	mgr = RequestResponseManager.new();
  	assert_equal(nil,mgr.fetchResponse(nil,nil,nil));
  	assert_equal(ErrorCode::INVALID_REQUEST,mgr.errorCode.errorCode);
  	assert_equal(nil,mgr.fetchResponse("","",""));
  	assert_equal(ErrorCode::INVALID_REQUEST,mgr.errorCode.errorCode);
  	assert_equal(nil,mgr.fetchResponse(" ","  ","  "));
  	assert_equal(ErrorCode::INVALID_REQUEST,mgr.errorCode.errorCode);
  	assert_equal(nil,mgr.fetchResponse(1,1,1));
  	assert_equal(ErrorCode::INVALID_REQUEST,mgr.errorCode.errorCode);
  	assert_equal(nil,mgr.fetchResponse(Object.new,1,1.12323));
  	assert_equal(ErrorCode::INVALID_REQUEST,mgr.errorCode.errorCode);
  	assert_equal(nil,mgr.fetchResponse("postBody","user-agent","87.12.1.1"));
  	assert_equal(ErrorCode::INVALID_REQUEST,mgr.errorCode.errorCode);
  	assert_equal(nil,mgr.fetchResponse("postBody","Mozilla/5.0 (iPhone; CPU iPhone OS 8_0 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A334 Safari/7534.48.3","6.0.0.1"));
  	assert_equal(ErrorCode::INVALID_REQUEST,mgr.errorCode.errorCode);
  end
end