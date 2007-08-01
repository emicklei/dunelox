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
package com.philemonworks.flex.events
{
	import flash.events.Event;

	public class ObjectDataEvent extends Event
	{
		public var data:Object;
		public function ObjectDataEvent(type:String,data:Object = null){
			super(type)
			this.data = data
		}
		override public function clone():Event {
			return new ObjectDataEvent(type,data)
		}
		
		override public function toString():String {
			return "ObjectDataEvent[type="+type+",data="+data+"]"
		}
	}
}