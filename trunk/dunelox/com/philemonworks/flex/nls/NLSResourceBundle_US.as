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
			return absentValue			
		}
	}
}