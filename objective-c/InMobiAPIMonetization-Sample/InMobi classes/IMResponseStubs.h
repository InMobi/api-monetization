//
//  IMResponseStubs.h
//  InMobiAPIMonetization-Sample
//
//  Created by Rishabh Chowdhary on 16/03/2015.
//  Copyright (c) 2015 InMobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMUtils.h"
#import "IMValidator.h"

//Abstract class
@interface IMResponse : NSObject <IMValidator>

@end

@class IMAdSize;
@interface IMBannerResponse : IMResponse
@property(nonatomic,retain) NSString *CDATA;
@property(nonatomic,retain) NSString *adURL;
@property(nonatomic,retain) NSString *actionName;
@property(nonatomic,assign) int actionType;
@property(nonatomic,retain) IMAdSize *adSize;
@property(nonatomic,assign) BOOL isRichMedia;
@end

@interface IMNativeResponse : IMResponse
@property(nonatomic,retain) NSString *pubContent;
@property(nonatomic,retain) NSString *contextCode;
@property(nonatomic,retain) NSString *ns;
- (NSString *)convertPubContentToJSON;
@end

@interface IMAdSize : NSObject <IMValidator>
@property(nonatomic,assign) int width,height;
@end
