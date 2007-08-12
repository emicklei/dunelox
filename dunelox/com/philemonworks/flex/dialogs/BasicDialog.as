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
package com.philemonworks.flex.dialogs
{
	import mx.containers.TitleWindow;
	import mx.managers.PopUpManager;
	import mx.core.IFlexDisplayObject;
	import flash.events.Event;
	import mx.effects.Move;
	import mx.events.EffectEvent;
	
	public class BasicDialog extends TitleWindow
	{
		public var center:Boolean = true;
		public var slide:Boolean = false;
		protected var accepted:Boolean = false;
		protected var okCallback:Function;
				
		protected function doOk():void {
			accepted = true
			// this causes the function to be executed on the object that "popupped" the login
			if (okCallback == null)
				this.close()
			else if (this.validateOk()) okCallback.call(this,this);
		}
		// this is called directly from the buttons		
		protected function doCancel():void {
			this.close()
		}
		// this is called directly from the buttons or indirectly from the window		
		public function close():void {
			if (slide) 
				this.slideOutCenterToTop()
			else
				this.destroy()
		}		
		// this is called when the window is closed
		protected function closeFromPopup(event:Event):void {
			this.close();
		}		
		// alias
		protected function closeThis():void {this.close()}				
		
		public function show(okHandler:Function = null):void {
			okCallback = okHandler
			if (center) PopUpManager.centerPopUp(this);	
			if (slide) this.slideInCenterFromTop();							
			this.addEventListener("close", this.closeFromPopup);
		}		
		// Subclasses may redefine this to do extra checks.
		// Do not forget to call super.validateOk()
		protected function validateOk():Boolean {
			return okCallback != null && accepted
		}
		private function destroy():void {
			PopUpManager.removePopUp(IFlexDisplayObject(this));
		}
	   private function slideInCenterFromTop():void {
	       this.move((this.parent.width - this.width)/2,0 - this.height / 2)
	       var move:Move = new Move()
	       move.target = this
	       move.duration = 500
	       move.yFrom = 0 - this.height
	       move.yTo = 0
	       move.play()
	   }
	   public function slideOutCenterToTop():void {
	       var move:Move = new Move()
	       move.target = this
	       move.duration = 250
	       move.yFrom = this.y
	       move.yTo = 0 - this.height
	       move.play()
	       move.addEventListener(EffectEvent.EFFECT_END,slideEnded)
	   }			
	   public function slideEnded(event:Event):void {
	   		this.destroy()
	   }	   
	}
}