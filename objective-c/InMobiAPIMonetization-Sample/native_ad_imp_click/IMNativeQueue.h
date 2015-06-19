//
//  InMobiNativeQueue.h
//  Native ad sample
//

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
