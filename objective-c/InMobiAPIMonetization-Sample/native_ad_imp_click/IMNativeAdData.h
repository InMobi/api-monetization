//
//  IMNativeAdData.h
//  Native ad sample
//
//

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
