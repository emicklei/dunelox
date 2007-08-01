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
package com.philemonworks.flex.util
{
	import mx.core.Application;
		
	[Bindable]
	public class ApplicationContext extends HashCollection
	{
		// Sole Instance
		public static var current:ApplicationContext = new ApplicationContext();
		// Login
		public var currentLogin:String;
		public var currentRole:String;
		// Debug info
		public var DEBUG:Boolean = false;
		public var debugLogin:String;
		public var debugPassword:String;			
	}
}