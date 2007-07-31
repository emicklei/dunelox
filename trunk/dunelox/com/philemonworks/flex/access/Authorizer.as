package com.philemonworks.flex.access
{
	import flash.display.DisplayObject;
	import mx.controls.Button;
	import mx.controls.TextInput;
	import mx.core.UIComponent;
	import mx.core.Container;
	import mx.controls.TextArea;
	import mx.controls.DateField;
	/**
	 * Authorizer is a helper class to change the state of a UIComponent
	 * in response to whether a user in a role has access to that component.
	 * 
	 * @author ernest.micklei@philemonworks.com, 2007
	 */
	public class Authorizer
	{	
		[Bindable]
		public var role:String = "no role";
		
		/**
		 * Constructor
		 */
		public function Authorizer(newRole:String = null) {
			super()
			this.role = newRole
		}
		/**
		 * Changes the editable-property of a component based on whether the current role is one of the expected roles.
		 * If tooltips are provided, the component will changed with respect to this.
		 */							
		public function allowEditable(widget:UIComponent,roles:Array,notAllowedTip:String = null,allowedTip:String = null):void {
			var allow:Boolean = roles.indexOf(role) != -1
			var tip:String = allow ? 
				 (allowedTip == null ? "" : allowedTip)
				:(notAllowedTip == null ? "Not allowed" : notAllowedTip)
			widget.toolTip = tip
			if (widget is TextInput) {
				TextInput(widget).editable = allow
				return
			} else if (widget is TextArea) {
				TextArea(widget).editable = allow
				return
			} else if (widget is DateField) {
				DateField(widget).editable = allow
				return
			} else if (widget is Authorizable) {
				Authorizable(widget).setEditable(allow,notAllowedTip,allowedTip)
			}
		}
		/**
		 * Changes the enabled-property of a component based on whether the current role is one of the expected roles.
		 * If tooltips are provided, the component will changed with respect to this.
		 */							
		public function allowEnabled(widget:UIComponent,roles:Array,notAllowedTip:String = null,allowedTip:String = null):void {
			var allow:Boolean = roles.indexOf(role) != -1
			var tip:String = allow ? 
				 (allowedTip == null ? "" : allowedTip)
				:(notAllowedTip == null ? "Not allowed" : notAllowedTip)
			if (widget is Authorizable) {
				Authorizable(widget).setEnabled(allow,notAllowedTip,allowedTip)
			} else {// generic UIComponent
				widget.enabled = allow
				widget.toolTip = tip
			}
		}		
		/**
		 * Changes the visible-property of a component based on whether the current role is one of the expected roles.
		 * In addition to setting the visibility, the size of the component can be zero-ed
		 * and will be restored to its default when the component is visible.
		 */
		public function allowVisible(widget:UIComponent,roles:Array,resize:Boolean = true):void {
			var show:Boolean = roles.indexOf(role) != -1
			// check if changes are really needed
			if (widget.visible && show) return
			widget.visible = show
			if (!resize) return
			if (show) {
				widget.height = widget.measuredHeight
				widget.width = widget.measuredWidth
			} else {
				widget.height = 0
				widget.width = 0
			}
		}		
	}
}