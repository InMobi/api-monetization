This project has all the required classes for native - native request(API), handling impression/click, opening LP.

Classes under package “handleimpclick” => Fires impression/click javascript method in the contextCode, maintaining a global queue object. -> Publisher can specify internal UIWebViews, by modifying IM_MAX_WEBVIEW, depending upon the no. of native slots the application has. For maintaining low memory footprints, a max of 3-5 WebViews would be recommended if in case you have too many slots. You may increase this number to improve latency of firing impression/click beacons. -> Background tasks are handled. -> Caching of native ad data is completed.

TODO * -> Handling impression/click timeouts, and failure cases. -> Implement a max retry logic.
Usage of IMNativeQueue class:

Inside the onCreate() method of your Main Launcher Activity, initialize the IMNativeQueue to create the required sub-objects & webviews, like this: NativeAdQueue.sharedQueue().initialize(this);

The initialize() API may be called only once per the lifetime of the application.

PS: Calling any of impression/click methods before initialization might raise a NullPointerException, as the code requires a main activity to be associated with.

After the IMNativeQueue has been initialized, you can call recordImpression() or recordClick() like this:

NativeAdQueue.recordImpression(ns, contextCode, additionalParams); NativeAdQueue.recordClick(ns, contextCode, additionalParams); where : ns -> The namespace, as obtained from the InMobi Native Ad response. contextCode -> The html+javascript contextCode as obtained from the response. additionalParams -> Any addtional info, to be passed alongside the impression/click. This is a Map, otherwise null.