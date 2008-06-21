/*
   Copyright 2008 Ernest.Micklei @ PhilemonWorks.com

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
	/**
	 * AuthorizationMatrix manages information about granted and denied access
	 * to perform actions by users with a role. 
	 * Access to this class if needed when initializing the Authorizer.
	 * 
	 * @author ernest 
	 */
	public class AuthorizationMatrix
	{
		public var allRoles:Array = [];
		public var rolesWithFullAccess:Array = [];
		public var grantedRolesToActions:Object = new Object();
		public var deniedRolesToActions:Object = new Object();
		public var grantOnDefault:Boolean = false;
		
		/**
		 * Answer whether a user with this role is allowed (authorized,granted) to perform this action
		 *  
		 * @param role
		 * @param action
		 * @return 
		 * 
		 */
		public function isAuthorizedTo(role:String,action:String):Boolean {
			this.updateRoles(role)
			if (rolesWithFullAccess.indexOf(role) != -1) return true
			if (isExplicitlyDenied(role,action)) return false
			if (isExplicitlyGranted(role,action)) return true			
			return grantOnDefault
		}
		/**
		 * Grant or denied the action to users with this role
		 * 
		 * @param isGranted
		 * @param role
		 * @param action
		 * 
		 */
		public function authorize(isGranted:Boolean,role:String,action:String):void {
			if (role == null || action == null)
				throw new Error("Illegal arguments: role="+role+",action="+action)
			this.updateRoles(role)
			var actions:Array
			if (isGranted) {
				actions = grantedRolesToActions[role]
				if (actions == null) { actions = [] }
				if (actions.indexOf(action) != -1) return
				actions.push(action)
				grantedRolesToActions[role] = actions
			} else {
				actions = deniedRolesToActions[role]
				if (actions == null) { actions = [] }
				if (actions.indexOf(action) != -1) return
				actions.push(action)
				deniedRolesToActions[role] = actions	
			}
		}
		/**
		 * This role will have God mode.
		 * @param role 
		 */			
		public function allowAll(role:String):void {
			this.updateRoles(role)
			rolesWithFullAccess.push(role)
		}
		/**
		 * Grant or deny the action for all roles.
		 * @param isGranted
		 * @param roles
		 * @param action
		 */			
		public function authorizeRolesToAction(isGranted:Boolean,roles:Array,action:String):void {
			for (var r:int=0;r<roles.length;r++)
				authorize(isGranted,roles[r],action)
		}
		/**
		 * Grant or deny all actions for all roles.
		 * @param isGranted
		 * @param roles
		 * @param actions 
		 */		
		public function authorizeRolesToActions(isGranted:Boolean,roles:Array,actions:Array):void {
			for (var a:int=0;a<actions.length;a++)
				authorizeRolesToAction(isGranted,roles,actions[a])
		}		
		/**
		 * Ensure the role is known in allRoles
		 */		
		private function updateRoles(role:String):void {
			if (role == null)
				throw new Error("Illegal argument: role="+role)
			if (allRoles.indexOf(role) == -1) {
				allRoles.push(role)
			}
		}
		/**
		 * Return whether the action is granted for this role by configuration
		 */		
		private function isExplicitlyGranted(role:String,action:String):Boolean {
			var actions:Array = grantedRolesToActions[role]
			if (actions == null) return false
			return actions.indexOf(action) != -1
		}
		/**
		 * Return whether the action is denied for this role by configuration
		 */
		private function isExplicitlyDenied(role:String,action:String):Boolean {
			var actions:Array = deniedRolesToActions[role]
			if (actions == null) return false
			return actions.indexOf(action) != -1
		}		
	}
}