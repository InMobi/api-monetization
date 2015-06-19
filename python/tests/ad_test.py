# Copyright (C) 2015 InMobi Technology Services Pvt Ltd
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

import os
import sys
import inspect

currentdir = os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))
parentdir = os.path.dirname(currentdir)
sys.path.insert(0, parentdir)

import unittest
from inmobi.api.request.ad import Impression, Device, Request, Slot, Property
from inmobi.monetization.ads import IMInterstitial


class TestSequenceFunctions(unittest.TestCase):

    def setUp(self):
        slot = Slot(14)
        impression = Impression(slot)
        prop = Property("YOUR_PROPERTY_ID")
        device = Device("USER_CARRIER_IP", "USER_WEBVIEW_USER_AGENT")
        request = Request(impression, prop, device)
        self.interstitial_ad = IMInterstitial(request)

    def test_errorForImpressionObject(self):
        self.assertRaisesRegexp(TypeError, "Paramter should be instance of Slot type", Impression, "adsf")


    def test_errorForRequestObject(self):
        self.assertRaisesRegexp(TypeError, "First Paramter should be instance of Impression type", Request,
                                "someImpression", "someProperty", "someDevice")
        slot = Slot(15)
        impression = Impression(slot)
        self.assertRaisesRegexp(TypeError, "Second Paramter should be instance of Property type", Request, impression,
                                "someProperty", "someDevice")

        prop = Property("some_prop_id")
        self.assertRaisesRegexp(TypeError, "Third Paramter should be instance of Device type", Request, impression,
                                prop, "someDevice")

        device = Device("ip", "ua")
        self.assertRaisesRegexp(ValueError,
                                "deviceidtype can be one of the following types: gpid|ida|idv|o1|so1|um5|iuds1|lid|sid",
                                device.setDeviceId, "gid", "test-gpid")

        Request(impression, prop, device)

    def test_errorForDeviceObject(self):
        device = Device("ip", "ua")
        self.assertRaisesRegexp(ValueError,
                                "deviceidtype can be one of the following types: gpid|ida|idv|o1|so1|um5|iuds1|lid|sid",
                                device.setDeviceId, "gid", "test-gpid")
        self.assertRaisesRegexp(TypeError, "adt has to be an integer", device.setAdt, "as")

    def test_forAutoCorrection(self):
        self.assertEqual("int", self.interstitial_ad.request.imp[0].adtype)

    def test_forDisplayManagerVersion(self):
        self.assertEqual("c_py", self.interstitial_ad.request.displaymanager)
        self.assertEqual("1.0.0", self.interstitial_ad.request.displaymanagerver)


if __name__ == '__main__':
    unittest.main()
