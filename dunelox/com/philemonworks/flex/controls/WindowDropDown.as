/*
   Copyright [2007] Ernest.Micklei @ PhilemonWorks.com

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/ 
package com.philemonworks.flex.controls
{
	import flash.events.Event;
	import mx.events.EffectEvent;
	import mx.effects.Move;
	import mx.core.UIComponent;
	import mx.events.CloseEvent;
	
	/**
	 * WindowDropDown is an animation effect that can be applied to a TitleWindow.
	 * It makes a window slide-in from the center top position.
	 * When closing the window, it will slideout to the center top position.
	 * 
	 * Usage:
	 * 		
	 * 		WindowDropDown.start(window,windowClosed);
	 * 
	 * 
	 * @author Ernest.Micklei@PhilemonWorks.com, 2007
	 */
	public class WindowDropDown
	{
		[Bindable]
		public var endFunction:Function; // must be zero-argument function	
		private var target:UIComponent;
		
		public static function start(component:UIComponent, endHandler:Function):void {
			var dropper:WindowDropDown = new WindowDropDown()
			dropper.endFunction = endHandler
			dropper.start(component)
		}
		public function start(component:UIComponent):void {
			this.target = component
			this.target.addEventListener("close", end);
			this.slideInCenterFromTop()			
		}		
	   public function end(event:Event):void {
	   		this.slideOutCenterToTop()
	   }		
	   private function slideInCenterFromTop():void {
	       target.move((target.parent.width - target.width)/2,0 - target.height / 2)
	       var move:Move = new Move()
	       move.target = target
	       move.duration = 500
	       move.yFrom = 0 - target.height
	       move.yTo = 0
	       move.play()
	   }
	   private function slideOutCenterToTop():void {
	       var move:Move = new Move()
	       move.target = target
	       move.duration = 250
	       move.yFrom = target.y
	       move.yTo = 0 - target.height
	       move.play()
	       move.addEventListener(EffectEvent.EFFECT_END,slideEnded)
	   }			
	   private function slideEnded(event:Event):void {
	   		if (endFunction == null) return
	   		endFunction.call(this)
	   }		
	}
}