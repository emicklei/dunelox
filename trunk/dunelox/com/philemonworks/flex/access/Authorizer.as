/*
   Copyright 2007,2008 Ernest.Micklei @ PhilemonWorks.com

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
package com.philemonworks.flex.access
{
	import com.philemonworks.flex.util.ApplicationContext;
	
	import mx.controls.DateField;
	import mx.controls.TextArea;
	import mx.controls.TextInput;
	import mx.core.UIComponent;
	/**
	 * Authorizer is a helper class to change the state of a UIComponent
	 * in response to whether a user in a role has access to that component.
	 * It uses an AuthorizationMatrix to manage information about what actions are allowed for what roles.
	 * Before using the API make sure you set the current role which is typically derived from the current user.
	 * 
	 * @author ernest.micklei@philemonworks.com, 2007
	 */
	public class Authorizer
	{	
		public var matrix:AuthorizationMatrix = new AuthorizationMatrix();
		
		public function get currentRole():String {
			return ApplicationContext.current.currentRole
		}
		public function set currentRole(newRole:String):void {
			ApplicationContext.current.currentRole = newRole
		}
		
		/**
		 * Return whether a user with currentRole is allowed to perform this action.
		 * @param action
		 * @return true if allowed
		 */
		public function isAllowedTo(action:String):Boolean {
			if (ApplicationContext.current.DEBUG) {
				var granted:Boolean = matrix.isAuthorizedTo(currentRole,action)
				trace("[Authorizer] " + currentRole + " is "+(granted?"":"NOT ")+"authorized to do: " + action)
				return granted
			} else return matrix.isAuthorizedTo(currentRole,action);
		}
		/**
		 * Changes the editable-property of a component based on whether the current role is one of the expected roles.
		 * If tooltips are provided, the component will changed with respect to this.
		 */							
		public function allowEditable(widget:UIComponent,allow:Boolean,notAllowedTip:String = null,allowedTip:String = null):void {
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
			}
		}
		/**
		 * Changes the enabled-property of a component based.
		 * If tooltips are provided, the component will changed with respect to this.
		 */							
		public function allowEnabled(widget:UIComponent,allow:Boolean,notAllowedTip:String = null,allowedTip:String = null):void {
			var tip:String = allow ? 
				 (allowedTip == null ? "" : allowedTip)
				:(notAllowedTip == null ? "Not allowed" : notAllowedTip)
			widget.enabled = allow
			widget.toolTip = tip
		}		
		/**
		 * Changes the visible-property of a component based on whether the current role is one of the expected roles.
		 * In addition to setting the visibility, the size of the component can be zero-ed
		 * and will be restored to its default when the component is visible.
		 */
		public function allowVisible(widget:UIComponent,show:Boolean,resize:Boolean = true):void {
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