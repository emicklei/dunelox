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
	import mx.formatters.DateFormatter;
		
	/**
	 * Day represents the day part of a Date, i.e. no Time information.
	 * 
	 * @author ernest.micklei@philemonworks.com
	 */
	[RemoteClass(alias="com.philemonworks.flex.util.Day")]
	public class Day
	{
		private var year:int = 0;
		private var month:int = 0; // The month (0 for January, 1 for February, and so on)
		private var dayInMonth:int = 0; // The day of the month (an integer from 1 to 31)
						
		/**
		 * @xmlFormattedString String YYYY-MM-DD
		 */						
		public function Day(xmlFormattedString:String = "") {
			if (xmlFormattedString.length != 0) {
				var parts:Array = xmlFormattedString.split('-')
				this.init(int(parts[0]),int(parts[1])-1,int(parts[2]))
			} else {
				var today:Date = new Date()
				this.init(today.fullYear,today.month,today.date)		
			}
		}
		/**
		 * Initialize me.
		 * 
		 * @param month int The month (0 for January, 1 for February, and so on)
		 * @param day int The day of the month (an integer from 1 to 31)
		 */
		public function init(year:int,month:int,day:int):Day {
			this.year = year
			this.month = month
			this.dayInMonth = day			
			return this
		}
		public static function fromDate(dateTime:Date):Day {
			var newDay:Day = new Day()
			if (dateTime == null) return newDay
			newDay.init(dateTime.fullYear,dateTime.month,dateTime.date)		
			return newDay
		}		
		/**
		 * Format using YYYY-MM-DD
		 */
		public function toXMLString():String {
			var formatter:DateFormatter = new DateFormatter()
			formatter.formatString = "YYYY-MM-DD"
			return formatter.format(this.toDate())
		}		
		/**
		 * Format using YYYY-MM-DD
		 */
		public function toString():String {
			return this.toXMLString()
		}
		public function toDate():Date {
			return new Date(year,month,dayInMonth)
		}
		public function setDate(dateTime:Date):void {
			this.init(dateTime.fullYear,dateTime.month,dateTime.date)					
		}
	}
}