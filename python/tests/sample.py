from inmobi.monetization.ads import IMSlot
from inmobi.api.request.ad import *


class Sample(object):
    """docstring for Sample"""

    def __init__(self):
        slot = Slot(15)
        impression = Impression(slot)
        impression.setAds(1)
        impression.setDisplayManager("Mogo")
        impression.setDisplayManagerVer("311")

        prop = Property("YOUR_PROPERTY_ID")
        device = Device("USER_CARRIER_IP",
                        "USER_WEBVIEW_USER_AGENT")
        device.setDeviceId("um5", "d19b0c68b92d208d9b215ab512c62116")
        device.setConnectionType("3G")

        request = Request(impression, prop, device)
        request.setResponseFormat("html")

        slot = IMSlot(request)
        response = slot.loadad()
        print response.has_error
        print response.error.code
        print response.error.message
        print response.body


if __name__ == '__main__':
    s = Sample()
