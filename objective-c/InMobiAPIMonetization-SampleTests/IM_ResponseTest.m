//
//  InMobiAPIMonetization_SampleTests.m
//  InMobiAPIMonetization-SampleTests
//
//  Created by Rishabh Chowdhary on 16/03/2015.
//  Copyright (c) 2015 InMobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "IMBannerResponseParser.h"
#import "IMNativeResponseParser.h"
#import "GTMBase64Private.h"

@interface IM_ResponseTest : XCTestCase

@end

@implementation IM_ResponseTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (NSData *)toData:(NSString *)input {
    if (input) {
        return [input dataUsingEncoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (void)testBannerResponseParser {
    // This is an example of a functional test case.
    IMBannerResponseParser *parser = [[IMBannerResponseParser alloc] init];
    assert(0 == [parser parseAdsFromResponse:(nil)]);
    assert(0 == [[parser parseAdsFromResponse:([self toData:@""])] count]);
    assert(0 == [[parser parseAdsFromResponse:([self toData:@"   "])] count]);
    assert(0 == [[parser parseAdsFromResponse:([self toData:@"nil"])] count]);
    assert(0 == [[parser parseAdsFromResponse:([self toData:@"<AdResponse></AdResponse>"])] count]);
    assert(0 == [[parser parseAdsFromResponse:([self toData:@"<AdResponse><Ads></Ads></AdResponse>"])] count]);
    assert(0 == [[parser parseAdsFromResponse:([self toData:@"<AdResponse><Ads></Ads><Ad></Ad></AdResponse>"])] count]);
    assert(0 == [[parser parseAdsFromResponse:([self toData:@"<AdResponse><Ads><Ad width='320' height='50'></Ad></Ads></AdResponse>"])] count]);
    assert(0 == [[parser parseAdsFromResponse:([self toData:@"<AdResponse><Ads><Ad width='320' height='50' actionName='appStore'></Ad></Ads></AdResponse>"])] count]);
    assert(0 == [[parser parseAdsFromResponse:([self toData:@"<AdResponse><Ads><Ad width='320' height='50' actionName='appStore'><AdURL>http://inmobi.com</AdURL></Ad></Ads></AdResponse>"])] count]);
    assert(0 == [[parser parseAdsFromResponse:([self toData:@"<AdResponse><Ads><Ad width='320' height='50' actionName='appStore' actionType='1'><AdURL>http://inmobi.com</AdURL></Ad></Ads></AdResponse>"])] count]);
    assert(0 == [[parser parseAdsFromResponse:([self toData:@"<AdResponse><Ads><Ad width='320' height='50' actionName='appStore' actionType='1'><AdURL>http://inmobi.com</AdURL><![CDATA[]]></Ad></Ads></AdResponse>"])] count]);
    assert(1 == [[parser parseAdsFromResponse:([self toData:@"<AdResponse><Ads><Ad width='320' height='50' actionName='appStore' actionType='1'><AdURL>http://inmobi.com</AdURL><![CDATA[This is an ad]]></Ad></Ads></AdResponse>"])] count]);
    assert(1 == [[parser parseAdsFromResponse:([self toData:@"<AdResponse><Ads><Ad width='320' height='50' actionName='appStore' actionType='1'><![CDATA[This is an ad]]></Ad></Ads></AdResponse>"])] count]);
}

- (void)testBannerResponse {
    IMBannerResponse *br = [[IMBannerResponse alloc] init];
    NSString *cdata = @"this is cdata";
    br.CDATA = cdata;
    assert(cdata == br.CDATA);
    br.actionType = 1;
    assert(1 == br.actionType);
    NSString *name = @"appStore";
    br.actionName = name;
    assert(name == br.actionName);
    NSString *url = @"http://inmobi.com";
    br.adURL = url;
    assert(url == br.adURL);
    BOOL rm = false;
    br.isRichMedia = rm;
    assert(rm == br.isRichMedia);
    IMAdSize *adsize = [[IMAdSize alloc] init];
    br.adSize = adsize;
    assert(adsize == br.adSize);
    
    assert(true == [br isValid]);
    br.CDATA = nil;
    assert(false == [br isValid]);
    br = [[IMBannerResponse alloc] init];
    assert(false == [br isValid]);
    
    int width = 320;int height=50;
    adsize.width = width;
    assert(width == adsize.width);
    
    adsize.height = height;
    assert(height == adsize.height);
    
}

- (void)testNativeResponse {
    IMNativeResponse *nr = [[IMNativeResponse alloc] init];;
    assert(false == [nr isValid]);
    NSString *pubcontent = @"pubcontent";
    nr.pubContent = pubcontent;
    assert(pubcontent == nr.pubContent);
    
    NSString *contextcode = @"contextcode";
    nr.contextCode = contextcode;
    assert(contextcode == nr.contextCode);
    
    NSString *ns = @"namespace";
    nr.ns = ns;
    assert(ns == nr.ns);
    
    assert(true == [nr isValid]);

    nr.pubContent = nil;
    assert(false == [nr isValid]);
    
    nr.contextCode = nil;
    assert(false == [nr isValid]);
    
    nr.ns = nil;
    assert(false == [nr isValid]);
    
    nr.ns = @"namespace";
    assert(false == [nr isValid]);
    nr.contextCode = @"contextcode";
    assert(false == [nr isValid]);
    
    nr.pubContent = @"pubContent";
    assert(true == [nr isValid]);
    
    nr.pubContent = nil;
    assert(nil == [nr convertPubContentToJSON]);
    nr.pubContent = @"";
    assert(nil == [nr convertPubContentToJSON]);
    nr.pubContent = @"   ";
    assert(nil == [nr convertPubContentToJSON]);
    NSString *sdf = @"sdf";
    nr.pubContent = sdf;
    assert([@"" isEqualToString: [nr convertPubContentToJSON]]);
    
    nr.pubContent = [[NSString alloc] initWithData:[GTMBase64Private encodeData:[sdf dataUsingEncoding:NSUTF8StringEncoding]] encoding:NSUTF8StringEncoding];
    assert([sdf isEqualToString:[nr convertPubContentToJSON]]);
    
    sdf = @"eyJ0aXRsZSI6Ilp5bmdhIFBva2VyIC0gVGV4YXMgSG9sZGUiLCJkZXNjcmlwdGlvbiI6IuKAnFRoZSBsYXJnZXN0IHBva2VyIHNpdGUgaW4gdGhlIHdvcmxk4oCm4oCdIOKAkyBFU1BOLkNPTSBaeW5nYSBQb2tlciBvZmZlcnMgYW4gYXV0aGVudGljIHBva2VyIGV4cGVyaWVuY2UiLCJpY29uIjp7ImhlaWdodCI6MTUwLCJ3aWR0aCI6MTUwLCJhc3BlY3RSYXRpbyI6MSwidXJsIjoiaHR0cDovL21raG9qLWF2LnMzLmFtYXpvbmF3cy5jb20vMzU0OTAyMzE1LXVzLTE0MjQyMDA5MTg3NjUifSwic2NyZWVuc2hvdHMiOnsiaGVpZ2h0IjozMDAsIndpZHRoIjoyNTAsImFzcGVjdFJhdGlvIjowLjgzLCJ1cmwiOiJodHRwOi8vYWR0b29scy1hLmFrYW1haWhkLm5ldC9uYXRpdmVhZHMvcHJvZC9pbWFnZXMvNjY5NzM3MDIwOTE1NTkyODk3MzM4ZmMxZi01ZTM5LTRjNzYtYTkyNC03ZjA5NTNjMmZkZmEuanBnIn0sImxhbmRpbmdfdXJsIjoiaHR0cHM6Ly9pdHVuZXMuYXBwbGUuY29tL2FwcC9wb2tlci1ieS16eW5nYS9pZDM1NDkwMjMxNT9tdFx1MDAzZDgiLCJjdGEiOiJJbnN0YWxsIn0=";
    nr.pubContent = [[NSString alloc] initWithData:[GTMBase64Private encodeData:[sdf dataUsingEncoding:NSUTF8StringEncoding]] encoding:NSUTF8StringEncoding];;
    assert([sdf isEqualToString:[nr convertPubContentToJSON]]);
}

- (void)testNativeResponseParser {
    IMNativeResponseParser *parser = [[IMNativeResponseParser alloc] init];
    assert(nil == [parser parseAdsFromResponse:(nil)]);
    assert(nil == [parser parseAdsFromResponse:([self toData:@""])]);
    assert(nil == [parser parseAdsFromResponse:([self toData:@"  "])]);
    assert(nil == [parser parseAdsFromResponse:([self toData:@"sdf"])]); //Invalid JSON
    assert(nil == [parser parseAdsFromResponse:([self toData:@"<AdResponse><Ads><Ad></Ads></AdResponse>"])]); //Invalid json
    assert(nil == [parser parseAdsFromResponse:([self toData:@"<AdResponse><Ads><Ad width='320' height='50' actionName='appStore' actionType='1'><![CDATA[This is an ad]]></Ad></Ads></AdResponse>"])]);
    assert(0 == [[parser parseAdsFromResponse:[self toData:@"{}"]] count]);
    assert(0 == [[parser parseAdsFromResponse:[self toData:@"{\"ads\":[]}"]] count]);
    assert(0 == [[parser parseAdsFromResponse:[self toData:@"{\"ads\":[{}]}"]] count]);
    assert(0 == [[parser parseAdsFromResponse:[self toData:@"{\"ads\":[{\"pubContent\":\"\",\"contextCode\":\"\",\"namespace\":\"\"}]}"]] count]);
    assert(0 == [[parser parseAdsFromResponse:[self toData:@"{\"ads\":[{\"pubContent\":\"pubContent\",\"contextCode\":\"contextCode\",\"namespace\":\"\"}]}"]] count]);
    assert(1 == [[parser parseAdsFromResponse:[self toData:@"{\"ads\":[{\"pubContent\":\"pubContent\",\"contextCode\":\"contextCode\",\"namespace\":\"ns\"}]}"]] count]);

}

@end
