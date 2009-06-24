/*
   Copyright 2007-2009 Ernest.Micklei @ PhilemonWorks.com

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
		public static var MonthNames:Array = ["January","February","March","May","June","July","August","October","November","December"];
		public static var DayNames:Array = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"];
		public static var FirstDayOfMonth:Array = [1,32,60,91,121,152,182,213,244,274,305,335];	
		
		public var year:int = 0;
		public var month:int = 0; // The month (0 for January, 1 for February, and so on)
		public var dayInMonth:int = 0; // The day of the month (an integer from 1 to 31)
						
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
		 * Answer with an instance of Date that is dayCount days since 1901 began.
		 **/
		public static function fromDays(totalDays:int):Day {
			var year:int = 1901 + ((totalDays / 1461) * 4)
			var days:int = 1 + (totalDays % 1461)
			var theDay:Day = Day.fromDaysAfterYear(days,year)
			var correction:int = totalDays - theDay.asDays()
			return correction == 0 ? theDay : theDay.addDays(correction)
		}	
		public static function daysInYear(year:int):int {
			return 365 + leapYear(year)
		}
		/**
		 * Return the Day from 1 January + daysInYear of @year
		 */
		public static function fromDaysInYear(daysInYear:int,year:int):Day {			
			var itsMonth:int = 0
			while (FirstDayOfMonth[itsMonth] < daysInYear) {itsMonth = itsMonth + 1}
			var itsDay:int = itsMonth == 0 ? daysInYear : daysInYear - FirstDayOfMonth[itsMonth-1] + 1
			var day:Day = new Day()
			day.init(year,itsMonth,itsDay)
			return day
		}
		/**
		 * Starting @year, compute the new Day after @dayCount
		 */
		public static function fromDaysAfterYear(dayCount:int,year:int):Day {
			var dayNum:int = dayCount
			var yearNum:int = year
			var daysInYear:int = 0
			while (dayNum > (daysInYear = Day.daysInYear(yearNum))) {
				yearNum += 1
				dayNum -= daysInYear
			}
			while (dayNum <= 0) {
				yearNum -= 1
				dayNum += Day.daysInYear(yearNum)
			}	
			return Day.fromDaysInYear(dayNum,yearNum)	
		}
		/**
		 * Returns the day of the start of a week
		 */
		public static function firstDayOfWeek(weekNumber:int):Day {
			var today:Day = new Day()
			var weekNow:int = today.weekNumber()
			var dayNow:int = today.weekdayIndex() // Mon=1
			var monday:Day = dayNow == 1 ? today : today.subtractDays(dayNow - 1)
			if (weekNumber == weekNow) return monday
			if (weekNumber < weekNow) return monday.subtractDays((weekNow - weekNumber)*7)
			return monday.addDays((weekNow - weekNumber)*7)
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
		/**
		 * Convert the receiver to a normal Date
		 */
		public function toDate():Date {
			return new Date(this.year,this.month,this.dayInMonth)
		}
		public function setDate(dateTime:Date):void {
			this.init(dateTime.fullYear,dateTime.month,dateTime.date)					
		}
		/**
		 * Answer 1 if the year yearInteger is a leap year;  answer 0 if it is not. 
		 **/
		public static function leapYear(yearInteger:int):int {
			if (yearInteger % 4 != 0 || (yearInteger % 100 == 0 && (yearInteger % 400 != 0)))
				return 0
			else
				return 1
		}
		/**
		 * Answer the number of days between January 1, 1901 and the receiver's day.
		 **/
		public function asDays():int {
			var yearIndex:int = year - 1901
			return yearIndex * 365  // elapsed years
				+ (yearIndex / 4)  // ordinary leap years
				+ ((yearIndex + 300) / 400)  // leap centuries, first one is 2000, i.e. yearIndex = 99
				- (yearIndex / 100)  // non-leap centuries
				+ this.dayOfYear() - 1			
		}
		/**
		 * 1 = January 1, 335 = December 1
		 **/ 
		public function dayOfYear():int {
			return FirstDayOfMonth[month] + dayInMonth - 1;
		}
		/**
		 * Monday=1, ... , Sunday=7
		 */
		public function weekdayIndex():int {
			return (this.asDays() + 1) % 7 + 1  // 1 January 1901 was a Tuesday
		}
		/**
		 * Monday, Tuesday,..
		 */
		public function weekdayName():String {
			return DayNames[this.weekdayIndex()]
		}
		/**
		 * 1..53
		 */
		public function weekNumber():int {
			var dayOf11:int = this.weekdayIndex() // Monday=1
	 		// before or on Thursday = 4
	 		var dayOffset:int = dayOf11 <= 4 ? dayOf11 + 4 : dayOf11 + 11
	 		var weekIndex:int = (this.dayOfYear() + dayOffset - 1) / 7 + 1
	 		// 1-1 same day in week as 31-12, except for leap
	 		if (weekIndex == 53 && (dayOf11 < (4 - leapYear(year)))) {
	 			return 1
	 		}
	 		// if 0 then 31-12 last year can tell
	 		if (weekIndex == 0) {
	 			var day3112:Day = new Day()
	 			return day3112.init(year-1,12,31).weekNumber()
	 		}
	 		return weekIndex	
		}
		/**
		 * January,February,...
		 */
		public function monthName():String {
			return MonthNames[month];
		}
		/**
		 * Returns a new Day @numberOfDays in the future/past
		 */
		public function addDays(numberOfDays:int):Day {
			return Day.fromDaysAfterYear(this.dayOfYear()+numberOfDays,year)
		}
		/**
		 * Returns a new Day @numberOfDays in the past/future
		 */		
		public function subtractDays(numberOfDays:int):Day {
			return Day.fromDaysAfterYear(this.dayOfYear()-numberOfDays,year)
		}
	}
}