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
package com.philemonworks.flex.helpers
{
	public class Pre
	{
		/**
		 * Validates that a value is not null. Throws Error otherwise.
		 * If the variable is passed then include that information in the error message.
		 * 
		 * @param value Object
		 * @param variable String optional the name of the variable that has the value
		 */ 
		public static function notNull(value:*,variable:String = null):void {
			if (value == null) {
				var arg:String = variable == null ? '' : ' of variable ['+variable+']'
				throw new Error('[Precondition FAILED] null value' + arg) 
			}
		}
		/**
		 * Validates that a value is not empty. Throws Error otherwise.
		 * If the variable is passed then include that information in the error message.
		 * 
		 * @param value Object
		 * @param variable String optional the name of the variable that has the value
		 */		
		public static function notEmpty(value:String,variable:String = null):void {
			Pre.notNull(value,variable)
			if (value.length == 0) {
				var arg:String = variable == null ? '' : ' of variable ['+variable+']'
				throw new Error('[Precondition FAILED] empty string' + arg) 
			}			
		}	
		/**
		 * Answer the entry in the stacktrace that refers the caller of the caller of this method.
		 */
		private static function sourceOfAttack():String {
			var traceString:String;
			try {
			    throw new Error("**42**");
			} catch (error:Error) {
			    traceString = error.getStackTrace()
			}			
			return traceString.split("\n")[3]	
		}
	}
}