//
//  InMobiAPIMonetization_SampleTests.m
//  InMobiAPIMonetization-SampleTests
//
//  Created by Rishabh Chowdhary on 16/03/2015.
//  Copyright (c) 2015 InMobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "IMUtils.h"

@interface IM_UtilTest : XCTestCase

@end

@implementation IM_UtilTest

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.

    assert(false == [IMUtils isValidString:(nil)]);
    assert(false == [IMUtils isValidString:(@"")]);
    assert(false == [IMUtils isValidString:(@"   ")]);
    assert(true == [IMUtils isValidString:(@"sdf")]);
    assert(true == [IMUtils isValidString:(@" this is a response ")]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
