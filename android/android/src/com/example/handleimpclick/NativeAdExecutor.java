package com.example.handleimpclick;

import android.app.Activity;
import android.graphics.Bitmap;
import android.util.Log;
import android.webkit.WebView;
import android.webkit.WebViewClient;

import com.example.handleimpclick.NativeAdData.AdOperationType;

/**
 * This class executes an impression/click firing execution inside a webview
 * @author rishabhchowdhary
 *
 */
public class NativeAdExecutor implements Runnable {

	public interface NativeAdExecutorListener {
		public void executionSuccedeed(NativeAdExecutor e);

		public void executionFailed(NativeAdExecutor e);
	}

	public NativeAdData data;
	public AdOperationType operationType;
	public WebViewWrapper webViewWrapper;
	private NativeAdExecutorListener listener;
	private Activity activity;
	private boolean isRequestInProgress = false;
	
	public NativeAdExecutor(WebViewWrapper w, NativeAdData d,
			AdOperationType type, NativeAdExecutorListener l,Activity a) {
		webViewWrapper = w;
		data = d;
		operationType = type;
		if (w != null) {
			w.isExecuting = true;
		}
		listener = l;
		activity = a;
		
		
	}

	private void executeJS(final String js) {
		isRequestInProgress = true;
		activity.runOnUiThread(new Runnable() {

			@Override
			public void run() {
				// TODO Auto-generated method stub
				setupWebViewListener();
				Log.v(InternalUtils.IM_TAG, "loading js:" + js);
		        webViewWrapper.webView.loadData(js, "text/html", "UTF-8");
		    } 
				
			
		});
	}
	
	private void fireJS() {
		executeJS(data.generateJavascriptString(operationType));
	}
	
	private void handleClickWithoutImpressionCase() {
		executeJS(data.generateJavascriptForClickWithoutImpression());
	}
	
	@Override
	public void run() {
		
		Log.v(InternalUtils.IM_TAG, " started" );
		isRequestInProgress = true;
		
		
		boolean validOperation = false;
        
        if (operationType == AdOperationType.Impression && !data.isImpressionCountingFinished) {
            //impression counting valid case
            validOperation = true;
            
        } else if(operationType == AdOperationType.Click && !data.isClickCountingFinished) {
            //click counting case, first check if impression counting was completed
            if (data.isImpressionCountingFinished) {
                validOperation = true;
            } else {
                //click counting being done but without a successful impression-counting
                //handle this case later..
                handleClickWithoutImpressionCase();
            }
        }
        
        if (validOperation) {
            //execute on main thread..
            fireJS();
        }
		try {
			while(isRequestInProgress == true) {
				Thread.sleep(1000);
			}
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Log.v(InternalUtils.IM_TAG, " completed");
		
		//sendSuccessCallback();
	}
	
	private void setupWebViewListener() {
		// TODO Auto-generated method stub
		if(webViewWrapper == null) {
			isRequestInProgress = false;
			return;
		}
		
		webViewWrapper.webView.setWebViewClient(new WebViewClient() {
			
			
			public void onPageFinished(WebView view, String url) {
				isRequestInProgress = false;
				if (webViewWrapper != null)
				{
					webViewWrapper.isExecuting = false;
				}
				sendSuccessCallback();
				Log.v(InternalUtils.IM_TAG,"page finished:" + data.ns);
            }
			public void onPageStarted (WebView view, String url, Bitmap favicon) {
				Log.v(InternalUtils.IM_TAG,"page started:");
			}
			
			public void onLoadResource (WebView view, String url) {
				Log.v(InternalUtils.IM_TAG,"resource load:");
			}
			public void onReceivedError (WebView view, int errorCode, String description, String failingUrl) {
				Log.v(InternalUtils.IM_TAG,"received error:" + errorCode + "\tdesc:" + description
						+ "\n" + failingUrl);
				//handle failure cases
				isRequestInProgress = false;
				if (webViewWrapper != null)
				{
					webViewWrapper.isExecuting = false;
				}
			}
			
		});
	}

	private void sendSuccessCallback() {
		// TODO Auto-generated method stub
		if(listener != null) {
			listener.executionSuccedeed(this);
		}
	}
	/**
	 * TODO handle failure cases
	 */
	private void sendFailureCallback() {
		// TODO Auto-generated method stub
		if(listener != null) {
			listener.executionFailed(this);
		}
	}
}
