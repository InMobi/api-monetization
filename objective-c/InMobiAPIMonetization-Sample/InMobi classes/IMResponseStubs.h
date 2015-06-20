//
//  IMResponseStubs.h
//  InMobiAPIMonetization-Sample
//
//  Created by Rishabh Chowdhary on 16/03/2015.
//  Copyright (c) 2015 InMobi. All rights reserved.
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
