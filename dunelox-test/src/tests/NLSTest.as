package tests
{
	import flexunit.framework.TestCase;
	import com.philemonworks.flex.nls.NLS;
	import com.philemonworks.flex.nls.NLSResourceBundle_US;
	import com.philemonworks.flex.util.Day;

	public class NLSTest extends TestCase
	{
		override public function setUp():void {
			NLS.setProvider(new NLSResourceBundle_US())
		}
		
		public function testGetText():void {
			assertEquals('TestMe',NLS.text('test'))
		}
		public function testGetTextDefault():void {
			assertEquals(NLS.text('missing','DEFAULT'),'DEFAULT')
		}		
		public function testGetDate():void {
			assertNotNull(NLS.date(new Date()))
		}
		public function testGetMoney():void {
			assertNotNull(NLS.money(123.45))
		}
		public function testParam0():void {
			assertEquals('this is parameter zero',NLS.expandText('param0',['zero']))
		}
		public function testFormatDay():void {
			var now:Day = new Day()
			var nowString:String = NLS.day(now)
			assertNotNull(nowString)
		}
	}
}