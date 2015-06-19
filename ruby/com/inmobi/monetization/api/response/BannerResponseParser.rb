require_relative('BannerResponse.rb');
require_relative('../utils/Utils.rb')
 require 'rexml/document'
 include REXML


########################################################################
 # This class can be used to obtain an ArrayList of BannerResponse objects, from
 # the InputStream, as obtained from the API 2.0 server response.
 # 
 # @author rishabhchowdhary
 # 
 ########################################################################
class BannerResponseParser
	public
	def parseResponse(response)
		if(Utils.isStringValid(response) == false)
			return nil
		end
		#start xml parsing
		begin
			doc = Document.new(response)
			#root = doc.root
			adsArray = Array.new()
			doc.elements.each("AdResponse/Ads/Ad") { |element| 
			br = BannerResponse.new()
			br.actionName = element.attributes['actionName']
			br.actionType = element.attributes['actionType']
			if(element.attributes['type'] == 'rm')
				br.isRichMedia = true;
			end

			br.adSize = AdSize.new(element.attributes['width'],element.attributes['height'])
			br.adURL = element.elements['AdURL'].text unless element.elements['AdURL'].nil?
			br.CDATA = element.text unless element.text.nil?
			if(br.isValid()) #check if all parameters were successfully fetched
				adsArray.push(br)
			end
		}
		rescue
			adsArray = nil
		end
		return adsArray
	end
end