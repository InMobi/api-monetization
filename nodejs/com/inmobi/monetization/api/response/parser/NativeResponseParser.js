var NativeResponse = require('../ad/NativeResponse.js');
var Utils = require('../../utils/Utils.js');
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//This class can be used to obtain an ArrayList of NativeResponse objects, from
// the raw response(as String), obtained from the InMobi API 2.0 Server
// response.
// @author Rishabh Chowdhary
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function NativeResponseParser() {

}
NativeResponseParser.prototype.parseResponse = function(response) {
    if(Utils.isStringValid(response)) {
        var ads = [];
        try {
            var json = JSON.parse(response);
            var adsArray = json['ads'];
            for(i in adsArray) {
                var nr = new NativeResponse();
                nr.namespace = adsArray[i]['namespace'];
                nr.contextCode = adsArray[i]['contextCode'];
                nr.pubContent = adsArray[i]['contextCode'];
                if(nr.isValid()) {
                    ads[i] = nr;
                }
            }
        } catch(e) {
        }
        return ads;
    }
    return null;
    // adsArray = nil
    //     if(Utils.isStringValid(response)) 
            
    //         begin
    //             adsArray = Array.new()
    //             adsJson = JSON.parse(response)
    //             if(adsJson.empty? == false)
    //                 ads = adsJson['ads'];

    //                 if(ads != nil)
    //                     ads.each { |adJson|
    //                     ad = NativeResponse.new()
    //                     ad.pubContent = adJson['pubContent']
    //                     ad.contextCode = adJson['contextCode']
    //                     ad.namespace = adJson['namespace']
    //                     if(ad.isValid())
    //                         adsArray.push(ad)
    //                     end
    //                 }
    //                 end
    //             end
    //         rescue
    //             adsArray = nil
    //         end
            
    //     end
    //     return adsArray
}
module.exports = NativeResponseParser;