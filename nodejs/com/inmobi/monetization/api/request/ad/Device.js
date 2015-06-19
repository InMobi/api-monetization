////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//The device  provides rmation pertaining to a device, including its
// hardware, platform, location, and carrier.</br>
// The User-Agent, and carrierIP are mandatory rmation, without
// which a request will always be terminated.</br> <b>2.</b> The Carrier IP must
// be a valid Mobile Country code, and <b>not</b> of your
// local-wifi/LAN/WAN.</br> Please refer for additional details:
// http://en.wikipedia.org/wiki/Mobile_country_code</br> For eg: 10.14.x.y, or
// 192.168.x.y are internal IPs, and hence passing them would terminate the
// request.</br> <b>3.</b>The User Agent string passed should be a valid,
// WebView User Agent of the device, for which ads are being requested.

// @author Rishabh Chowdhary
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

var Geo = require('./Geo.js');
var Utils = require('../../utils/Utils.js');

function Device(ip,ua) {
    this.geo = null;
    this.carrierIP = ip;
    this.useragent = ua;
    this.gpid = null;
    this.idfa = null;
    this.androidId = null;
    this.adTrackingDisabled = false;
}

Device.prototype.isValid = function() {
    if(Utils.isStringValid(this.carrierIP) == false) return false;
    if(Utils.isStringValid(this.useragent) == false) return false; 
    return true;
}

module.exports = Device;

