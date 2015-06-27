package main.java.com.inmobi.monetization.api.response.parser;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import main.java.com.inmobi.monetization.api.response.ad.BannerResponse;
import main.java.com.inmobi.monetization.api.response.ad.BannerResponse.AdSize;
import main.java.com.inmobi.monetization.api.utils.InternalUtil;
import main.java.com.inmobi.monetization.api.utils.LogLevel;

import org.xml.sax.Attributes;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

/**
 * This class can be used to obtain an ArrayList of BannerResponse objects, from
 * the InputStream, as obtained from the API 2.0 server response.
 * 
 * @author rishabhchowdhary
 * 
 */
public class SAXBannerResponseParser extends DefaultHandler {

	private ArrayList<BannerResponse> ads = null;
	private BannerResponse ad = null;
	private boolean isInterstitial = false;
	private boolean isAdUrl = false;

	/**
	 * This function converts the InputStream response to BannerResponse
	 * objects.</br>
	 * <p>
	 * <b>Note:</b>If the server returned a no-fill, or there was a parsing error,
	 *       this function would return an empty arraylist.
	 * </p>
	 * 
	 * @param is The InputStream response, as obtained from the HttpUrlConnection.
	 * @param isInterstitial If the request generated was for Interstitial ad.
	 * @return ArrayList of BannerResponse objects
	 */
	public ArrayList<BannerResponse> fetchBannerAdsFromResponse(InputStream is,
			boolean isInterstitial) {

		// get a factory
		ads = new ArrayList<BannerResponse>();
		SAXParserFactory spf = SAXParserFactory.newInstance();
		try {

			// get a new instance of parser
			this.isInterstitial = isInterstitial;
			SAXParser sp = spf.newSAXParser();
			InputStreamReader inputReader = new InputStreamReader(is, "UTF-8");
			InputSource inputSource = new InputSource(inputReader);
			inputSource.setEncoding("UTF-8");

			sp.parse(inputSource, this);
		} catch (SAXException se) {
			InternalUtil.Log(se.getStackTrace().toString(),LogLevel.ERROR);
		} catch (ParserConfigurationException pce) {
			InternalUtil.Log(pce.getStackTrace().toString(),LogLevel.ERROR);
		} catch (IOException ie) {
			InternalUtil.Log(ie.getStackTrace().toString(),LogLevel.ERROR);
		} catch (NullPointerException npe) {
			InternalUtil.Log(npe.getStackTrace().toString(),LogLevel.ERROR);
		}
		return ads;
	}

	/**
	 * DefaultHandler
	 */
	@Override
	public void startElement(String uri, String name, String qName,
			Attributes atri) {

		if ("Ad".equals(qName)) {
			ad = new BannerResponse();
			ad.isRichMedia = "rm".equals(atri.getValue("type")) ? true : false;
			ad.actionName = atri.getValue("actionName");
			try {
				int w = Integer.parseInt(atri.getValue("width"));
				int h = Integer.parseInt(atri.getValue("height"));
				ad.adsize = new AdSize(w, h);
				ad.actionType = Integer.parseInt(atri.getValue("actionType"));
			} catch (Exception e) {
			}
		} else if ("AdURL".equals(qName)) {
			isAdUrl = true;
		}
	}

	/**
	 * DefaultHandler
	 */
	@Override
	public void characters(char[] ch, int start, int length)
			throws SAXException {

		String data = new String(ch, start, length);

		if (isAdUrl) {
			ad.adUrl = data;
		} else {
			ad.CDATA = data;
		}
	}

	/**
	 * DefaultHandler
	 */
	@Override
	public void endElement(String namespaceURI, String localName, String qName)
			throws SAXException {

		if ("Ad".equals(qName)) {
			if (ad != null) {
				if (ad.isValid()) {
					ad.isInterstitial = isInterstitial;
					ads.add(ad);
				}
			}
		} else if ("AdURL".equals(qName)) {
			isAdUrl = false;
		}
	}

}
