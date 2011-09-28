//  Adobe(R) Systems Incorporated Source Code License Agreement
//  Copyright(c) 2006-2011 Adobe Systems Incorporated. All rights reserved.
//	
//  Please read this Source Code License Agreement carefully before using
//  the source code.
//	
//  Adobe Systems Incorporated grants to you a perpetual, worldwide, non-exclusive, 
//  no-charge, royalty-free, irrevocable copyright license, to reproduce,
//  prepare derivative works of, publicly display, publicly perform, and
//  distribute this source code and such derivative works in source or 
//  object code form without any attribution requirements.    
//	
//  The name "Adobe Systems Incorporated" must not be used to endorse or promote products
//  derived from the source code without prior written permission.
//	
//  You agree to indemnify, hold harmless and defend Adobe Systems Incorporated from and
//  against any loss, damage, claims or lawsuits, including attorney's 
//  fees that arise or result from your use or distribution of the source 
//  code.
//  
//  THIS SOURCE CODE IS PROVIDED "AS IS" AND "WITH ALL FAULTS", WITHOUT 
//  ANY TECHNICAL SUPPORT OR ANY EXPRESSED OR IMPLIED WARRANTIES, INCLUDING,
//  BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
//  FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  ALSO, THERE IS NO WARRANTY OF 
//  NON-INFRINGEMENT, TITLE OR QUIET ENJOYMENT.  IN NO EVENT SHALL ADOBE 
//  OR ITS SUPPLIERS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
//  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, 
//  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
//  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, 
//  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR 
//  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOURCE CODE, EVEN IF
//  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

package
{
	import com.christiancantrell.extensions.Compass;
	
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.StatusEvent;
	import flash.filters.BevelFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	[SWF(backgroundColor="#336699", frameRate="30")]
	public class CompassApp extends Sprite
	{
		private var compass:Compass;
		private var spinner:Sprite;
		private var directionText:TextField;
		private var azimuthText:TextField;
		
		public function CompassApp()
		{
			super();
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.scaleMode = StageScaleMode.NO_SCALE;

			this.compass = new Compass();
			
			NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, onActivate);
			NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, onDeactivate);
			
			this.doLayout();
		}
		
		private function onActivate(e:Event):void
		{
			this.compass.register();
			this.compass.addEventListener(StatusEvent.STATUS, onStatusUpdate);
			this.stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onDeactivate(e:Event):void
		{
			this.compass.deregister();
			this.compass.removeEventListener(StatusEvent.STATUS, onStatusUpdate);
			this.stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function doLayout():void
		{
			// Background
			var face:Sprite = new Sprite();
			var diameter:Number = this.stage.stageWidth - 10;
			var radius:Number = diameter / 2;
			face.graphics.beginFill(0x333333);
			face.graphics.drawCircle(radius, radius, radius);

			var textFormat:TextFormat = new TextFormat("_sans", diameter / 10, 0xffffff, true, false);

			var north:TextField = new TextField();
			north.defaultTextFormat = textFormat;
			north.text = "N";
			north.x = (diameter / 2) - (north.getLineMetrics(0).width / 2);
			north.y = 0;
			face.addChild(north);

			var south:TextField = new TextField();
			south.defaultTextFormat = textFormat;
			south.text = "S";
			south.x = (diameter / 2) - (south.getLineMetrics(0).width / 2);
			south.y = diameter - (south.getLineMetrics(0).height);
			face.addChild(south);

			var west:TextField = new TextField();
			west.defaultTextFormat = textFormat;
			west.text = "W";
			west.x = 7;
			west.y = (diameter / 2) - (west.getLineMetrics(0).height / 2);
			face.addChild(west);

			var east:TextField = new TextField();
			east.defaultTextFormat = textFormat;
			east.text = "E";
			east.x = (diameter - (east.getLineMetrics(0).width)) - 7;
			east.y = (diameter / 2) - (east.getLineMetrics(0).height / 2);
			face.addChild(east);

			face.x = 5;
			face.y = (this.stage.stageHeight / 2) - (diameter / 2);
			this.addChild(face);
			
			// Needle
			var needle:Sprite = new Sprite();
			
			var needleLength:Number = diameter - 10;
			var needleWidth:Number = needleLength / 10;

			// Top left
			needle.graphics.beginFill(0xff0000);
			needle.graphics.moveTo(0, needleLength / 2);
			needle.graphics.lineTo(needleWidth / 2, 0);
			needle.graphics.lineTo(needleWidth / 2, needleLength / 2);
			needle.graphics.endFill();

			// Top right
			needle.graphics.beginFill(0xff6666);
			needle.graphics.moveTo(needleWidth / 2, needleLength / 2);
			needle.graphics.lineTo(needleWidth / 2, 0);
			needle.graphics.lineTo(needleWidth, needleLength / 2);
			needle.graphics.endFill();
			
			// Bottom left
			needle.graphics.beginFill(0xffffff);
			needle.graphics.moveTo(0, needleLength / 2);
			needle.graphics.lineTo(needleWidth / 2, needleLength);
			needle.graphics.lineTo(needleWidth / 2, needleLength / 2);
			needle.graphics.endFill();

			// Bottom right
			needle.graphics.beginFill(0xcccccc);
			needle.graphics.moveTo(needleWidth / 2, needleLength / 2);
			needle.graphics.lineTo(needleWidth / 2, needleLength);
			needle.graphics.lineTo(needleWidth, needleLength / 2);
			needle.graphics.endFill();

			// center
			var center:Sprite = new Sprite();
			center.graphics.beginFill(0xffcc66);
			center.graphics.drawCircle(needleWidth / 2, (needleLength / 2), needleWidth / 2);
			var centerBevel:BevelFilter = new BevelFilter();
			center.filters = [centerBevel];
			needle.addChild(center);
			
			needle.x = (needle.width / 2) * -1;
			needle.y = (needle.height / 2) * -1;
			
			this.spinner = new Sprite();
			this.spinner.addChild(needle);
			this.spinner.x = this.stage.stageWidth / 2;
			this.spinner.y = this.stage.stageHeight / 2;
			this.addChild(this.spinner);
			
			this.directionText = new TextField();
			this.directionText.defaultTextFormat = textFormat;
			this.directionText.text = "XX";
			this.directionText.width = this.stage.stageWidth / 2;
			this.directionText.y = ((this.stage.stageHeight - diameter) / 4) - (this.directionText.getLineMetrics(0).height / 2);
			this.addChild(this.directionText);

			this.azimuthText = new TextField();
			this.azimuthText.defaultTextFormat = textFormat;
			this.azimuthText.text = "000";
			this.azimuthText.width = this.stage.stageWidth / 2;
			this.azimuthText.y = (this.stage.stageHeight - this.directionText.y) - (this.azimuthText.getLineMetrics(0).height);
			this.addChild(this.azimuthText);
			
			this.updateLabels(0);
		}
		
		private function onEnterFrame(e:Event):void
		{
			if (this.lastAz == this.spinner.rotation) return;
			if (!this.spinner.rotation) this.spinner.rotation = 0;
			var delta:Number = this.lastAz - this.spinner.rotation;
			if (delta > 180) delta -= 360;
			if (delta < -180) delta += 360;
			this.spinner.rotation += (delta / 10);
		}
		
		private var lastAz:Number;
		
		private function onStatusUpdate(e:StatusEvent):void
		{
			var values:Array = e.level.split("&");
			var azimuth:Number = Number(values[0]);
			this.lastAz = ((azimuth > 180) ? azimuth - 360 : azimuth) * -1;
			this.updateLabels(azimuth);
		}
		
		private function updateLabels(azimuth:Number):void
		{
			if (azimuth >= 337.5 || (azimuth >= 0 && azimuth < 22.5))
			{
				this.directionText.text = "N";
			}
			else if (azimuth >= 22.5 && azimuth < 67.5)
			{
				this.directionText.text = "NE";
			}
			else if (azimuth >= 67.5 && azimuth < 112.5)
			{
				this.directionText.text = "E";
			}
			else if (azimuth >= 112.5 && azimuth < 157.5)
			{
				this.directionText.text = "SE";
			}
			else if (azimuth >= 157.5 && azimuth < 202.5)
			{
				this.directionText.text = "S";
			}
			else if (azimuth >= 202.5 && azimuth < 247.5)
			{
				this.directionText.text = "SW";
			}
			else if (azimuth >= 247.5 && azimuth < 292.5)
			{
				this.directionText.text = "W";
			}
			else if (azimuth >= 292.5 && azimuth < 337.5)
			{
				this.directionText.text = "NW";
			}
			this.azimuthText.text = String(Math.round(azimuth) + "\u00B0");
			this.directionText.x = (this.stage.stageWidth / 2) - (this.directionText.getLineMetrics(0).width / 2);
			this.azimuthText.x = (this.stage.stageWidth / 2) - (this.azimuthText.getLineMetrics(0).width / 2);
		}
	}
}