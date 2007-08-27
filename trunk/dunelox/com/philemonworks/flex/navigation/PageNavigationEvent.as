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
package com.philemonworks.flex.navigation
{
	import flash.events.Event;
	
	public class PageNavigationEvent extends Event
	{		
		public var to:int;
		public var from:int;
		public var sortKey:String;
		public var sortMethod:String;
		public var searchPattern:String;

		public function PageNavigationEvent(type:String) {
			super(type)
		}
		override public function clone():Event {
			var event:PageNavigationEvent = new PageNavigationEvent(type)
			event.to = to
			event.from = from
			event.sortKey = sortKey
			event.sortMethod = sortMethod
			event.searchPattern = searchPattern
			return event
		}		
		override public function toString():String {
			return "PageNavigationEvent[type="+type+"]"
		}	
		public function getNavigator():PageNavigator {
			return PageNavigator(this.target)
		}	
	}
}