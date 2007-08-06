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
package com.philemonworks.flex.nls
{
	import mx.resources.ResourceBundle;
	
	public class NLSResourceBundle_US implements NLSProvider
	{
		[ResourceBundle("nls_locale_us")]  // requires nls_locale_us.properties files containing key=value lines
		private static var bundle_us:ResourceBundle;
		
		// NLSProvider API
		public function language():String { return "us" }

		// NLSProvider API		
		public function getString(key:String,absentValue:String):String {
			try {
				return bundle_us.getString(key)
			} catch (e:Error) {
				// Probably key absent
				trace("NLS warning: unable to get string because: " + e.message);
			}
			// If no absentValue was specified then return the key to show what is missing from the bundle.
			return absentValue == null ? key : absentValue
		}
	}
}