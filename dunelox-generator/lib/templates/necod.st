package $packageroot$.usecases
{
	import com.philemonworks.flex.dialogs.MessageDialog;
	import com.philemonworks.flex.events.ObjectDataEvent;
	import com.philemonworks.flex.net.Reply;
	import com.philemonworks.flex.util.UseCase;
	import $packageroot$.controllers.api.$class$Controller;
	import $packageroot$.models.$class$;
	import $packageroot$.views.$class$TitleWindow;
	import com.philemonworks.flex.util.ApplicationContext;
	
	public class NewEditCopyDestroy$class$ extends UseCase
	{
		public static var NEW:String = "new";
		public static var EDIT:String = "edit";
		public static var COPY:String = "copy";
		public static var DESTROY:String = "destroy";
		
		public var action:String = "new";		
		public var $model$:$class$;	
		
		// privates
		private var controller:$class$Controller = $class$Controller(ApplicationContext.current.get("$class$Controller"))
		private var _window:$class$TitleWindow;
		
		override protected function begin():void {
			if (NEW == action)
				this.create()
			else if (EDIT == action)
				this.edit()
			else if (COPY == action)
				this.copy()
			else if (DESTROY == action)
				this.destroy()		
		}
		protected function create():void {
			$model$ = new $class$()
			this.edit()
		}		
		protected function edit():void {
			_window = $class$TitleWindow.popup(this.view,$model$,false)
			_window.form.saveButton.visible = true
			_window.form.addEventListener("$model$Save", save$class$)
		}
		protected function copy():void {
			
		}
		protected function destroy():void {
			controller.destroy(String($model$.id), replyHandler)
		}		
		public function save$class$(event:ObjectDataEvent):void {
			controller.saveOrUpdate($model$.toXML().toXMLString(), replyHandler)
		}
		private function replyHandler(reply:Reply):void {
			if (reply.hasMessages()) {
				MessageDialog.showWarning(this.view,reply.getMessageText())
			} else {
				if (_window != null) _window.close(null)
				this.end()
			}
		}
	}
}