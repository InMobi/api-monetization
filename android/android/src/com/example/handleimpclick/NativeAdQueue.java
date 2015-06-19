package com.example.handleimpclick;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import android.app.Activity;
import android.content.Context;
import android.content.SharedPreferences;
import android.os.Handler;
import android.os.Message;
import android.text.TextUtils;
import android.util.Log;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.inmobi.nativeadsample.handleimpclick.NativeAdData.AdOperationType;
import com.inmobi.nativeadsample.handleimpclick.NativeAdExecutor.NativeAdExecutorListener;

/**
 * This is the main external facing class, to be used to track impression
 * & click events for a given native ad served .
 * Steps to be used:
 * 
 * I. Publishers are expected to first pass a valid Activity,Context using initialize API
 * II. Publisher can use recordImpression(),recordClick() methods to pass the ns,contextCode
 * params.
 * This class will not fire duplicate impression/click events if the same is executed multiple times.
 * TODO
 * retry logic, caching of successful events in case app gets terminated.
 * @author rishabhchowdhary
 *
 */
public class NativeAdQueue implements NativeAdExecutorListener {

	

	private ArrayList<WebViewWrapper> webViewWrapperList;
	private ArrayList<NativeAdData> nativeAdDataList;
	private ArrayList<NativeAdExecutor> currentExecutingItems;
	private ExecutorService executorService;
	private Activity activity;
	private static NativeAdQueue nativeAdQueue;
	private static final String IM_CACHE_PREF = "im_cache_prefs";
	private static final String IM_CACHE_PREF_ARRAY = "im_cache_prefs_array";
	private static final int CHECK_CACHE = 1;
	private boolean isInitialized = false;
	private Gson GSON = new Gson();
	private IMHandler mHandler = new IMHandler();
	
	public synchronized static NativeAdQueue sharedQueue() {
		if (nativeAdQueue == null) {
			nativeAdQueue = new NativeAdQueue();
		}
		return nativeAdQueue;
	}

	private NativeAdQueue() {
		// avoid publisher instantiating this object
	}

	/**
	 * Inside the onCreate() method of your Main Launcher Activity, 
	 * initialize the IMNativeQueue to create the required sub-objects & webviews.
     * @note The initialize() API may be called only once per the lifetime of the application.
     * Calling this API multiple times fails it silently.
	 * @param a The Main Lanucher Activity.
	 */
	public synchronized void initialize(final Activity a) {

		if(isInitialized) return;
		
		isInitialized = true;
		activity = a;
		populateNativeAdArrayFromPreferences();
		webViewWrapperList = new ArrayList<WebViewWrapper>();
		executorService = Executors.newFixedThreadPool(InternalUtils.IM_MAX_WEBVIEW);
		
        currentExecutingItems = new ArrayList<NativeAdExecutor>();
		
		checkAndClearAdDataCache();
		activity.runOnUiThread(new Runnable() {

			@Override
			public void run() {
				// TODO Auto-generated method stub
				for (int i = 1; i <= InternalUtils.IM_MAX_WEBVIEW; i++) {

					WebViewWrapper wrapper = new WebViewWrapper(a);
					wrapper.index = i - 1; // since array object would start
											// referencing from zero
					webViewWrapperList.add(wrapper);
				}
			}

		});
	}

	/** TODO test*/
	@SuppressWarnings("unchecked")
	private void populateNativeAdArrayFromPreferences() {
		// TODO Auto-generated method stub
		SharedPreferences prefs = activity.getSharedPreferences(IM_CACHE_PREF, 0);
		 String jsonString = prefs.getString(IM_CACHE_PREF_ARRAY, null);
		 nativeAdDataList = new ArrayList<NativeAdData>();
		 if(jsonString != null) {
			 try {
				 Type listType = new TypeToken<ArrayList<NativeAdData>>(){}.getType();
				 ArrayList<NativeAdData> arrayList = (ArrayList<NativeAdData>)GSON.fromJson(jsonString, listType);
				 for(NativeAdData data : arrayList) {
					 nativeAdDataList.add(data);
				 }
			 } catch(Exception e) {e.printStackTrace();}
		 } 
	}

	/** TODO test*/
	private void storeNativeAdArrayInSharedPreferences() {
		SharedPreferences prefs = activity.getSharedPreferences(IM_CACHE_PREF, 0);
		SharedPreferences.Editor editor = prefs.edit();
		try {
			String toJson = GSON.toJson(nativeAdDataList);
			editor.putString(IM_CACHE_PREF_ARRAY, toJson);
		} catch(Exception e) {e.printStackTrace();}
		editor.commit();
	}

	/** TODO test*/
	protected void checkAndClearAdDataCache() {
		
		mHandler.sendEmptyMessageDelayed(CHECK_CACHE, InternalUtils.IM_CACHE_WINDOW * 1000);
	    long currentTs = InternalUtils.currentTs();
	    ArrayList<NativeAdData> tempList = new ArrayList<NativeAdData>();
	    for (NativeAdData data : nativeAdDataList) {
	        if (currentTs - data.ts < InternalUtils.IM_CACHE_WINDOW) {
	            tempList.add(data);
	        }
	    }
	    nativeAdDataList.clear(); nativeAdDataList = null;
	    this.nativeAdDataList = tempList;
	    storeNativeAdArrayInSharedPreferences();
	}

	private boolean isDuplicateOperation(NativeAdData data,
			AdOperationType operationType) {
		boolean isDuplicate = false;

		// compare the 'ns' value & operation type for each native ad data array
		// if ns are same, and operation type
		// data object is always fetched from nativeAdsArray itself..

		// check if the current operation type has been performed already or
		// not..
		if (operationType == AdOperationType.Impression
				&& data.isImpressionCountingFinished) {
			// this confirms the new operation to be a duplicate..
			isDuplicate = true;
		} else if (operationType == AdOperationType.Click
				&& data.isClickCountingFinished) {
			isDuplicate = true;
		} else {
			// check current queue if we already have an operation lined up..
			// if Yes, then we can consider this as duplicate, and ignore.
			for (NativeAdExecutor e : currentExecutingItems) {
				if (e.data.ns.equals(data.ns)
						&& e.operationType == operationType) {
					isDuplicate = true;
				}
			}
		}
		return isDuplicate;
	}

	private void updateCachedAdData(NativeAdExecutor executor, boolean success) {
		if (success == true) {
			int objIndex = 0;
			NativeAdData d = null;
			for (NativeAdData data : nativeAdDataList) {
				if (executor.data.ns.equals(data.ns)) {
					d = data;
					break;
				}
				objIndex++;
			}
			if (d != null) {
				if (executor.operationType == AdOperationType.Impression) {
					d.isImpressionCountingFinished = true;

				} else if (executor.operationType == AdOperationType.Click) {
					d.isClickCountingFinished = true;
				}
				nativeAdDataList.set(objIndex, d);
				storeNativeAdArrayInSharedPreferences();
			}
		}
	}

	private void checkAndReAssignWebViewForCompletedExecution(
			NativeAdExecutor executor, boolean success) {
		updateCachedAdData(executor, success);
		NativeAdExecutor notExecuting = null;
		for (NativeAdExecutor e : currentExecutingItems) {
			if (e.webViewWrapper == null || !e.webViewWrapper.isExecuting) {
				notExecuting = e;
				break;
			}
		}
		if (notExecuting != null) {
			notExecuting.webViewWrapper = webViewWrapperList
					.get(executor.webViewWrapper.index);
			executorService.execute(notExecuting);
		}
		
		currentExecutingItems.remove(executor);
	}

	private synchronized void recordEventInternal(NativeAdData data,
			AdOperationType operationType) {
		if (isDuplicateOperation(data, operationType)) {
			Log.v(InternalUtils.IM_TAG, "returning:" + data.ns);
			return;
		}
		WebViewWrapper wrapper = null;
		for (WebViewWrapper w : webViewWrapperList) {
			if (!w.isExecuting) {
				wrapper = w;
				break;
			}

		}
		NativeAdExecutor executable = new NativeAdExecutor(wrapper, data, operationType, this, activity);
		// check for dependency
		currentExecutingItems.add(executable);
		if(wrapper != null) {
			executorService.execute(executable);
		}
		
	}

	private synchronized void recordEvent(String ns, String contextCode,
			Map<String, String> params, AdOperationType operationType) {
		
		if (!TextUtils.isEmpty(ns) && !TextUtils.isEmpty(contextCode)) {
			NativeAdData data = null;
			for (NativeAdData d : nativeAdDataList) {
				if (d.ns.equals(ns)) {
					data = d;
					break;
				}
			}
			if (data == null) {
				data = new NativeAdData(ns, contextCode, params);
				nativeAdDataList.add(data);
			}
			data.additionalParams = params;
			
			recordEventInternal(data, operationType);
		}

	}
	/**
	 * This method may be called with the required ns,contextCode parameters to execute impression counting
	 * for a given native ad response
	 * @param ns The namespace, as obtained in inmobi ad response. Eg. "im_4533_". Must be not-null
	 * @param contextCode The javascript contextCode, as obtained in the JSON ad response from InMobi. Must be not-null
	 * @optional params Any additional map info, to be passed during impression/click counting. 
	 */
	public static void recordImpression(String ns, String contextCode,
			Map<String, String> params) {
		sharedQueue().recordEvent(ns, contextCode, params,
				AdOperationType.Impression);
	}
	/**
	 * This method may be called with the required ns,contextCode parameters to execute click counting
	 * for a given native ad response
	 * @note Before executing click counting, you must ensure to have called recordImpression(), for the
	 * same ns/contextCode combination. 
	 * 
	 * @param ns The namespace, as obtained in inmobi ad response. Eg. "im_4533_". Must be not-null
	 * @param contextCode The javascript contextCode, as obtained in the JSON ad response from InMobi. Must be not-null
	 * @optional params Any additional map info, to be passed during impression/click counting. 
	 */
	public static void recordClick(String ns, String contextCode,
			Map<String, String> params) {
		sharedQueue().recordEvent(ns, contextCode, params,
				AdOperationType.Click);
	}

	
	@Override
	/**
	 * Called by NativeAdExecutor, once the execution is succeeded.
	 * @param e The NativeAdExecutor, which was succeded.
	 */
	public void executionSuccedeed(NativeAdExecutor e) {
		// TODO Auto-generated method stub
		checkAndReAssignWebViewForCompletedExecution(e, true);
	}

	@Override
	/**
	 * Called by NativeAdExecutor, once the execution is failed.
	 * @param e The NativeAdExecutor, which had failed.
	 */
	public void executionFailed(NativeAdExecutor e) {
		// TODO Auto-generated method stub
		checkAndReAssignWebViewForCompletedExecution(e, false);
	}
	
	
	public static class IMHandler extends Handler {
		public void handleMessage(Message msg) {
			switch(msg.what) {
				case CHECK_CACHE:
					nativeAdQueue.checkAndClearAdDataCache();
					break;
					default:
						break;
			}
			super.handleMessage(msg);
		}
	}
}