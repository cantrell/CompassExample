package com.christiancantrell.android.compass.extensions;

import android.app.Activity;
import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorManager;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

public class CompassRegisterFunction implements FREFunction
{
	@Override
	public FREObject call(FREContext context, FREObject[] args)
	{
		CompassExtensionContext cec = (CompassExtensionContext)context;
		Activity activity = cec.getActivity();
		SensorManager sensorManager = (SensorManager) activity.getSystemService(Context.SENSOR_SERVICE);
		Sensor orientation = sensorManager.getDefaultSensor(Sensor.TYPE_ORIENTATION);
		cec.setOrientation(orientation);
		CompassListener listener = new CompassListener();
		listener.setFREContext(context);
		cec.setOrientationListener(listener);
		sensorManager.registerListener(listener, orientation, SensorManager.SENSOR_DELAY_NORMAL);
		return null;
	}
}
