package com.christiancantrell.extensions
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	public class Compass extends EventDispatcher
	{
		
		private var exContext:ExtensionContext;
		
		public function Compass(target:IEventDispatcher=null)
		{
			super(target);
			this.exContext = ExtensionContext.createExtensionContext("com.christiancantrell.compass","compass");
		}
		
		public function register():void
		{
			this.exContext.call("register");
			this.exContext.addEventListener(StatusEvent.STATUS, onStatusChange);
		}
		
		public function deregister():void
		{
			this.exContext.call("deregister");
			this.exContext.removeEventListener(StatusEvent.STATUS, onStatusChange);
		}
		
		private function onStatusChange(e:StatusEvent):void
		{
			if (e.code == "MAGNETIC_FIELD_CHANGED")
			{
				this.dispatchEvent(e);
			}
		}
	}
}