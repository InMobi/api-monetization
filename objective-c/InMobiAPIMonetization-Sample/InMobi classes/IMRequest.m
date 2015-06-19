//
//  IMNativeAdRequest.m
//  Native ad sample
//
//

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


