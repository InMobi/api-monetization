package main.java.com.inmobi.monetization.ads.listener;

import java.util.ArrayList;

import main.java.com.inmobi.monetization.ads.AdFormat;
import main.java.com.inmobi.monetization.api.net.ErrorCode;
import main.java.com.inmobi.monetization.api.response.ad.AdResponse;

public interface AdFormatListener {

	public void onSuccess(AdFormat adFormat, ArrayList<? extends AdResponse> response);

	public void onFailure(AdFormat adFormat, ErrorCode error);
}
