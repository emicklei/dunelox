package tests
{
	import flexunit.framework.TestCase;
	import com.philemonworks.flex.helpers.Pre;

	public class PreTest extends TestCase
	{
		public function testNotNull():void {
			var somevar:Object = null
			Pre.notNull("notnull")
			try {
				Pre.notNull(null,'somevar')
				fail("should have raised an error")
			} catch (error:Error) {
				//  ok
			}
		}
	}
}