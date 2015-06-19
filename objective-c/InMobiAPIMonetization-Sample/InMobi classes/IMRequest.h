//
//  IMNativeAdRequest.h
//  Native ad sample
//
//

#import <Foundation/Foundation.h>
#import "IMRequestStubs.h"


/**
 * This class can be used to request InMobi ads. 
 * To request inmobi ads, use a subclass instance for specific banner/interstitial or native ads.
 * Mandatory parameters for a valid request: Site-id, carrierIP, adSize( valid for banner/int ads)
 * User-agent is fetched from UIWebView directly.
 */

@interface IMRequest : NSObject <IMValidator>

/**
 * The original carrier IP address of the device.
 * @note Please do not provide the internal IP(for eg. 10.14.x.y or 192.168.x.y )
 * as InMobi would terminate the request.
 */

@property(nonatomic,retain) IMImpression *impression;
@property(nonatomic,retain) IMUser *user;
@property(nonatomic,retain) IMProperty *property;
@property(nonatomic,retain) IMDevice *device;
@property(nonatomic,assign) IMAdRequestType requestType;

- (id)initWithProperty:(IMProperty *)p device:(IMDevice *)d impression:(IMImpression *)imp
                  user:(IMUser *)us;
- (NSData *)toJSON;

@end

