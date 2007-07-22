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
package com.philemonworks.flex.util
{
	import flash.display.DisplayObject;
	
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