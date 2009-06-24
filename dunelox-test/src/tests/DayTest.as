package tests
{
	import com.philemonworks.flex.util.Day;
	
	import flexunit.framework.TestCase;

	public class DayTest extends TestCase
	{
		// The month (0 for January, 1 for February, and so on)
		// year-month-day
		public function testDayFromString():void {
			var day:Day = new Day("2007-11-30")
			assertEquals(2007, day.toDate().fullYear)
			assertEquals(10, day.toDate().month)
			assertEquals(30, day.toDate().date)
		}
		public function testDayToString():void {
			var day:Day = new Day()
			day.setDate(new Date(2008,10,13))
			assertEquals("2008-11-13", day.toString())
		}
		
		public function testDaySetDateShouldFail():void {
			var day:Day = new Day()
			try {
				day.setDate(null)
				fail("should have failed")
			} catch (error:Error) {
				assertTrue(error.errorID,1009) // TypeError
			}
		}	
		public function testDayFromStringShortYear():void {
			var day:Day = new Day("8-11-13")
			assertEquals(1908, day.toDate().fullYear)
			assertEquals(10, day.toDate().month)
			assertEquals(13, day.toDate().date)
		}		
		public function testDayFromString2():void {
			var day:Day = new Day("2000-01-01")
			assertEquals(2000, day.toDate().fullYear)
			assertEquals(0, day.toDate().month)
			assertEquals(1, day.toDate().date)
		}		
		
		public function testAsDate():void {
			var day:Day = new Day("2008-02-04")
			var date:Date = day.toDate()			
			assertEquals(2008, date.fullYear)
			// The month (0 for January, 1 for February, and so on)
			assertEquals(1, date.month)
			// The day of the month (an integer from 1 to 31)
			assertEquals(4, date.date)
		}	
		public function testDayOfYear():void{
			var day:Day = new Day("2008-12-2")
			assertEquals(336, day.dayOfYear());
		}
		public function testAsDays():void {
			var day:Day = new Day("2008-02-04")
			assertEquals(39115, day.asDays());
		}	
		public function testDayOfyear2():void {
			var then:Day = new Day("2009-06-01")
			assertEquals(152,then.dayOfYear())
		}		
		public function testAsDays2():void {
			var day:Day = new Day("2009-06-01")
			assertEquals(39598, day.asDays());
		}					
		public function testWeekdayIndex():void {
			var day:Day = new Day("2008-02-04")
			assertEquals(1, day.weekdayIndex()); // Monday=1, ... , Sunday=7
		}
		public function testWeekNumber():void {
			var day:Day = new Day("2008-02-04")
			assertEquals(6, day.weekNumber());
		}	
		public function testMonthName():void {
			var day:Day = new Day("2008-02-04")
			assertEquals("February", day.monthName());
		}	
		public function testFirstDayOfWeek():void {
			var first:Day = Day.firstDayOfWeek(23) // this year
			assertEquals(1,first.dayInMonth)
			assertEquals(5,first.month) // 0=January			
		}				
		public function testFromDaysInYear():void {
			var d:Day = Day.fromDaysInYear(1,2009)
			assertEquals(1,d.dayInMonth)
		}			
	}
}