//
//  IMStubs.m
//  Native ad sample
//
//

#import "IMRequestStubs.h"
#import <UIKit/UIKit.h>
#import <AdSupport/AdSupport.h>
#import "IMRequest.h"

@implementation IMProperty
@synthesize propertyId;

- (id)initWithPropertyID:(NSString *)ID {
    if (self = [super init]) {
        self.propertyId = ID;
    }
    return self;
}

- (BOOL)isValid {
    return [IMUtils isValidString:propertyId];
}

@end

@implementation IMImpression


- (id)init {
    if (self = [super init]) {
        _noOfAds = 1;
        self.displayManager = @"c_imapi_objc";
        self.displayManagerVersion = @"1.0.0";
    }
    return self;
}

- (void)setNoOfAds:(int)no {
    if (no < 1) {
        _noOfAds = 1;
    }
    else if (no > 3) {
        _noOfAds = 3;
    } else {
        _noOfAds = no;
    }
}
- (BOOL)isValid {
    if (_slot != NULL) {
        return [_slot isValid];
    }
    return NO;
}

- (id)initWithSlot:(IMSlot *)s {
    if (self = [self init]) {
        self.slot = s;
        
    }
    return self;
}

@end

@implementation IMDevice


- (id)init {
    if (self = [super init]) {
        [self performSelectorOnMainThread:@selector(fetchUserAgent) withObject:nil waitUntilDone:YES];
        _IDFA = [[NSString alloc] initWithString:[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString]];
        _IDV = [[NSString alloc] initWithString:[[[UIDevice currentDevice] identifierForVendor] UUIDString]];
        self.adt = [[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled];
    }
    return self;
}

- (id)initWithCarrierIP:(NSString *)ip {
    if (self = [self init]) {
        self.carrierIP = ip;
    }
    return self;
}

- (void)fetchUserAgent {
    UIWebView *w = [[UIWebView alloc] init];
    _userAgent = [[NSString alloc] initWithString:[w stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"]];
    _userAgent = [[NSString alloc] initWithFormat:@"Mozilla/5.0 (iPhone; CPU iPhone OS 8_0 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Mobile/12B411"];
}
- (BOOL)isValid {
    BOOL isValid = NO;
    if([IMUtils isValidString:_carrierIP] && [IMUtils isValidString:_userAgent]) {
        isValid = YES;
    } else {
        if(![IMUtils isValidString:_carrierIP]) {
            NSLog(@"Carrier IP is mandatory in the request");
        }
        if(![IMUtils isValidString:_userAgent]) {
            NSLog(@"Valid Mobile User Agent is mandatory in the request");
        }
    }
    
    return isValid;
}

@end

@interface IMGeo  ()<CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
}

@end

@implementation IMGeo
@synthesize lat,lon,accu;
#define NOT_VALID  0

- (id)init {
    if (self = [super init]) {
        lat = lon = NOT_VALID;
        accu = NOT_VALID;
        if ([CLLocationManager locationServicesEnabled]) {
            locationManager = [[CLLocationManager alloc] init];
        }
    }
    return self;
}
- (void)setLat:(double)_lat {
    if(_lat > -90 && _lat < 90) {
        lat = _lat;
    } else {
        lat = NOT_VALID;
    }
}
- (void)setLon:(double)_lon {
    if(_lon > -180 && _lon < 180) {
        lon = _lon;
    } else {
        lat = NOT_VALID;
    }
}
- (void)setAccu:(int)a {
    if (a > 0) {
        accu = a;
    } else {
        accu = NOT_VALID;
    }
}

- (void)setLocation:(CLLocation *)location {
    if (location) {
        lat = location.coordinate.latitude;
        lon = location.coordinate.longitude;
        accu = location.horizontalAccuracy;
    }
}

- (BOOL)isValid {
    BOOL isValid = NO;
    if(accu != NOT_VALID && (abs(lat - NOT_VALID) > 0.00001)
       && (abs(lon - NOT_VALID) > 0.00001)) {
        isValid = YES;
    }
    return isValid;
}

@end

@implementation IMUser
@synthesize yob,dataObj,gender;

- (id)init {
    if (self = [super init]) {
        gender = IMGenderNone;
    }
    return self;
}
- (BOOL)isValid {
    BOOL isValid = YES;
    
    //UserObject has optional arguments..
    if(dataObj != NULL) {
        isValid = [dataObj isValid];
    }
    return isValid;
}

@end

@implementation IMSlot
@synthesize adSize,position;

- (BOOL)isValid {
    if(adSize <= 0) {
        return  NO;
    }
    return YES;
}
- (id)initWithAdSize:(int)size pos:(NSString *)pos {
    if (self = [super init]) {
        self.adSize = size;
        self.position = pos;
    }
    return self;
}

@end

@implementation IMData
@synthesize ID,name,segmentObj;

- (id)init {
    if (self = [super init]) {
        ID = 0;
    }
    return self;
}
- (BOOL)isValid {
    return YES;
}

@end

@implementation IMUserSegment
@synthesize userSegmentArray;

- (BOOL) isValid {
    return YES;
}

@end
