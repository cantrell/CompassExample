package com.christiancantrell.android.compass.extensions;

import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;

import com.adobe.fre.FREContext;

public class CompassListener implements SensorEventListener {

	private FREContext freContext;
	
	public void setFREContext(FREContext context)
	{
		this.freContext = context;
	}
	
	@Override
	public void onAccuracyChanged(Sensor sensor, int accuracy)
	{
	}

	@Override
	public void onSensorChanged(SensorEvent event)
	{
		StringBuilder sb = new StringBuilder(Float.toString(event.values[0]));
	    sb.append("&").append(Float.toString(event.values[1])).append("&").append(Float.toString(event.values[2]));
		this.freContext.dispatchStatusEventAsync("MAGNETIC_FIELD_CHANGED", sb.toString());
	}
}
