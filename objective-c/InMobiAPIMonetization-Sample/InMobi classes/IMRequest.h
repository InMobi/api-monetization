//
//  IMNativeAdRequest.h
//  Native ad sample
//
//////////////////////////////////////////////////////////////////////
//Copyright © 2015 InMobi Technologies Pte. Ltd. All rights reserved.

//MIT License

//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:

//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.
////////////////////////////////////////////////////////////////////////////////

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

