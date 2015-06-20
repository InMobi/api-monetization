//
//  IMNativeAdRequest.m
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

#import "IMRequest.h"
#import "IMJSONPayloadCreator.h"

@interface IMRequest ()
@property(nonatomic,copy) NSString *requestFormat;
@end

@implementation IMRequest


- (id)initWithProperty:(IMProperty *)p device:(IMDevice *)d impression:(IMImpression *)imp
                  user:(IMUser *)us {
    if (self = [super init]) {
        self.property = p;
        self.impression = imp;
        self.device = d;
        self.user = us;
    }
    return self;
}

- (BOOL)isValid {
    BOOL isValid = NO;
    
    if (_property != NULL && [_property isValid]) {
        if (_device != NULL && [_device isValid]) {
            
            if (_requestType == IMAdRequestTypeNative) {
                // impression object is not mandatory for native ads.
                isValid = YES;
            } else {
                if (_requestType == IMAdRequestTypeBanner || _requestType == IMAdRequestTypeInterstitial) {
                    if (_impression != NULL && [_impression isValid]) {
                        isValid = YES;
                        // don't check for UserObject, as its optional..
                        // checking for it may invoke publisher to pass invalid
                        // arguments.
                    } else {
                        NSLog(@"Please provide a valid impression object in the request");
                    }
                } else {
                    NSLog(@"Please set a valid ad request type");
                }
            }
        } else {
            NSLog(@"Please provide a valid device object in the request");
        }
    } else {
        NSLog(@"Please provide a valid property object in the request");
    }

    
    return isValid;
}
- (NSData *)toJSON {
    return [IMJSONPayloadCreator generateRequestPayload:self];
}

@end


