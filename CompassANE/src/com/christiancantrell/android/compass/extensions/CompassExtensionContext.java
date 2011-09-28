package com.christiancantrell.android.compass.extensions;

import java.util.HashMap;
import java.util.Map;

import android.hardware.Sensor;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;

public class CompassExtensionContext extends FREContext
{
	private Sensor orientation;
	private CompassListener orientationListener;
	
	@Override
	public void dispose()
	{
	}

	@Override
	public Map<String, FREFunction> getFunctions()
	{
		Map<String, FREFunction> functionMap = new HashMap<String, FREFunction>();
		functionMap.put("register", new CompassRegisterFunction());
		functionMap.put("deregister", new CompassDeregisterFunction());
	    return functionMap;
	}

	public void setOrientation(Sensor orientation)
	{
		this.orientation = orientation;
	}
	
	public Sensor getOrientation()
	{
		return this.orientation;
	}
	
	public void setOrientationListener(CompassListener orientationListener)
	{
		this.orientationListener = orientationListener;
	}
	
	public CompassListener getOrientationListener()
	{
		return this.orientationListener;
	}
}
