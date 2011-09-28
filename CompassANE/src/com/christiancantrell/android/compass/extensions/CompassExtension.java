package com.christiancantrell.android.compass.extensions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

public class CompassExtension implements FREExtension
{

	@Override
	public FREContext createContext(String contextType)
	{
		return new CompassExtensionContext();
	}

	@Override
	public void dispose()
	{
		// TODO Auto-generated method stub

	}

	@Override
	public void initialize()
	{
		// TODO Auto-generated method stub
	}

}
