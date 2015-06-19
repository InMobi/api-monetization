//
//  InMobiAPIMonetization_SampleTests.m
//  InMobiAPIMonetization-SampleTests
//
//  Created by Rishabh Chowdhary on 16/03/2015.
//  Copyright (c) 2015 InMobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "IMRequestStubs.h"
#import "IMRequest.h"

@interface IM_RequestTest : XCTestCase

@end

@implementation IM_RequestTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSlot {
    // This is an example of a functional test case.
    IMSlot *slotObj = [[IMSlot alloc] initWithAdSize:15 pos:nil];
    int adSize = -1;
    slotObj.adSize = adSize;
    
// adSize must be >= 1
    assert(false == [slotObj isValid]);
    
    adSize = 15;
    slotObj.adSize = adSize;
    assert(true == [slotObj isValid]);
    assert(15 == slotObj.adSize);
    
    NSString *pos = @"top";
    slotObj.position = pos;
    assert(pos == slotObj.position);
    
    adSize = -1;
    pos = @"  ";
    slotObj = [[IMSlot alloc] initWithAdSize:adSize pos:pos];
    assert(false ==  [slotObj isValid]);
    
    adSize = 5;
    pos = @"bottom";
    slotObj = [[IMSlot alloc] initWithAdSize:adSize pos:pos];
    assert(true ==  [slotObj isValid]);
    
    adSize = 5;
    pos = @"";
    slotObj = [[IMSlot alloc] initWithAdSize:adSize pos:pos];
    assert(true == [slotObj isValid]);
    
    adSize = 5;
    pos = @"   ";
    slotObj = [[IMSlot alloc] initWithAdSize:adSize pos:pos];
    assert(true == [slotObj isValid]);
    
    adSize = 5;
    slotObj = [[IMSlot alloc] initWithAdSize:adSize pos:pos];
    assert(true == [slotObj isValid]);
    
    slotObj = [[IMSlot alloc] initWithAdSize:-1 pos:@"sdf"];
    assert(false ==  [slotObj isValid]);
    
    slotObj = [[IMSlot alloc] initWithAdSize:10 pos:nil];
    assert(true == [slotObj isValid]);
}

- (void)testDevice {
    IMDevice *device = [[IMDevice alloc] init];
    assert(false == [device isValid]);
    
// geo
    device.geo = [[IMGeo alloc] init];
    assert(false == [device isValid]);
// ip
    NSString *ip = @"6.0.0.0";
    device.carrierIP = ip;
    assert([ip isEqualToString:device.carrierIP]);
    
    assert(true == [device isValid]);

    device.carrierIP = nil;
    assert(false == [device isValid]);
    
    device = [[IMDevice alloc] initWithCarrierIP:ip];
    assert([ip isEqualToString:device.carrierIP]);
    assert(true == [device isValid]);
}

- (void)testGeo {
    IMGeo *geo = [[IMGeo alloc] init];
    
    float lat = 92;
    float lon = 114.11;
    int accu = 50;
    geo = [[IMGeo alloc] init];
    geo.lat = lat, geo.lon = lon, geo.accu = accu;
    assert(false == [geo isValid]);
    
    lat = -12.11;
    lon = 114.11;
    accu = 50;
    geo.lat = lat, geo.lon = lon, geo.accu = accu;
    assert(true == [geo isValid]);
    lat = -12.11;
    lon = -114.37;
    accu = 50;
    geo.lat = lat, geo.lon = lon, geo.accu = accu;
    assert(true == [geo isValid]);
    lat = 12.11;
    lon = -114.11;
    accu = 50;
    geo.lat = lat, geo.lon = lon, geo.accu = accu;
    assert(true == [geo isValid]);
    
    lat = -112.11;
    lon = 114.12;
    accu = 50;
    geo.lat = lat, geo.lon = lon, geo.accu = accu;
    assert(false == [geo isValid]);
    lat = 112.99;
    lon = 114.11;
    accu = 50;
    geo.lat = lat, geo.lon = lon, geo.accu = accu;
    assert(false == [geo isValid]);
    lat = 12.37;
    lon = -183.11;
    accu = 50;
    geo.lat = lat, geo.lon = lon, geo.accu = accu;
    assert(false == [geo isValid]);
    lat = -12.11;
    lon = 183.23;
    accu = 50;
    geo.lat = lat, geo.lon = lon, geo.accu = accu;
    assert(false == [geo isValid]);
    lat = -12.11;
    lon = 114.12;
    accu = -50;
    geo.lat = lat, geo.lon = lon, geo.accu = accu;
    assert(false == [geo isValid]);
  		
}


- (void)testProperty {
    IMProperty *prop = [[IMProperty alloc] initWithPropertyID:nil];
    NSString *property = @"";
    prop.propertyId = property;
    assert( [property isEqualToString:prop.propertyId]);
    assert(false == [prop isValid]);
    
    property = @"   ";
    prop.propertyId = property;
    assert( [property isEqualToString:prop.propertyId]);
    assert(false == [prop isValid]);
    
    property = @"asdfasdfs";
    prop.propertyId = property;
    assert(property == prop.propertyId);
    assert(true == [prop isValid]);
    
    prop = [[IMProperty alloc] initWithPropertyID:@"   "];
    assert(false == [prop isValid]);
    
    prop = [[IMProperty alloc] init];
    assert(false == [prop isValid]);
    
    prop = [[IMProperty alloc] initWithPropertyID:property];
    assert([property isEqualToString:prop.propertyId]);
    assert(true == [prop isValid]);
}

- (void)testRequest {
    IMRequest *request = [[IMRequest alloc] init];
    assert(false == [request isValid]);
    request = [[IMRequest alloc] initWithProperty:nil device:nil impression:nil user:nil];
    assert(false == [request isValid]);
    
    request.property = [[IMProperty alloc] init];
    assert(false == [request isValid]);
    
    request.property = [[IMProperty alloc] initWithPropertyID:@"sdf"];
    assert(false == [request isValid]);
    
    request.device = [[IMDevice alloc] init];
    assert(false == [request isValid]);
    
    IMDevice *device = [[IMDevice alloc] init];
    device.carrierIP = @"carrierIP";
    request.device = device;
    
    assert(false == [request isValid]);
    
    request.impression = [[IMImpression alloc] initWithSlot:nil];
    assert(false == [request isValid]);
    
    request.impression = [[IMImpression alloc] initWithSlot:[[IMSlot alloc] initWithAdSize:-1 pos:nil]];
    assert(false == [request isValid]);
    
    request.impression = [[IMImpression alloc] initWithSlot:[[IMSlot alloc] initWithAdSize:-1 pos:@"top"]];
    assert(false == [request isValid]);
    
    request.impression = [[IMImpression alloc] initWithSlot:[[IMSlot alloc] initWithAdSize:15 pos:nil]];
    assert(false == [request isValid]);
    
    request.requestType = IMAdRequestTypeBanner;
    assert(true == [request isValid]);
}

@end
