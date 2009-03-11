/*
   Copyright 2009 Ernest.Micklei @ PhilemonWorks.com

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
package com.philemonworks.flex.net
{
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	/**
	 * RemoteService is an abstract class that provides default behavior for handling FaultEvents
	 * when invoking a remote message.
	 **/
	public class RemoteService
	{
		public function newRemoteObject(destination:String):RemoteObject {
			var remoteObject:RemoteObject = new RemoteObject();
			remoteObject.destination = destination;
			remoteObject.addEventListener("fault", onFault);
			return remoteObject;
		}
		public function onFault(event:FaultEvent):void {
			Alert.show(event.toString())
		}			
	}
}