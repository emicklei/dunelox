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
	import com.adobe.utils.DateUtil;
	
	/**
	 * XMLHelper is a utility class used to transform XML data into AS types and back.
	 * 
	 * Rails db types: integer, float, datetime, date, timestamp, time, text, string, binary and boolean.
	 * Flex     types: int    , Number, Date   , Day*, Date,      Time*, string, string, ? , Boolean
	 * 
	 * Day* and Time* are custom types defined by Dunelox
	 */
	public class XMLHelper
	{
		
		public static function stringToDay(value:String):Day {
			return new Day(value)
		}
		public static function dayToString(value:Day):String {
			return value.toString()
		}		
		public static function stringToint(value:String):int {
			return int(value)
		}
		public static function intToString(value:int):String {
			return String(value)
		}
		public static function stringToNumber(value:String):Number {
			return Number(value)
		}
		public static function numberToString(value:Number):String {
			return value.toString()
		}	
		public static function stringToBoolean(value:String):Boolean {
			return value != null && value.toLowerCase() == "true"
		}	
		public static function booleanToString(value:Boolean):String {
			return value.toString()
		}				
		public static function stringToDate(value:String):Date {
			if (value.length == 0) return null
			return DateUtil.parseW3CDTF(value)
		}	
		public static function dateToString(value:Date):String {
			if (value == null) return null			
			return DateUtil.toW3CDTF(value,false)
		}	
		public static function timeToString(value:Time):String {
			if (value == null) return null			
			return value.toString()
		}
		public static function stringToTime(value:String):Time {
			if (value.length == 0) return null			
			return Time.parse(value)
		}
		/**
		 * Append a child node if the value is non-empty and not null
		 */
		 public static function appendChildTo(tag:String,valueOrNull:String,xml:XML):void {
			if (valueOrNull == null) return
			if (valueOrNull.length == 0) return
			xml[tag]=valueOrNull
		 }
	}
}