//
//  IMRequestResponse.h
//  Native ad sample
//
//

#import <Foundation/Foundation.h>
#import "IMRequest.h"
#import "IMError.h"

@class IMRequestResponseManager;

/**
 * Can be used to make request & obtain response for all ad-formats.
 */
@interface IMRequestResponseManager : NSObject

- (id)sendInMobiAdRequest:(NSData *)payloadJSON deviceIP:(NSString *)carrierIP
            deviceUserAgent:(NSString *)ua;
@property(nonatomic,retain) IMError *error;

@end
