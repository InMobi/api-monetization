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

from inmobi.api.request.ad import Request
import json
import urllib2
from urllib2 import URLError, HTTPError


class IMBase(object):
    def __init__(self, request):
        super(IMBase, self).__init__()
        self.request = request
        self.request.displaymanager = "c_py"
        self.request.displaymanagerver = "1.0.0"


class IMBanner(IMBase):
    """IMBanner class to fetch InMobi Banner Ads.
    """

    def __init__(self, request):
        IMBase.__init__(self, request)
        self.request = request
        # Auto Correct params
        self.request.imp[0].setAdType("")

    def loadad(self):
        return InMobiS2SClient.loadad(self.request)


class IMInterstitial(IMBase):
    """IMInterstitial class to fetch InMobi Interstial ad format.
    """

    def __init__(self, request):
        IMBase.__init__(self, request)
        self.request = request
        self.request.imp[0].setAdType("int")

    def loadad(self):
        return InMobiS2SClient.loadad(self.request)


class IMNative(IMBase):
    """IMNative class to fetch InMobi Native ad format.
    """

    def __init__(self, request):
        IMBase.__init__(self, request)
        self.request = request

    def loadad(self):
        return InMobiS2SClient.loadad(self.request)


class AdResponse(object):
    """AdResponse object for the Ads.
    """

    def __init__(self):
        super(AdResponse, self).__init__()
        self.has_error = False
        self.error = ResponseError()
        self.body = ''


class ResponseError(object):
    """ResponseError will hold the error code and error message.
    """

    def __init__(self):
        self.code = -1
        self.message = ''


class InMobiS2SClient(object):
    END_POINT = "http://api.w.inmobi.com/showad/v2.1"

    @staticmethod
    def loadad(request):
        if not isinstance(request, Request):
            raise TypeError("Parameter should be of type Request")

        data = json.dumps(request, default=lambda o: o.__dict__)
        headers = {}
        headers['Content-Type'] = 'application/json'
        headers['x-forwarded-for'] = request.device.ip
        headers['x-device-user-agent'] = request.device.ua

        adresponse_object = AdResponse()

        try:
            request = urllib2.Request(InMobiS2SClient.END_POINT, data, headers)
            response = urllib2.urlopen(request, timeout=60)
        except HTTPError as e:
            adresponse_object.has_error = True
            adresponse_object.error.code = e.code
            adresponse_object.error.message = 'The server couldn\'t fulfill the request.'
        except URLError as e:
            adresponse_object.has_error = True
            adresponse_object.error.code = e.reason[0]
            adresponse_object.error.message = e.reason[1]
        else:
            adresponse_object.body = response.read()
        return adresponse_object
