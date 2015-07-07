This project has all the required classes for native - native request(API), handling impression/click, opening LP.

Classes under folder "native_ad_req" => Mock stubs for making native ad requests to InMobi via API 2.0

Classes under folder "native_ad_action" => Handling opening of LP( itunes URL, normal webpages, non-http links, etc. use cases)

Classes under folder "native_ad_imp_click" => Fires impression/click javascript method in the contextCode, maintaining a global queue object. -> Publisher can specify internal UIWebViews, by modifying IM_MAX_WEBVIEW, depending upon the no. of native slots the application has. For maintaining low memory footprints, a max of 3-5 WebViews would be recommended if in case you have too many slots. You may increase this number to improve latency of firing impression/click beacons. -> The native metadata gets written to NSUserDefaults, with a cache expiry of 3 hours, specified in IM_CACHE_WINDOW. -> Background tasks are handled

TODO * -> Handling impression/click timeouts, and failure cases -> Implement a max retry logic.