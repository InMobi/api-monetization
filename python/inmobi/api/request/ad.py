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

"""Data classes for creating InMobi Ad Request.

This module demonstrates includes all the classes required to create 
Ad Request object as per `InMobi S2S 2.0 API integration document`_. 

API Structure
-------------
With these classes you can build the following Object representation.

.. image:: https://www.inmobi.com/support/files/2013/09/jsonrep.png
.. _InMobi S2S 2.0 API integration document:
   https://www.inmobi.com/support/art/26555436/22465648/api-2-0-integration-guidelines/

Data Classes
------------

"""

import re

DEVICE_ID_PATTERN = re.compile('gpid|ida|idv|o1|so1|um5|iuds1|lid|sid')


class Slot(object):
    """
        The slot object is required under the imp object to describe the type of ad requested. 
        It is essential if the ad requested is rich media, or more.
    """

    def __init__(self, adsize):
        super(Slot, self).__init__()
        self.adsize = adsize

    # top, bottom, middle, page.
    def setPos(self, pos):
        self.pos = pos


class Segment(object):
    """
        The data and segment objects together allow data about the user to be passed to the ad server through the ad
        request.
        Segment objects convey specific units of information from the provider identified in the parent data object.
        The segment object, and all of its parameters are optional.
    """

    def __init__(self):
        super(Segment, self).__init__()
        self.data = object()

    def addUserData(self, key, value):
        self.data[key] = value


class Data(object):
    """Data
    """

    def __init__(self):
        super(Data, self).__init__()

    def setId(self, id):
        self.id = id

    def setName(self, name):
        self.name = name

    def setSegment(self, segment):
        if not isinstance(segment, Segment):
            raise TypeError("Parameter should be an instance of Segment")


class User(object):
    """
        The user object contains information known or derived about the human user of the device.
        This object, and all of its parameters, are optional.
    """

    def __init__(self):
        super(User, self).__init__()

    def setYob(self, year):
        self.yob = year

    def setGender(self, gender):
        self.gender = gender

    def setData(self, data):
        if not isinstance(data, list):
            raise TypeError("Parameter should be list of Data object")
        else:
            for x in data:
                if not isinstance(x, Data):
                    raise TypeError("List should contain Data instance type")

        self.data = data


class Geo(object):
    """
        The geo object collects the user's latitude, longitude, and accuracy details. This object, and all of its
        parameters, are optional
    """

    def __init__(self):
        super(Geo, self).__init__()

    def setLat(self, lat):
        self.lat = lat

    def setLon(self, lon):
        self.lon = lon

    def setAccu(self, accu):
        self.accu = accu


class Device(object):
    """
        The device object provides information pertaining to a device, including its hardware, platform, location,
        and carrier.
    """

    def __init__(self, ip, ua):
        super(Device, self).__init__()
        self.ip = ip
        self.ua = ua

    def setLocal(self, local):
        self.local = local

    def setConnectionType(self, connectiontype):
        self.connectiontype = connectiontype

    def setOrientation(self, orientation):
        self.orientation = orientation

    def setGeo(self, geo):
        if isinstance(geo, Geo):
            raise TypeError("Parameter should be Geo type")
        self.geo = geo

    def setDeviceId(self, deviceidtype, deviceid):
        if not DEVICE_ID_PATTERN.match(deviceidtype):
            raise ValueError(
                "deviceidtype can be one of the following types: gpid|ida|idv|o1|so1|um5|iuds1|lid|sid")
        self.__dict__[deviceidtype] = deviceid

    def setAdt(self, adt):
        if not isinstance(adt, int):
            raise TypeError("adt has to be an integer")
        self.adt = adt


class Property(object):
    """
        The site object is mandatory. This object requires the id field in order to serve ads to a specific site.
    """

    def __init__(self, id):
        super(Site, self).__init__()
        self.id = id

    def setPos(self, pos):
        self.pos = pos

    def setRef(self, ref):
        self.ref = ref

    def setRefTag(self, reftag):
        self.reftag = reftag

    def setCat(self, cat):
        self.cat = cat


class Impression(object):
    """
        The imp object describes the ad position or the impression being requested.
    """

    def __init__(self, slot):
        super(Impression, self).__init__()

        if not isinstance(slot, Slot):
            raise TypeError("Paramter should be instance of Slot type")
        self.slot = slot

    def setDisplayManager(self, displaymanager):
        self.displaymanager = displaymanager

    def setDisplayManagerVer(self, displaymanagerver):
        self.displaymanagerver = displaymanagerver

    def setAdType(self, adtype):
        self.adtype = adtype

    def setAds(self, ads):
        self.ads = ads


class Request(object):
    """
        The top-level ad request object is required to contain at least the site object containing the unique site
        ID, and the device object containing the client IP address and user agent information.
    """

    def __init__(self, impression, site, device):
        super(Request, self).__init__()
        if not isinstance(impression, Impression):
            raise TypeError(
                "First Paramter should be instance of Impression type")
        if not isinstance(site, Site):
            raise TypeError("Second Paramter should be instance of Site type")
        if not isinstance(device, Device):
            raise TypeError("Third Paramter should be instance of Device type")
        self.imp = [impression]
        self.site = site
        self.device = device

    def setUser(self, user):
        self.user = user

    def setResponseFormat(self, responseformat):
        self.responseformat = responseformat
