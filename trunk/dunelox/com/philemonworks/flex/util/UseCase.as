/*
   Copyright 2007 Ernest.Micklei @ PhilemonWorks.com

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
	import flash.display.DisplayObject;
	/*
		import flash.display.DisplayObject;
		
		[Bindable]
		public class YourUseCase extends UseCase
		{
			override protected function begin():void {
				// do not forget to call this.end() in the last step of the usecase when completed with success
				// or to call this.stop() when the usecase completed with a failure
			}	
			override protected function checkPreconditions():Boolean {
				// check all variable values, raise exceptions or show warnings if values are not as specified
				// return true if conditions are met
			}	
		}
	*/	
	public class UseCase
	{
		/**
		 * The view in which the UseCase is started if provided by start(...)
		 */ 
		public var view:DisplayObject;
		/**
		 * The handler that is called when the UseCase is finished.
		 */
		private var _endHandler:Function;		
		/**
		 * The handler that is called when the UseCase is aborted.
		 */ 
		private var _abortHandler:Function;
		
		/**
		 * Start the UseCase.
		 * 
		 * @param parentView Object (optional, but if specified than make sure it is a DisplayObject)
		 * @param finishedHandler Function (optional)
		 * @param abortedHandler Function (optional)
		 */ 
		public function start(parentView:Object = null,finishedHandler:Function = null, abortedHandler:Function = null):void {
			view = parentView == null ? null : parentView as DisplayObject
			_endHandler = finishedHandler
			if (this.checkPreconditions()) {
				this.begin()
			} else {
				trace('[UseCase:warning] ' + this + ' preconditions failed, stopping usecase')
				this.stop()
			}
		}
		/**
		 * Stop the UseCase and call the handler for aborting.
		 */
		public function stop():void {
			if (_abortHandler != null) _abortHandler.call(this,this)
		}
		/**
		 * Subclasses should override this to validate all input values. Default implementation returns true.
		 */ 
		protected function checkPreconditions():Boolean {
			return true
		}
		/**
		 * Subclasses should override this to perform the steps of the UseCase. A message is traced if the UseCase does not override this method.
		 */
		protected function begin():void {
			trace('[UseCase:warning] ' + this + ' subclasses should implement begin()')
		}
		/**
		 * UseCase has finished normally. Call the end handler passing the UseCase as its parameter.
		 */
		protected function end():void {
			if (_endHandler != null) _endHandler.call(this,this)
		}
	}
}