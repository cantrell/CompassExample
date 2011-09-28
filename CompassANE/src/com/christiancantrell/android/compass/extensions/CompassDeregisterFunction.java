package com.christiancantrell.android.compass.extensions;

import android.app.Activity;
import android.content.Context;
import android.hardware.SensorManager;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

public class CompassDeregisterFunction implements FREFunction
{

	@Override
	public FREObject call(FREContext context, FREObject[] args)
	{
		CompassExtensionContext cec = (CompassExtensionContext)context;
		Activity activity = cec.getActivity();
		SensorManager sensorManager = (SensorManager) activity.getSystemService(Context.SENSOR_SERVICE);
		CompassListener listener = cec.getOrientationListener();
		if (listener != null)
		{
			sensorManager.unregisterListener(listener);
		}
		return null;
	}

}
