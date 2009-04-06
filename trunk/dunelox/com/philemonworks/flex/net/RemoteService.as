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
		public static var DefaultTimeout:int = 10;
		
		public function newRemoteObject(destination:String):RemoteObject {
			var remoteObject:RemoteObject = new RemoteObject(destination);
			remoteObject.addEventListener(FaultEvent.FAULT, onFault);
			remoteObject.requestTimeout = DefaultTimeout;
			return remoteObject;
		}
		public function onFault(event:FaultEvent):void {
			trace(this.traceInfo() + "FAULT event thrown");
			if ("Client.Error.RequestTimeout" == event.fault.faultCode) {
				this.handleTimeout(event)	
			} else {
				this.defaultHandleFaultReceived(event)
			}			
		}
		/**
		 * This handler is called when the HttpService did not return with a response without the specified time.
		 * 
		 * @param event FaultEvent
		 */			
		private function handleTimeout(event:FaultEvent):void {
			// TODO make this an event
			Alert.show("The application server did not respond within 10 seconds. Please try again later or contact the Helpdesk", "Application timeout")
		}
		/**
		 * This handler is called when the RemoteObject dispatched a Fault event.
		 * On default, construct a RequestFault object and open a warning dialog.
		 * 
		 * @param event FaultEvent
		 */		
		private function defaultHandleFaultReceived(event:FaultEvent):void {
			/*
			var fault:RequestFault = new RequestFault(null)
			fault.code = event.fault.faultCode
			fault.request = event.fault.faultString
			fault.message = event.fault.message.slice(0,30)
			fault.controller = "not applicable"
			fault.method = event.fault.faultString
			fault.stack = event.fault.getStackTrace()
			RequestFaultDialog.popup(Sprite(Application.application),fault);	
			*/	
			Alert.show(event.toString())	
		}						
	}
}