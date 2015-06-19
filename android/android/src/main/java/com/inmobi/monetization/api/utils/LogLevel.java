package main.java.com.inmobi.monetization.api.utils;

public enum LogLevel {
	NONE(4),DEBUG(3),WARNING(2),ERROR(1);
	
	public final int value;
	
	private LogLevel(int value) {
		this.value = value;
	}
}
