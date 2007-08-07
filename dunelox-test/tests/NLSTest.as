package tests
{
	import flexunit.framework.TestCase;
	import com.philemonworks.flex.nls.NLS;
	import com.philemonworks.flex.nls.NLSResourceBundle_US;

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
			assertEquals('this is parameter zero',NLS.text('param0',null,['zero']))
		}
	}
}