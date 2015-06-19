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