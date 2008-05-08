/*
   Copyright 2008 Ernest.Micklei @ PhilemonWorks.com

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
package com.philemonworks.flex.helpers
{
	import com.philemonworks.flex.util.ApplicationContext;
	
	/**
	 * AppCtx is a shortcut helper class to access the current ApplicationContext.
	 * 
	 * So instead of writing:
	 *  
	 * 		ApplicationContext.current.get("myobject")
	 * 
	 * you can write:
	 * 
	 * 		AppCtx.get("myobject")
	 * 
	 * which is more compact and still readable.
	 */ 
	public class AppCtx
	{
		public static function get(key:String):Object {
			return ApplicationContext.current.get(key)
		} 
		public static function put(key:String,value:Object):void {
			return ApplicationContext.current.put(key,value)
		} 
		public static function isDebug():Boolean {
			return ApplicationContext.current.DEBUG
		}
	}
}