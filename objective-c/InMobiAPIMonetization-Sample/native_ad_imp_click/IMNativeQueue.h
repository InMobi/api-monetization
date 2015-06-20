//
//  InMobiNativeQueue.h
//  Native ad sample
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
//

#import <Foundation/Foundation.h>
#import "IMNativeAdData.h"
/**
 * This is a static class, which can be used by publisher to record impression/clicks for a given native ad.
 */

@interface IMNativeQueue : NSObject

/*
 * This method is used to record impression for the given parameters.
 * ns & contextCode must be valid strings.
 * Internally calls recordImpression:
 */
+ (void)recordImpressionWithNamespace:(NSString *)ns contextCode:(NSString *)contextCode
              additionalParams:(NSDictionary *)params;

/*
 * This method is used to record click for the given parameters.
 * Internally calls recordClick:
 */

+ (void)recordClickWithNamespace:(NSString *)ns contextCode:(NSString *)contextCode
         additionalParams:(NSDictionary *)params;
+ (IMNativeQueue *)sharedQueue;

@end
