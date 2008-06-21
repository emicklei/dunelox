package com.philemonworks.flex.access
{
	public class AuthorizationMatrix
	{
		public var allRoles:Array = [];
		public var rolesWithFullAccess:Array = [];
		public var grantedRolesToActions:Object = new Object();
		public var deniedRolesToActions:Object = new Object();
		public var grantOnDefault:Boolean = false;
		
		public function isAuthorizedTo(role:String,action:String):Boolean {
			this.updateRoles(role)
			if (rolesWithFullAccess.indexOf(role) != -1) return true
			if (isExplicitlyDenied(role,action)) return false
			if (isExplicitlyGranted(role,action)) return true			
			return grantOnDefault
		}
		public function authorize(isGranted:Boolean,role:String,action:String):void {
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
		public function allowAll(role:String):void {
			this.updateRoles(role)
			rolesWithFullAccess.push(role)
		}
		public function authorizeRolesToAction(isGranted:Boolean,roles:Array,action:String):void {
			for (var r:int=0;r<roles.length;r++)
				authorize(isGranted,roles[r],action)
		}
		public function allowedRoles(action:String):Array {
			return null;	
		}
		private function updateRoles(role:String):void {
			if (allRoles.indexOf(role) == -1) {
				allRoles.push(role)
			}
		}
		private function isExplicitlyGranted(role:String,action:String):Boolean {
			var actions:Array = grantedRolesToActions[role]
			if (actions == null) return false
			return actions.indexOf(action) != -1
		}
		private function isExplicitlyDenied(role:String,action:String):Boolean {
			var actions:Array = deniedRolesToActions[role]
			if (actions == null) return false
			return actions.indexOf(action) != -1
		}		
	}
}