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
	import mx.formatters.DateFormatter;
	
	/**
	 * 1967-11-20
	 */
	public class Day
	{
		private var formattedDay:String
		
		public function Day(dayString:String = "") {
			super()			
			if (dayString.length != 0) {
				formattedDay = dayString
			} else {
				this.setDate(new Date())
			}
		}
		public function toString():String {
			return formattedDay 
		}
		public function toDate():Date {
			var parts:Array = formattedDay.split('-')
			// The month (0 for January, 1 for February, and so on)
			// The day of the month (an integer from 1 to 31)
			return new Date(int(parts[0]),int(parts[1])-1,int(parts[2]))
		}
		public function setDate(dateTime:Date):void {
			var formatter:DateFormatter = new DateFormatter()
			formatter.formatString = "YYYY-MM-DD"
			formattedDay = formatter.format(dateTime)						
		}
	}	
}