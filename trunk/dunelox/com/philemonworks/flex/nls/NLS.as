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
	import mx.formatters.DateFormatter;
	import mx.formatters.CurrencyFormatter;
	/**
	 * NLS is a class that encapsulates internationalized values for string keys.
	 * NLS provides convenience methods to access text (with defaults),dates,money,phone formatter values
	 * 
	 * @author ernest.micklei@philemonworks.com, 2007
	 */ 
	public class NLS
	{
	   public static const NLS_KEY_DATE:String = "nls-format-date"	   
	   private static var nlsProvider:NLSProvider;
	   	
		/**
		 * Gets a string from the current NLS Provider.
		 * Return the absentValue if the key was missing. This exception is traced.
		 * If the absentValue is null and no value is associated to the key, then return the key.
		 * Try binding parameter values if provided and referenced by the string (using {index} notation)
		 */
		public static function text(key:String,absentValue:String = null, parameters:Array = null):String {
			if (nlsProvider == null) {
				trace("NLS: no provider")
				return absentValue
			}
			var value:String = nlsProvider.getString(key,absentValue)
			return parameters == null ? value : StringHelper.substituteParameters(value,parameters)
		}
		/**
		 * Gets a formatted date using the ResourceBundle for the current language.
		 */		
		public static function date(someDay:Date):String {
			return getDateFormatter().format(someDay);
		}
		/**
		 * Gets a formatted monetary amount using the ResourceBundle for the current language.
		 */		
		public static function money(amount:Number):String {
			return getCurrencyFormatter().format(amount)
		}
		//----------------
		// Formatters
		//----------------
		/**
		  <mx:DateFormatter
		    formatString="Y|M|D|A|E|H|J|K|L|N|S"
		   /> 
   		*/ 	
		public static function getDateFormatter():DateFormatter {
		    var formatter:DateFormatter = new DateFormatter();
			formatter.formatString = text(NLS_KEY_DATE,"YY-DD-MM");
			return formatter;			
		}
		/**
		  <mx:CurrencyFormatter
		    alignSymbol="left|right" 
		    currencySymbol="$"
		    decimalSeparatorFrom="."
		    decimalSeparatorTo="."
		    precision="-1"
		    rounding="none|up|down|nearest"
		    thousandsSeparatorFrom=","
		    thousandsSeparatorTo=","
		    useNegativeSign="true|false"
		    useThousandsSeparator="true|false"
			 />
	 	**/
		public static function getCurrencyFormatter():CurrencyFormatter {
			return new CurrencyFormatter();			
		}
		// Setup
		public static function setProvider(otherProvider:NLSProvider):void {
			nlsProvider = otherProvider
		}
	   	public static function getProvider():NLSProvider {
	   		return nlsProvider
	   	}		
	}
}