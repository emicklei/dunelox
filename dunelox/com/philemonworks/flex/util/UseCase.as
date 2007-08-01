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
	import flash.display.DisplayObject;
	/*
		import flash.display.DisplayObject;
		
		[Bindable]
		public class YourUseCase extends UseCase
		{
			override protected function begin():void {
				// do not forget to include this.end() in the last step of the usecase when completed with success
			}		
		}
	*/	
	public class UseCase
	{
		public var view:DisplayObject;
		private var _endHandler:Function;		
		
		public function start(parentView:DisplayObject = null,endHandler:Function = null):void {
			view = parentView
			_endHandler = endHandler
			this.begin()
		}
		public function stop():void {
			// aborting
		}
		protected function begin():void {
			trace("[warning] all subclasses should implement begin()")
		}
		protected function end():void {
			if (_endHandler != null) _endHandler.call(this,this)
		}
	}
}