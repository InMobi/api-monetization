package com.example.handleimpclick;

import java.util.Map;

import com.google.gson.Gson;

public class InternalUtils {

	private static final Gson GSON = new Gson();
	public static final String IM_TAG = "IMTAG";
	
	public static final int IM_MAX_WEBVIEW = 3;
	
	public static final int IM_CACHE_WINDOW = 10800; // 3 hours, configurable
	
	public static String toJSON(Map<String,String> map) {
		return GSON.toJson(map);
	}
	public static long currentTs() {
		return System.currentTimeMillis();
	}
}
