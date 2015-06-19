//
//  InMobiNativeQueue.m
//  Native ad sample
//
//

#import "IMNativeQueue.h"
#import <UIKit/UIKit.h>
#import "IMAdOperation.h"

@interface IMNativeQueue ()<IMAdOperationDelegate> {
    NSOperationQueue *queue;
    NSMutableArray *webViewWrappersArray;
    NSMutableArray *nativeAdDataArray;
    IMAdOperation *temp;
}

@property(atomic,retain) NSMutableArray *webViewWrappersArray,*nativeAdDataArray;
@property(atomic,retain) IMAdOperation *temp;
@end

@implementation IMNativeQueue
@synthesize webViewWrappersArray,nativeAdDataArray,temp;

#pragma mark internal constructors & utils

+ (IMNativeQueue *)sharedQueue {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        queue = [[NSOperationQueue alloc] init];
        queue.maxConcurrentOperationCount = IM_MAX_WEBVIEW;
        self.webViewWrappersArray = [[NSMutableArray alloc] initWithCapacity:IM_MAX_WEBVIEW];
        //in next phase look to store the cache in database/NSUserDefaults..
        [self populateNativeAdArrayFromUserDefaults];
        [self performSelectorOnMainThread:@selector(createWebViewWrappers) withObject:nil waitUntilDone:YES];
        [self performSelectorOnMainThread:@selector(checkAndClearAdDataCache) withObject:nil waitUntilDone:YES];
        
    }
    return self;
}

- (void)populateNativeAdArrayFromUserDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *arrayData = (NSData *)[defaults objectForKey:IM_USER_DEFAULTS_AD_DATA_KEY];
    if (arrayData != nil && [arrayData isKindOfClass:[NSData class]]) {
        NSArray *array = (NSArray *)[NSKeyedUnarchiver unarchiveObjectWithData:arrayData];
        if (array != nil) {
            self.nativeAdDataArray = [[NSMutableArray alloc] initWithArray:array];
        }
    }
    if (nativeAdDataArray == nil) {
        self.nativeAdDataArray = [[NSMutableArray alloc] init];
    }
}

- (void)storeNativeAdArrayInUserDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:self.nativeAdDataArray] forKey:IM_USER_DEFAULTS_AD_DATA_KEY];
}

- (void)checkAndClearAdDataCache {
    //[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(check) userInfo:nil repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:IM_CACHE_WINDOW target:self selector:@selector(checkAndClearAdDataCache) userInfo:nil repeats:NO];
    
    double currentTs = [IMNativeAdData currentTimeStamp];
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (IMNativeAdData *data in nativeAdDataArray) {
        if (currentTs - data.ts < IM_CACHE_WINDOW) {
            [tempArray addObject:data];
        }
    }
    [nativeAdDataArray removeAllObjects]; nativeAdDataArray = nil;
    self.nativeAdDataArray = tempArray;
    [self storeNativeAdArrayInUserDefaults];
}



- (void)check {
    int i =1;
    for( IMAdOperation *o in [queue operations]) {
        IMLOGGING(@"operation:%d, isExecuting:%d,isReady:%d,web_index:%d",i,o.isExecuting,o.isReady,o.webviewWrapper.index);
        i++;
    }
}

- (BOOL)isEmpty:(NSString *)string {
    return (string != NULL) && ![string isEqualToString:@""] ? NO : YES;
}

- (void)createWebViewWrappers {
    for(int i = 1; i <= IM_MAX_WEBVIEW ; i++) {
        IMWebViewWrapper *webviewWrapper = [[IMWebViewWrapper alloc] init];
        webviewWrapper.index = i -1; // since array object would start referencing from zero
        [webViewWrappersArray addObject:webviewWrapper];
    }
}

- (BOOL)isADuplicateOperationForAdData:(IMNativeAdData *)data
                             operation:(IMAdOperationType)operationType {
    BOOL isDuplicate = NO;
    
    //compare the 'ns' value & operation type for each native ad data array
    //if ns are same, and operation type
    //data object is always fetched from nativeAdsArray itself..
    
    //check if the current operation type has been performed already or not..
    if (operationType == IMAdOperationTypeImpression && data.isImpressionCountingFinished) {
        //this confirms the new operation to be a duplicate..
        isDuplicate = YES;
    } else if(operationType == IMAdOperationTypeClick && data.isClickCountingFinished) {
        isDuplicate = YES;
    } else {
        //check current queue if we already have an operation lined up..
        // if Yes, then we can consider this as duplicate, and ignore.
        for (IMAdOperation *o in [queue operations]) {
            if ([o.data.ns isEqualToString:data.ns] && o.operationType == operationType) {
                isDuplicate = YES;
                break;
            }
        }
    }
    return isDuplicate;
}

- (void)updateCachedAdDataWithCompletedOperation:(IMAdOperation *)operation success:(BOOL)success {
    if (success) {
        int objIndex = 0;
        IMNativeAdData *d = nil;
        for (IMNativeAdData *data in nativeAdDataArray) {
            if ([operation.data.ns isEqualToString:data.ns]) {
                d = data;
                break;
            }
            objIndex++;
        }
        //got the object, now update as per the operation..
        if (d != nil) {
            if (operation.operationType == IMAdOperationTypeImpression) {
                d.isImpressionCountingFinished = YES;
                
            } else if(operation.operationType == IMAdOperationTypeClick) {
                d.isClickCountingFinished = YES;
            }
            [nativeAdDataArray replaceObjectAtIndex:objIndex withObject:d];
            //update cached data as well, so if app crashes the successful data gets recorded
            [self storeNativeAdArrayInUserDefaults];
        }
    }
}


- (void)checkAndReAssignWebViewForCompletedOperation:(IMAdOperation *)operation
                                             success:(BOOL)success {
    if (operation.bgTask != UIBackgroundTaskInvalid) {
        [[UIApplication sharedApplication] endBackgroundTask:operation.bgTask];
        operation.bgTask = UIBackgroundTaskInvalid; 
    }
    [self updateCachedAdDataWithCompletedOperation:operation success:success];
    

    
    IMAdOperation *notExecutingOperation = nil;
    for (IMAdOperation *o in [queue operations]) {
        //check for an operation which is in waiting state in the queue.
        //check if already a webviewWrapper was assigned or not to the operation.
        if (![o isExecuting] && o.webviewWrapper == nil) {
            //pick this operation & break out of the loop..
            // this is the opreation which would get picked first by the queue.
            notExecutingOperation = o;
            IMLOGGING(@"operating in waiting bg task");
            break;
        }
    }
    //check if there was an operation not currently being executed..
    if (notExecutingOperation != nil) {
        //since the operation object is finished, lets pass the webview instance to this current operation now.
        notExecutingOperation.webviewWrapper = [webViewWrappersArray objectAtIndex:operation.webviewWrapper.index];
    }
}

- (void)checkDependencyForOperation:(IMAdOperation *)operation {
    
    //check if the operation is of type click, and somehow an impression of the same ns
    // is in the queue..
    for (IMAdOperation *o in [queue operations]) {
        if ([operation.data.ns isEqualToString:o.data.ns]) {
            //ns is equal.. now check if operation types
            if (o.operationType == IMAdOperationTypeImpression && operation.operationType == IMAdOperationTypeClick) {
                [operation addDependency:o];
                break;
            }
        }
    }
}

#pragma mark private singleton methods

- (void)recordEventInternal:(IMNativeAdData *)adData withOperation:(IMAdOperationType)operationType {
    @synchronized(self) {
        //check to be made here if in case an impression has been recorded successfully with this ns or not before
        //time to cache the IMNativeAdData objects - 3 hours?
        //check to put in place webview which should be used for
        if ([self isADuplicateOperationForAdData:adData operation:operationType]) {
            IMLOGGING(@"operationType:%d already recorded for AdData:%@",operationType,[adData description]);
            return;
        }
        
        UIApplication *application = [UIApplication sharedApplication];
        
        //create a bgTask, so that impression/click counting will continue in background
        //if user leaves app context due to an action
        __block UIBackgroundTaskIdentifier bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
            [application endBackgroundTask:bgTask];
            bgTask = UIBackgroundTaskInvalid;
        }];
        
        //pick up webview..
        //if all webviews are executing, we'll pass 'nil' to the operation
        //when eventually a webview becomes free, that instance would get passed
        // to the operation not executing
        IMWebViewWrapper *w = nil;
        for(IMWebViewWrapper *wrapper in webViewWrappersArray) {
            if (![wrapper isExecuting]) {
                w = wrapper;
                break;
            }
        }
        IMAdOperation *operation = [[IMAdOperation alloc] initWithWebView:w adData:adData operationType:operationType delegate:self bgTask:bgTask];

        //check if this operation would depend on an existing queued operation
        //to be completed first
        [self checkDependencyForOperation:operation];
        [queue addOperation:operation];
        
    }
}

#pragma mark IMAdOperationDelegate methods

- (void)adOperation:(IMAdOperation *)operation failedWithError:(NSError *)error {
    [self checkAndReAssignWebViewForCompletedOperation:operation success:NO];
    //handle error case
}
- (void)adOperationFinishedSuccessfully:(IMAdOperation *)operation {
   // IMLOGGING(@"Operation completed successfully..%@",[operation description]);
    [self checkAndReAssignWebViewForCompletedOperation:operation success:YES];
}

#pragma mark Internal singleton methods -- called from static methods


- (void)recordEventWithNS:(NSString *)ns contextCode:(NSString *)contextCode
         additionalParams:(NSDictionary *)params operationType:(IMAdOperationType)operation {
    @synchronized(self) {
        if (![self isEmpty:ns] && ![self isEmpty:contextCode]) {
            IMNativeAdData *data = nil;
            for (IMNativeAdData *d  in nativeAdDataArray) {
                if ([d.ns isEqualToString:ns]) {
                    data = d;
                    break;
                }
            }
            if (data == nil) {
                data = [[IMNativeAdData alloc] initWithNS:ns contextCode:contextCode additionalParams:params];
                [nativeAdDataArray addObject:data];
            }
            data.additionalParams = params;
            [self recordEventInternal:data withOperation:operation];
        } else {
            IMLOGGING(@"invalid arguments passed to record impressions. Please check contextCode & ns values");
        }
    }
}

#pragma mark Publisher facing Static methods

+ (void)recordImpressionWithNamespace:(NSString *)ns contextCode:(NSString *)contextCode
              additionalParams:(NSDictionary *)params {
    [[IMNativeQueue sharedQueue] recordEventWithNS:ns contextCode:contextCode additionalParams:params operationType:IMAdOperationTypeImpression];
}

+ (void)recordClickWithNamespace:(NSString *)ns contextCode:(NSString *)contextCode
         additionalParams:(NSDictionary *)params {
    [[IMNativeQueue sharedQueue] recordEventWithNS:ns contextCode:contextCode additionalParams:params
     operationType:IMAdOperationTypeClick];
}


@end
