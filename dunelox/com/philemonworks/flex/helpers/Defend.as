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
	public class Defend
	{
		public static function notNull(value:*):void {
			if (value == null) {
				// throw new Error
				trace ('[Defend] null value' + Defend.sourceOfAttack()) 
			}
		}
		public static function notEmpty(value:String):void {
			if (value == null) {
				// throw new Error
				trace ('[Defend] null value' + Defend.sourceOfAttack()) 
			}
			if (value.length == 0) {
				// throw new Error
				trace ('[Defend] empty string' + Defend.sourceOfAttack()) 
			}			
		}	
		
		public static function againstNull(value:*, variableName:String = null):void {
			if (value == null) {
				var msg:String = '[Defend] null value'
				if (variableName != null) msg = msg + ' for [' + variableName + ']'
				trace (msg + Defend.sourceOfAttack()) 
			}
		}		
			
		private static function sourceOfAttack():String {
			var traceString:String;
			try {
			    throw new Error("**Defend**");
			} catch (error:Error) {
			    traceString = error.getStackTrace()
			}			
			return traceString.split("\n")[3]	
		}
	}
}