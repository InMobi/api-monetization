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
require_relative 'ErrorCode.rb'
require_relative '../utils/Utils.rb'
require 'net/http'

########################################################################
 # This class can be used to request InMobi Ads, by passing in a valid
 # AdRequestObject, and a ad format type. You may use this class to obtain the
 # response as a String, or as a InputStream. You may also check the
 # <i>errorCode</i> value to check if in case an error had occurred, if the
 # response returned is invalid. This class makes use of the
 # java.net.HttpURLConnection, to request InMobi ads in a synchronous fashion.
 # Publishers may create new Threads themselves to fire http requests in an
 # asynchronous manner.
 # 
 # @note It is your responsibility to check if the request contains the
 #       mandatory required parameters. If the mandatory parameters are not
 #       present, the server would terminated the request. <br/>
 #       We recommend converting AdRequestObject to JsonObject using <b>
 #       JSONPayloadCreator</b>, so that any missing parameter can be
 #       identified.<br/> 
 #       Publishers may also check 'isRequestInProgress' before
 #       calling any of request methods, to check if a request was in progress
 #       or not.

# @author Rishabh Chowdhary
########################################################################

class RequestResponseManager
	def initialize
		@errorCode = nil
	end

	AD_SERVER_URL = "http://api.w.inmobi.com/showad/v2"

	public
	def fetchResponse(requestJson,userAgent,carrierIP)

		if(Utils.isStringValid(requestJson) && Utils.isStringValid(userAgent) && Utils.isStringValid(carrierIP))
			# instantiate required objects for networking
			uri = URI.parse(AD_SERVER_URL)
			http = Net::HTTP.new(uri.host, uri.port)
			request = Net::HTTP::Post.new(uri)

			#add required headers
			request.add_field('Content-Type', 'application/json')
			#passing UA in header is causing a 400 bad request!
			#request.add_field('x-device-user-agent', userAgent)
			request.add_field('x-forwarded-for', carrierIP)
			# add the request post body
			request.body = requestJson
			response = http.request(request)
			#puts response.code
			if(response.code == "200") #proper response received
				@errorCode = nil
				return response.body
			else
				setErrorCode(response.code)
				return nil
			end
		end
		@errorCode = ErrorCode.new("Please check your request object params",ErrorCode::INVALID_REQUEST)
		return nil
	end
	attr_reader :errorCode
	private
	def setErrorCode(code)
		if(code == "204") #NO content
			@errorCode = ErrorCode.new("Server returned no-fill. No Action required",ErrorCode::NO_FILL)
		elsif (code == "400")
			@errorCode = ErrorCode.new("Request is invalid. Please check mandatory params of your request - Carrier IP, User Agent & Property ID.",ErrorCode::INVALID_REQUEST)
		elsif (code == "504")
			@errorCode = ErrorCode.new("Gateway timed out, please try again later.",ErrorCode::TIME_OUT)
		else
			@errorCode = ErrorCode.new("Server returned a response:" + code, ErrorCode::IO_EXCEPTION)
		end
	end

	
end