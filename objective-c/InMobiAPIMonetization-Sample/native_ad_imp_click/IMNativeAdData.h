//
//  IMNativeAdData.h
//  Native ad sample
//
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
#import "IMConstants.h"

/**
 * This object contains the metadata for an inmobi served native ad.
 * This information includes - namespace,contextCode,additionalParams,etc.
 */
@interface IMNativeAdData : NSObject <NSCoding>

/*
 * This is the namespace string, unique for every served impression by inmobi
 */
@property(nonatomic,copy) NSString *ns;
/*
 * This is the javascript code, to be fired within the webview for counting impression/clicks.
 */
@property(nonatomic,copy) NSString *contextCode;
/*
 * Optional additional params, to be passed to impression/click beacon.
 */
@property(nonatomic,retain) NSDictionary *additionalParams;
/*
 * Boolean flag to capture if impression counting was completed.
 */
@property(nonatomic,assign) BOOL isImpressionCountingFinished;
/*
 * Boolean flag to capture if click counting was completed.
 */
@property(nonatomic,assign) BOOL isClickCountingFinished;

@property(nonatomic,assign) double ts;
/**
 * Constructor to create a NativeAdData object with the necessary metadata.
 */
- (id)initWithNS:(NSString *)n contextCode:(NSString *)ctc
additionalParams:(NSDictionary *)params;
/*
 * this method returns an executable javascript string, using the operationEvent parameter for counting
 * impression or click.
 * @param operationEvent 8 - click, 18 - impression
 */
- (NSString *)generateJavascriptString:(int)operationEvent;
/*
 * Optional method, called in rare scenario if for a given ad, impression counting hasn't been triggered
 * but rather click counting was triggered.
 */
- (NSString *)generateJavascriptForClickWithoutImpression;
/*
 * Util method to return current timestmamp.
 */
+ (double)currentTimeStamp;
@end
