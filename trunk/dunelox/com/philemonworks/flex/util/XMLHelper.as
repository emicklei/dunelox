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
package com.philemonworks.flex.util
{
	import mx.collections.XMLListCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	
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
			return parseW3CDTF(value)
		}	
		public static function dateToString(value:Date):String {
			if (value == null) return null			
			return toW3CDTF(value,false)
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
		 /**
		  * Return an XML of the form <strings each="meaning"><s>...</s></strings>
		  * 
		  * @param strings Array
		  * @param meaning String|null
		  */ 
		 public static function stringsToXML(strings:Array,meaning:String = null):XML {
		 	var stringsXML:XML = <strings/>;
		 	if (meaning != null) stringsXML.@each = meaning
		 	for (var i:int; i<strings.length;i++){
		 		if (strings[i] != null) stringsXML.appendChild(<s>{strings[i]}</s>)
		 	}
		 	return stringsXML
		 }
		 /**
		 * Return a new XMLListCollection with elements from the list, sorted by the field specs.
		 * Example, "@name" will use the attribute "name" of the element for sorting.
		 */
		 public static function sort(list:XMLList,fieldSpec:String,descending:Boolean=true):XMLListCollection {
		 	var collection:XMLListCollection  = new XMLListCollection(list)
		 	var sort:Sort = new Sort()	 	
		 	sort.fields = [new SortField(fieldSpec,descending)]
		 	collection.sort = sort
		   	collection.refresh();
		   	return collection
		 }
		 
	    // COPIED FROM AS3CORELIB .92  TODO		 
		/**
		* Parses dates that conform to the W3C Date-time Format into Date objects.
		*
		* This function is useful for parsing RSS 1.0 and Atom 1.0 dates.
		*
		* @param str
		*
		* @returns
		*
		* @langversion ActionScript 3.0
		* @playerversion Flash 9.0
		* @tiptext
		*
		* @see http://www.w3.org/TR/NOTE-datetime
		*/		     
		public static function parseW3CDTF(str:String):Date
		{
            var finalDate:Date;
			try
			{
				var dateStr:String = str.substring(0, str.indexOf("T"));
				var timeStr:String = str.substring(str.indexOf("T")+1, str.length);
				var dateArr:Array = dateStr.split("-");
				var year:Number = Number(dateArr.shift());
				var month:Number = Number(dateArr.shift());
				var date:Number = Number(dateArr.shift());
				
				var multiplier:Number;
				var offsetHours:Number;
				var offsetMinutes:Number;
				var offsetStr:String;
				
				if (timeStr.indexOf("Z") != -1)
				{
					multiplier = 1;
					offsetHours = 0;
					offsetMinutes = 0;
					timeStr = timeStr.replace("Z", "");
				}
				else if (timeStr.indexOf("+") != -1)
				{
					multiplier = 1;
					offsetStr = timeStr.substring(timeStr.indexOf("+")+1, timeStr.length);
					offsetHours = Number(offsetStr.substring(0, offsetStr.indexOf(":")));
					offsetMinutes = Number(offsetStr.substring(offsetStr.indexOf(":")+1, offsetStr.length));
					timeStr = timeStr.substring(0, timeStr.indexOf("+"));
				}
				else // offset is -
				{
					multiplier = -1;
					offsetStr = timeStr.substring(timeStr.indexOf("-")+1, timeStr.length);
					offsetHours = Number(offsetStr.substring(0, offsetStr.indexOf(":")));
					offsetMinutes = Number(offsetStr.substring(offsetStr.indexOf(":")+1, offsetStr.length));
					timeStr = timeStr.substring(0, timeStr.indexOf("-"));
				}
				var timeArr:Array = timeStr.split(":");
				var hour:Number = Number(timeArr.shift());
				var minutes:Number = Number(timeArr.shift());
				var secondsArr:Array = (timeArr.length > 0) ? String(timeArr.shift()).split(".") : null;
				var seconds:Number = (secondsArr != null && secondsArr.length > 0) ? Number(secondsArr.shift()) : 0;
				var milliseconds:Number = (secondsArr != null && secondsArr.length > 0) ? Number(secondsArr.shift()) : 0;
				var utc:Number = Date.UTC(year, month-1, date, hour, minutes, seconds, milliseconds);
				var offset:Number = (((offsetHours * 3600000) + (offsetMinutes * 60000)) * multiplier);
				finalDate = new Date(utc - offset);
	
				if (finalDate.toString() == "Invalid Date")
				{
					throw new Error("This date does not conform to W3CDTF.");
				}
			}
			catch (e:Error)
			{
				var eStr:String = "Unable to parse the string [" +str+ "] into a date. ";
				eStr += "The internal error was: " + e.toString();
				throw new Error(eStr);
			}
            return finalDate;
		}
	     
	    // COPIED FROM AS3CORELIB .92  TODO
		/**
		* Returns a date string formatted according to W3CDTF.
		*
		* @param d
		* @param includeMilliseconds Determines whether to include the
		* milliseconds value (if any) in the formatted string.
		*
		* @returns
		*
		* @langversion ActionScript 3.0
		* @playerversion Flash 9.0
		* @tiptext
		*
		* @see http://www.w3.org/TR/NOTE-datetime
		*/		     
		public static function toW3CDTF(d:Date,includeMilliseconds:Boolean=false):String
		{
			var date:Number = d.getUTCDate();
			var month:Number = d.getUTCMonth();
			var hours:Number = d.getUTCHours();
			var minutes:Number = d.getUTCMinutes();
			var seconds:Number = d.getUTCSeconds();
			var milliseconds:Number = d.getUTCMilliseconds();
			var sb:String = new String();
			
			sb += d.getUTCFullYear();
			sb += "-";
			
			//thanks to "dom" who sent in a fix for the line below
			if (month + 1 < 10)
			{
				sb += "0";
			}
			sb += month + 1;
			sb += "-";
			if (date < 10)
			{
				sb += "0";
			}
			sb += date;
			sb += "T";
			if (hours < 10)
			{
				sb += "0";
			}
			sb += hours;
			sb += ":";
			if (minutes < 10)
			{
				sb += "0";
			}
			sb += minutes;
			sb += ":";
			if (seconds < 10)
			{
				sb += "0";
			}
			sb += seconds;
			if (includeMilliseconds && milliseconds > 0)
			{
				sb += ".";
				sb += milliseconds;
			}
			sb += "-00:00";
			return sb;
		}
		 
	} // class
} // package