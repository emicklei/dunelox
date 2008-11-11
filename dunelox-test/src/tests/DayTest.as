package tests
{
	import flexunit.framework.TestCase;
	import com.philemonworks.flex.util.Day;

	public class DayTest extends TestCase
	{

		public function testDayFromString():void {
			var day:Day = new Day("2007-11-30")
			assertEquals(2007, day.toDate().fullYear)
			assertEquals(10, day.toDate().month)
			assertEquals(30, day.toDate().date)
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
	}
}