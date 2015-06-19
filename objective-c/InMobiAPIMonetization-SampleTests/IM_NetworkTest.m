//
//  InMobiAPIMonetization_SampleTests.m
//  InMobiAPIMonetization-SampleTests
//
//  Created by Rishabh Chowdhary on 16/03/2015.
//  Copyright (c) 2015 InMobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "IMRequestResponseManager.h"
#import "IMError.h"

@interface IM_NetworkTest : XCTestCase

@end

@implementation IM_NetworkTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testRequestResponseManager {
    // This is an example of a functional test case.
    
    IMRequestResponseManager *mgr = [[IMRequestResponseManager alloc] init];
    
    assert(nil ==  [mgr sendInMobiAdRequest:nil deviceIP:nil deviceUserAgent:nil]);

    assert(nil == [mgr sendInMobiAdRequest:nil deviceIP:@"" deviceUserAgent:@""]);

    assert(nil == [mgr sendInMobiAdRequest:nil deviceIP:@"  " deviceUserAgent:@""]);

    assert(nil == [mgr sendInMobiAdRequest:nil deviceIP:@"6.0.0.1" deviceUserAgent:@"user-agent"]);
    
   
    assert(nil == [mgr sendInMobiAdRequest:[[NSData alloc] init] deviceIP:@"6.0.0.1" deviceUserAgent:@"Mozilla/5.0 (iPhone; CPU iPhone OS 8_0 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A334 Safari/7534.48.3"]);
}


@end
