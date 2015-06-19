package com.example.handleimpclick;

import android.annotation.SuppressLint;
import android.content.Context;
import android.webkit.WebSettings;
import android.webkit.WebView;

@SuppressLint("SetJavaScriptEnabled")
/**
 * This class is a webviewwrapper, which contains a webview
 * and some more useful info like index,isExecuting
 * which are internally used by NativeAdQueue for mapping WebViewWrappers.
 * @author rishabhchowdhary
 *
 */
public class WebViewWrapper {

	public WebView webView;
	public int index;
	public boolean isExecuting = false;
	
	public WebViewWrapper(Context ctx) {
		webView = new WebView(ctx);
		webView.getSettings().setJavaScriptEnabled(true);
        webView.getSettings().setCacheMode(WebSettings.LOAD_NO_CACHE);
        webView.getSettings().setLoadsImagesAutomatically(true);
        webView.getSettings().setBlockNetworkImage(false);
        webView.setVisibility(0);
	}
}
