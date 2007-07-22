package com.philemonworks.flex.navigation
{
	import flash.events.Event;
	
	public class PageNavigationEvent extends Event
	{		
		public function PageNavigationEvent(type:String) {
			super(type)
		}
		override public function clone():Event {
			return new PageNavigationEvent(type)
		}		
		override public function toString():String {
			return "PageNavigationEvent[type="+type+"]"
		}	
		public function getNavigator():PageNavigator {
			return PageNavigator(this.target)
		}	
		public function to():int {
			return this.getNavigator().computeTo()
		}
		public function from():int {
			return this.getNavigator().computeFrom()
		}
	}
}