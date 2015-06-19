InMobiAPIMonetizationLibrary-Python
===================================

This is the InMobi S2S API 2.0 Python Client library build for Server integrations which use Python technology.

Usage
-----

    from inmobi.monetization.ads import IMBanner
    from inmobi.api.request.ad import *

    class Sample(object):
        """Sample implemenation"""

        def __init__(self):
            banner = Banner(15)
            impression = Impression(banner)
            impression.setAds(1)
            impression.setDisplayManager("Mogo")
            impression.setDisplayManagerVer("311")

            site = Site("c7ca6b6b01ce48899e34e9975e1ae935")
            device = Device("124.124.173.165",
                            "Mozilla/5.0 (Linux; U; Android ) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile "
                            "Safari/533.1")
            device.setDeviceId("um5", "d19b0c68b92d208d9b215ab512c62116")
            device.setConnectionType("3G")

            request = Request(impression, site, device)
            request.setResponseFormat("html")

            banner = IMBanner(request)
            response = banner.loadad()
            print response.has_error
            print response.error.code
            print response.error.message
            print response.body

        if __name__ == '__main__':
            s = Sample()
