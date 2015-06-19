//
//  InMobiAPIMonetization_SampleTests.m
//  InMobiAPIMonetization-SampleTests
//
//  Created by Rishabh Chowdhary on 16/03/2015.
//  Copyright (c) 2015 InMobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "IMBanner.h"
#import "IMInterstitial.h"
#import "IMNative.h"

@interface IM_AdsTest : XCTestCase

@end

@implementation IM_AdsTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testBanner {
    // This is an example of a functional test case.
    IMBanner *banner = [[IMBanner alloc] init];
    [banner loadRequest:nil successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for a nil request");
    } failureBlock:^(NSError *e) {
        
    }];
    [banner loadRequest:[[IMRequest alloc] init] successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for an invalid request");
    } failureBlock:^(NSError *e) {
        
    }];
    
    IMRequest *request = [[IMRequest alloc] init];
    request.property = [[IMProperty alloc] initWithPropertyID:@"sdf"];
    [banner loadRequest:request successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for a nil request");
    } failureBlock:^(NSError *e) {
        
    }];
    [banner loadRequest:[[IMRequest alloc] init] successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for an invalid request");
    } failureBlock:^(NSError *e) {
        
    }];
    
    request.device = [[IMDevice alloc] init];
    [banner loadRequest:request successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for a nil request");
    } failureBlock:^(NSError *e) {
        
    }];
    [banner loadRequest:[[IMRequest alloc] init] successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for an invalid request");
    } failureBlock:^(NSError *e) {
        
    }];
    
    request.impression = [[IMImpression alloc] init];
    [banner loadRequest:request successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for a nil request");
    } failureBlock:^(NSError *e) {
        
    }];
    [banner loadRequest:[[IMRequest alloc] init] successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for an invalid request");
    } failureBlock:^(NSError *e) {
        
    }];
    request.impression.slot = [[IMSlot alloc] init];
    [banner loadRequest:request successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for a nil request");
    } failureBlock:^(NSError *e) {
        
    }];
    [banner loadRequest:[[IMRequest alloc] init] successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for an invalid request");
    } failureBlock:^(NSError *e) {
        
    }];
    
    request.impression.slot = [[IMSlot alloc] initWithAdSize:-1 pos:nil];
    [banner loadRequest:request successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for a nil request");
    } failureBlock:^(NSError *e) {
        
    }];
    [banner loadRequest:[[IMRequest alloc] init] successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for an invalid request");
    } failureBlock:^(NSError *e) {
        
    }];
    request.impression.slot = [[IMSlot alloc] initWithAdSize:10 pos:nil];
    [banner loadRequest:request successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for a nil request");
    } failureBlock:^(NSError *e) {
        
    }];
    [banner loadRequest:[[IMRequest alloc] init] successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for an invalid request");
    } failureBlock:^(NSError *e) {
        
    }];
    request.device = [[IMDevice alloc] initWithCarrierIP:@"6.0.0.0"];
    [banner loadRequest:[[IMRequest alloc] init] successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for an invalid request");
    } failureBlock:^(NSError *e) {
        
    }];
}

- (void)testInterstitial {
    IMInterstitial *interstitial = [[IMInterstitial alloc] init];
    [interstitial loadRequest:nil successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for a nil request");
    } failureBlock:^(NSError *e) {
        
    }];
    [interstitial loadRequest:[[IMRequest alloc] init] successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for an invalid request");
    } failureBlock:^(NSError *e) {
        
    }];
    
    IMRequest *request = [[IMRequest alloc] init];
    request.property = [[IMProperty alloc] initWithPropertyID:@"sdf"];
    [interstitial loadRequest:request successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for a nil request");
    } failureBlock:^(NSError *e) {
        
    }];
    [interstitial loadRequest:[[IMRequest alloc] init] successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for an invalid request");
    } failureBlock:^(NSError *e) {
        
    }];
    
    request.device = [[IMDevice alloc] init];
    [interstitial loadRequest:request successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for a nil request");
    } failureBlock:^(NSError *e) {
        
    }];
    [interstitial loadRequest:[[IMRequest alloc] init] successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for an invalid request");
    } failureBlock:^(NSError *e) {
        
    }];
    
    request.impression = [[IMImpression alloc] init];
    [interstitial loadRequest:request successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for a nil request");
    } failureBlock:^(NSError *e) {
        
    }];
    [interstitial loadRequest:[[IMRequest alloc] init] successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for an invalid request");
    } failureBlock:^(NSError *e) {
        
    }];
    request.impression.slot = [[IMSlot alloc] init];
    [interstitial loadRequest:request successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for a nil request");
    } failureBlock:^(NSError *e) {
        
    }];
    [interstitial loadRequest:[[IMRequest alloc] init] successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for an invalid request");
    } failureBlock:^(NSError *e) {
        
    }];
    
    request.impression.slot = [[IMSlot alloc] initWithAdSize:-1 pos:nil];
    [interstitial loadRequest:request successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for a nil request");
    } failureBlock:^(NSError *e) {
        
    }];
    [interstitial loadRequest:[[IMRequest alloc] init] successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for an invalid request");
    } failureBlock:^(NSError *e) {
        
    }];
    request.impression.slot = [[IMSlot alloc] initWithAdSize:10 pos:nil];
    [interstitial loadRequest:request successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for a nil request");
    } failureBlock:^(NSError *e) {
        
    }];
    [interstitial loadRequest:[[IMRequest alloc] init] successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for an invalid request");
    } failureBlock:^(NSError *e) {
        
    }];
    request.device = [[IMDevice alloc] initWithCarrierIP:@"6.0.0.0"];
    [interstitial loadRequest:[[IMRequest alloc] init] successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for an invalid request");
    } failureBlock:^(NSError *e) {
        
    }];
}
- (void)testNative {
    IMNative *native = [[IMNative alloc] init];
    [native loadRequest:nil successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for a nil request");
    } failureBlock:^(NSError *e) {
        
    }];
    [native loadRequest:[[IMRequest alloc] init] successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for an invalid request");
    } failureBlock:^(NSError *e) {
        
    }];
    
    IMRequest *request = [[IMRequest alloc] init];
    request.property = [[IMProperty alloc] initWithPropertyID:@"sdf"];
    [native loadRequest:request successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for a nil request");
    } failureBlock:^(NSError *e) {
        
    }];
    [native loadRequest:[[IMRequest alloc] init] successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for an invalid request");
    } failureBlock:^(NSError *e) {
        
    }];
    
    request.device = [[IMDevice alloc] init];
    [native loadRequest:request successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for a nil request");
    } failureBlock:^(NSError *e) {
        
    }];
    [native loadRequest:[[IMRequest alloc] init] successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for an invalid request");
    } failureBlock:^(NSError *e) {
        
    }];
    
    request.impression = [[IMImpression alloc] init];
    [native loadRequest:request successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for a nil request");
    } failureBlock:^(NSError *e) {
        
    }];
    [native loadRequest:[[IMRequest alloc] init] successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for an invalid request");
    } failureBlock:^(NSError *e) {
        
    }];
    request.impression.slot = [[IMSlot alloc] init];
    [native loadRequest:request successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for a nil request");
    } failureBlock:^(NSError *e) {
        
    }];
    [native loadRequest:[[IMRequest alloc] init] successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for an invalid request");
    } failureBlock:^(NSError *e) {
        
    }];
    
    request.impression.slot = [[IMSlot alloc] initWithAdSize:-1 pos:nil];
    [native loadRequest:request successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for a nil request");
    } failureBlock:^(NSError *e) {
        
    }];
    [native loadRequest:[[IMRequest alloc] init] successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for an invalid request");
    } failureBlock:^(NSError *e) {
        
    }];
    request.impression.slot = [[IMSlot alloc] initWithAdSize:10 pos:nil];
    [native loadRequest:request successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for a nil request");
    } failureBlock:^(NSError *e) {
        
    }];
    [native loadRequest:[[IMRequest alloc] init] successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for an invalid request");
    } failureBlock:^(NSError *e) {
        
    }];
    request.device = [[IMDevice alloc] initWithCarrierIP:@"6.0.0.0"];
    [native loadRequest:[[IMRequest alloc] init] successBlock:^(NSArray *ads) {
        XCTFail(@"Cannot provide success for an invalid request");
    } failureBlock:^(NSError *e) {
        
    }];
}

@end
