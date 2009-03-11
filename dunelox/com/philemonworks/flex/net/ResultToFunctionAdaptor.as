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
	import mx.rpc.events.ResultEvent;
	/**
	 * ResultToFunctionAdaptor is a nice tiny single-purpose class
	 * that can be used in combination of Flash Remoting or the Http Service.
	 * It implements the standard onResult function that is called upon succesfully invoking a service.
	 * That function in return calls the handler function that was used to create te Adaptor.
	 * Example:
	 * 
	 * remoteObject.someOperation.addEventListener("result", new ResultToFunctionAdaptor(handleResultOfOperation).onResult);
	 * 
	 **/
	public class ResultToFunctionAdaptor
	{
		private var _handler:Function;
		
		public function ResultToFunctionAdaptor(handler:Function)
		{
			this._handler = handler
		}
		public function onResult(event:ResultEvent):void {
			_handler.call(this,event.result);
		}

	}
}