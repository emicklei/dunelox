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
	import com.philemonworks.flex.util.StringHelper;
	import mx.controls.dataGridClasses.DataGridColumn;
	import com.philemonworks.flex.util.XMLHelper;
	import com.philemonworks.flex.util.Day;
	/**
	 * NLS is a class that encapsulates internationalized values for string keys.
	 * NLS provides convenience methods to access text (with defaults),dates,money,phone formatter values
	 * 
	 * @author ernest.micklei@philemonworks.com, 2007
	 */ 
	public class NLS
	{
	   public static const NLS_KEY_DATE:String = "nls-format-date"	   
	   public static const NLS_KEY_DATETIME:String = "nls-format-datetime"	   
	   
	   public static var NLS_DateFormatter:DateFormatter;
	   public static var NLS_DateTimeFormatter:DateFormatter;
	   
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
		 * Use this function as a labelFunction for a DataGridColumn that needs a formatted Day whos value is a xsd:date formatted String.
		 * @param item the item of the row
		 * @param column the column that specifies which dataField value (XSD format) to format using NLS rules.
		 * @return Formatted date without time
		 */
		public static function formatStringAsDay(item:Object, column:DataGridColumn):String {
			var someDay:Day = XMLHelper.stringToDay(item[column.dataField])
			return getDateFormatter().format(someDay.toDate())
		}
		/**
		 * Use this function as a labelFunction for a DataGridColumn that needs a formatted Date with Time whos value is a xsd:datetime formatted String.
		 * @param item the item of the row
		 * @param column the column that specifies which dataField value (XSD format) to format using NLS rules.
		 * @return Formatted date
		 */
		public static function formatStringAsDateTime(item:Object, column:DataGridColumn):String {
			var date:Date = XMLHelper.stringToDate(item[column.dataField])
			return getDateTimeFormatter().format(date)
		}
				
		/**
		  <mx:DateFormatter
		    formatString="Y|M|D|A|E|H|J|K|L|N|S"
		   /> 
   		*/ 	
		public static function getDateFormatter():DateFormatter {
			if (NLS_DateFormatter != null) return NLS_DateFormatter
		    var formatter:DateFormatter = new DateFormatter();
			formatter.formatString = text(NLS_KEY_DATE,"YYYY-DD-MM")
			return (NLS_DateFormatter = formatter)			
		}
		public static function getDateTimeFormatter():DateFormatter {
			if (NLS_DateTimeFormatter != null) return NLS_DateTimeFormatter
		    var formatter:DateFormatter = new DateFormatter();
			formatter.formatString = text(NLS_KEY_DATETIME,"YYYY-DD-MM HH:NN");
			return (NLS_DateTimeFormatter = formatter);			
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