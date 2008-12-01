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
package com.philemonworks.flex.util
{
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	public class RemoteService
	{
		private var _handler:Function;
		private var _remoteObject:RemoteObject;

		public function RemoteService(handler:Function,destination:String) {
			this._handler = handler
			this._remoteObject = new RemoteObject()
			this._remoteObject.destination = destination
			this._remoteObject.addEventListener("fault", this.onFault)
			this._remoteObject.addEventListener("result", this.onResult)
		}		
		public static function callOnResult(handler:Function,destination:String):RemoteObject {
			return new RemoteService(handler,destination)._remoteObject
		}
		public function onFault(event:FaultEvent):void {
			Alert.show(event.toString())
		}		
		public function onResult(event:ResultEvent):void {
			_handler.call(this,event.result);
		}	
	}
}