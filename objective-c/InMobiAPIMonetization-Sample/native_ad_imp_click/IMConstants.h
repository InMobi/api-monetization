//
//  IMConstants.h
//  Native ad sample
//
//

//#define kIMAdOperationTypeImpression 18
//#define kIMAdOperationTypeClick 8

typedef enum {
    IMAdOperationTypeNone = 0,
    IMAdOperationTypeImpression = 18,
    IMAdOperationTypeClick = 8
} IMAdOperationType ;

#define IM_MAX_WEBVIEW 3

#define IM_CACHE_WINDOW 10800 // 3 hours, configurable

// update cache content 10 times faster than window, so
//if app gets terminated, then the most updated cache should get picked up likely
// if in case window gets IM_CACHE_WINDOW

#if IM_CACHE_WINDOW < 50
#define IM_CACHE_REFRESH_WINDOW (IM_CACHE_WINDOW)
#elseif IM_CACHE_WINDOW < 100
#define IM_CACHE_REFRESH_WINDOW (IM_CACHE_WINDOW/2)
#elseif IM_CACHE_WINDOW < 500
#define IM_CACHE_REFRESH_WINDOW (IM_CACHE_WINDOW/5)
#else
#define IM_CACHE_REFRESH_WINDOW (IM_CACHE_WINDOW/10)
#endif

#define IM_MAX_AD_DATA_COUNT_ARRAY 50

#define IM_USER_DEFAULTS_AD_DATA_KEY @"im_user_defaults_ad_data_key"

#define DEBUG_ENABLED YES



#define IMLOGGING(format,...) {\
if(DEBUG_ENABLED) {\
NSLog(@"InMobi Log:%@",[NSString stringWithFormat:(format),##__VA_ARGS__]);\
}}

