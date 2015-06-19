InMobiAPIMonetizationLibrary-Java
=================================

This is the API library, build for Server integrations which use Java technology.

The code structure would be split into these components:

Request classes/model stubs - As per the JSON request
Enums - To help create efficient AdRequestObject underlying structure.
Network package - For http connections with InMobi API 2.0
Utils package - For serialization, Base64, etc utility work
Serialization - JSON serializer/de-serializer
Base64
XML Parser 
Others
Third party classes - If any third party “as-is” component is required.
Monetization package - consisting of Banner, Interstitial, Native classes.


Publishers are expected to use classes under monetization package directly, and pass AdRequest object with valid arguments, to obtain ads from InMobi.

Note: Publishers may freely use any components of the code they like, if the entire project, or its components may not be used somehow.

Request request = new Request();
		//property 
		Property property = null;
		property = new Property("YOUR_PROPERTY_ID");
		request.setProperty(property);
		
		//device 
		Device device = new Device("CARRIER_IP",
				"MOBILE UA");
		request.setDevice(device);
		
		//impression 
		Impression imp = new Impression(new Slot(15,"top"));
		request.setImpression(imp);
		
		//user , optional object
		
		User user = new User(1980,Gender.MALE,new Data("1", "Test provider", null));
		request.setUser(user);
		
		//example to load a banner ad
		Banner banner = new Banner();
		
		ArrayList<BannerResponse> ads = banner.loadRequest(request); // by default only 1 ad will be served, or 0 if a request has invalid parameters, or a no-fill happens.

		for(BannerResponse b : ads) {
			//iterate through the banner response object
		}


		//example to load an interstitial ad
		//slot sizes for interstitial -> 14( 320x480), 16(768x1024), 17(800x1280)
		//view this page for more details: https://www.inmobi.com/support/art/26555436/22465648/api-2-0-integration-//guidelines/

		
		Impression imp = new Impression(new Slot(14,null));
		//using same request object as above, but only changing the impression object.
		request.setImpression();

		Interstitial interstitial = new Interstitial();
		ArrayList<BannerResponse> ads = interstitial.loadRequest(request); // by default only 1 ad will be served, or 0 if a request has invalid parameters, or a no-fill happens.

		for(BannerResponse b : ads) {
			//iterate through the  response object
		}

		//example to load a native ad

		Native nativeAd = new Native();

		ArrayList<NativeResponse> ads = nativeAd.loadRequest(request); // by default only 1 ad will be served, or 0 if a request has invalid parameters, or a no-fill happens.

		for(NativeResponse b : ads) {
			//iterate through the  response object
		}
