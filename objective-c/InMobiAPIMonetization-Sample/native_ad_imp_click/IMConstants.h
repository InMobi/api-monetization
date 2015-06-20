//
//  IMConstants.h
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

