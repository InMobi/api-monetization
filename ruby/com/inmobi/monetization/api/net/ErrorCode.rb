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
########################################################################
# This class describes the ErrorCode, so obtained when requesting an ad-format
#  to InMobi.

# @author Rishabh Chowdhary
########################################################################
class ErrorCode

	 #The error is unknown. Please look at responseMsg for any further details.
	UNKNOWN = 0;
	
	#An I/O exception occured. Please check if the response is coming from a
	#valid InMobi production endpoint.
	
	IO_EXCEPTION = 1;
	
	#Please check if the endpoint is correct.
	
	MALFORMED_URL = 2;
	
	#The request contains invalid parameters, or the parameters couldn't be
	#identified by InMobi. <br/>
	#<b>InMobi property ID</b>: Please check if the passed String value is
	#'activated' on InMobi UI.<br/>
	#<b> Carrier IP</b: Please check if a valid Mobile Country code was passed
	#in the request. Localhost values such as "10.x.y.z" or "192.x.y.z" are
	#disallowed.<br/>
	#<b> User Agent</b>: Please pass in a valid Mobile User Agent. Passing any
	#desktop User Agent is disallowed, and request will be terminated by
	#InMobi.
	
	INVALID_REQUEST = 3;
	
	#Served has returned a no-fill, no action required here. Publishers are
	#expected to try requesting ads in future.
	
	NO_FILL = 4;
	
	#Coulnd't connect to the server, or the request timed out.
	
	TIME_OUT = 5;
	
	#InMobi server gateway experienced too many requests, and hence a gateway
	#time out occured. Please ignore this error, and try requesting ads after some time.
	
	GATEWAY_TIME_OUT = 6;

	## Provide an error message & an errocode to instantiate this class instance.
	def initialize(errorMsg,errorCode)
		@errorMsg = errorMsg;
		@errorCode = errorCode;
	end
	#accessor
	attr_reader :errorCode
	attr_reader :errorMsg

end
