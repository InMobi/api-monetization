var BannerResponse = require('../ad/BannerResponse.js');
var AdSize = require('../ad/AdSize.js');
var Utils = require('../../utils/Utils.js')
//run npm install xml2js for installing xml2js parser
var parseString = require('xml2js').parseString;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 // This class can be used to obtain an ArrayList of BannerResponse objects, from
 // the InputStream, as obtained from the API 2.0 server response.
 // 
 // @author rishabhchowdhary
 // 
 ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function BannerResponseParser() {
 
}
BannerResponseParser.prototype.parseResponse = function(response,parseResult) {
	if(typeof(parseResult) != "function")
		return null;
	if(Utils.isStringValid(response) == false) {
		parseResult(null);
		return;
	}
	parseString(response, function (err, result) {
		if(result != null && typeof(result) == "object") {
			var adResponse = result['AdResponse'];
			if(adResponse != null && typeof(adResponse) == "object") {
				var ads = adResponse['Ads'];
				adsArray = [];
				
				for(i in ads) {
					try {
						var ad = ads[i]['Ad'];
						if(ad != null && typeof(ad) == "object") {
							//console.log(ad[0]);
							ad = ad[0];
							var br = new BannerResponse();
							br.adURL = ad['AdURL'][0];
							var attrs = ad['$'];
							br.actionName = attrs['actionName'];
							br.actionType = attrs['actionType'];
							if(attrs['type'] == 'rm') {
								br.isRichMedia = true;
							}
							br.adSize = new AdSize(attrs['width'],attrs['height']);
							br.CDATA  = ad['_'];
							//console.log(typeof(br.CDATA));
							console.log("br valid:" + br.isValid());
							if(br.isValid()) {
								adsArray[i] = br;
							}
						}
					} catch(e) {console.log(e)}
				}
				parseResult(adsArray);
			} else {
				parseResult(null);
			}
		} else {
			parseResult(null);
		}
    
});
// 	if(Utils.isStringValid(response) == false)
// 			return nil
// 		end
// 		//start xml parsing
// 		begin
// 			doc = Document.new(response)
// 			//root = doc.root
// 			adsArray = Array.new()
// 			doc.elements.each("AdResponse/Ads/Ad") { |element| 
// 			br = BannerResponse.new()
// 			br.actionName = element.attributes['actionName']
// 			br.actionType = element.attributes['actionType']
// 			if(element.attributes['type'] == 'rm')
// 				br.isRichMedia = true;
// 			end

// 			br.adSize = AdSize.new(element.attributes['width'],element.attributes['height'])
// 			br.adURL = element.elements['AdURL'].text unless element.elements['AdURL'].nil?
// 			br.CDATA = element.text unless element.text.nil?
// 			if(br.isValid()) //check if all parameters were successfully fetched
// 				adsArray.push(br)
// 			end
// 		}
// 		rescue
// 			adsArray = nil
// 		end
// 		return adsArray
	
}
module.exports = BannerResponseParser;
