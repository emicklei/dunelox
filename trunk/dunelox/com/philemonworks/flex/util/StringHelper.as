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
	public class StringHelper
	{
		/**
		 * Replace all occurrences of "{i}" in a text by its corresponding value in params.
		 * For example, "Hello {0}" substituted with params[0]='World' gives "Hello World"
		 * 
		 * @param text The text with parameters references
		 * @param params The array of values (must respond to toString())
		 * @return The text with all replacements
		 */
		public static function substituteParameters(text:String,params:Array):String {
			var replaced:String = text
			for (var i:int=0;i<params.length;i++) {
				var value:String = params[i].toString()
				replaced = replaced.replace('{'+i+'}',value)
			}
			return replaced
		}		
	}
}