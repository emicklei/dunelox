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