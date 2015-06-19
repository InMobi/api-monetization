package com.example.handleimpclick;

import java.io.Serializable;
import java.util.Map;

import com.google.gson.Gson;


/**
 * This class contains the ad info, associated with a native object.
 * ns - Namespace of the impression, of the format im_<number>_
 * contextCode - the javascript code, to be executed in webview
 * @author rishabhchowdhary
 *
 */
public class NativeAdData implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -5148967347438300597L;

	public enum AdOperationType {
		None,
		Impression,
		Click
	}
	
	public String ns,contextCode;
	public boolean isImpressionCountingFinished = false;
	public boolean isClickCountingFinished = false;
	public Map<String,String> additionalParams;
	public double ts ;
	
	
	public NativeAdData(String ns,String contextCode,Map<String,String> params) {
		this.ns = ns;
		this.contextCode = contextCode;
		this.additionalParams = params;
		//for caching purpose
		ts = InternalUtils.currentTs();
	}
	
	public String generateJavascriptString(AdOperationType type) {
		StringBuffer buffer = new StringBuffer();
		int eventId = (type == AdOperationType.Impression ? 18 : 8);
		if(additionalParams == null) {
			buffer.append(contextCode);
			buffer.append("<script>");
			buffer.append(ns);
			buffer.append("recordEvent(" + eventId + ")");
			buffer.append("</script>");
		} else {
			String params = InternalUtils.toJSON(additionalParams);
			buffer.append(contextCode);
			buffer.append("<script>");
			buffer.append(ns);
			buffer.append("recordEvent(" + eventId + ","+ params +")");
			buffer.append("</script>");
		}
		return buffer.toString();
	}
	
	public String generateJavascriptForClickWithoutImpression() {
		String retStr = generateJavascriptString(AdOperationType.Impression);
		retStr += "<script>recordEvent(8)</script>";
		return retStr;
	}
	
	public String toString() {
		return "ns:" + ns + "\t" + "isImp:" + isImpressionCountingFinished + "\t"
				+ "isClick:" + isClickCountingFinished ;
	}
}
