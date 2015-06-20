//
//  IMJSONPayloadCreator.m
//  InMobiAPIMonetization-Sample
//
//  Created by Rishabh Chowdhary on 16/03/2015.

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

#import "IMJSONPayloadCreator.h"
#import "IMRequest.h"

@implementation IMJSONPayloadCreator

+ (NSData *)generateRequestPayload:(IMRequest *)request {
    NSMutableDictionary *mainDictionary = [[NSMutableDictionary alloc] init];
    if (![request isValid]) {
        return NULL;
    }
    //request format
    if (request.requestType != IMAdRequestTypeNative) {
        [mainDictionary setObject:@"axml" forKey:@"responseformat"];
    } else {
        [mainDictionary setObject:@"native" forKey:@"responseformat"];
    }
    
    
    //site format
    NSDictionary *siteDictionary = @{@"id": request.property.propertyId};
    [mainDictionary setObject:siteDictionary forKey:@"site"];
    
    NSMutableDictionary *bannerDictionary = [[NSMutableDictionary alloc] init];
    
    NSString *pos = request.impression.slot.position;
    if (pos != nil) {
        [bannerDictionary setObject:pos forKey:@"pos"];
    }
    if (request.requestType != IMAdRequestTypeNative) {
        [bannerDictionary setObject:[NSNumber numberWithInt:request.impression.slot.adSize] forKey:@"adsize"];
    }
    
    NSMutableDictionary *impressionDictionary = [[NSMutableDictionary alloc] init];
    if ([bannerDictionary count] > 0) {
        [impressionDictionary setObject:bannerDictionary forKey:@"banner"];
    }
    [impressionDictionary setObject:[NSNumber numberWithInt:request.impression.noOfAds] forKey:@"ads"];
    NSString *displayMgr = request.impression.displayManager;
    if (displayMgr) {
        [impressionDictionary setObject:displayMgr forKey:@"displaymanager"];
    }
    NSString *displayMgrVer = request.impression.displayManagerVersion;
    if (displayMgrVer) {
        [impressionDictionary setObject:displayMgrVer forKey:@"displaymanagerver"];
    }
    //adtype=int
    if (request.requestType == IMAdRequestTypeInterstitial) {
        [impressionDictionary setObject:@"int" forKey:@"adtype"];
    }
    // impression object is an array
    NSArray *impArray = [NSArray arrayWithObject:impressionDictionary];
    [mainDictionary setObject:impArray forKey:@"imp"];
    
    NSMutableDictionary *userDictionary = [[NSMutableDictionary alloc] init];
    IMUser *user = request.user;
    if (user.yob > 0) {
        [userDictionary setObject:[NSNumber numberWithInt:user.yob] forKey:@"yob"];
    }
    if (user.gender != IMGenderNone) {
        if (user.gender == IMGenderMale) {
            [userDictionary setObject:@"M" forKey:@"gender"];
        } else if(user.gender == IMGenderFemale) {
            [userDictionary setObject:@"F" forKey:@"gender"];
        }
    }
    NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] init];
    IMData *data = user.dataObj;
    if (data.ID > 0) {
        [dataDictionary setObject:[NSString stringWithFormat:@"%d",data.ID] forKey:@"id"];
    }
    if (data.name) {
        [dataDictionary setObject:data.name forKey:@"name"];
    }
    if (data.segmentObj) {
        [dataDictionary setObject:data.segmentObj.userSegmentArray forKey:@"segment"];
    }
    if ([dataDictionary count] > 0) {
        NSArray *dataArray = [NSArray arrayWithObject:dataDictionary];
        [userDictionary setObject:dataArray forKey:@"data"];
        [mainDictionary setObject:userDictionary forKey:@"user"];
    }
    
    NSMutableDictionary *deviceDictionary = [[NSMutableDictionary alloc] init];
    
    [deviceDictionary setObject:request.device.carrierIP forKey:@"ip"];
    [deviceDictionary setObject:request.device.userAgent forKey:@"ua"];
    [deviceDictionary setObject:request.device.IDFA forKey:@"ida"];
    [deviceDictionary setObject:request.device.IDV forKey:@"idv"];
    [deviceDictionary setObject:[NSNumber numberWithInt:request.device.adt] forKey:@"adt"];
    
    IMGeo *geo = request.device.geo;
    if (geo.accu != 0) {
        NSMutableDictionary *geoDictionary = [[NSMutableDictionary alloc] init];
        [geoDictionary setValue:[NSString stringWithFormat:@"%f",geo.lat] forKey:@"lat"];
        [geoDictionary setValue:[NSString stringWithFormat:@"%f",geo.lon] forKey:@"lon"];
        [geoDictionary setValue:[NSString stringWithFormat:@"%d",geo.accu] forKey:@"accu"];
        
        [deviceDictionary setObject:geoDictionary forKey:@"geo"];
    }
    
    
    [mainDictionary setObject:deviceDictionary forKey:@"device"];
    
    return [NSJSONSerialization dataWithJSONObject:mainDictionary options:NSJSONWritingPrettyPrinted error:nil];
}

@end
