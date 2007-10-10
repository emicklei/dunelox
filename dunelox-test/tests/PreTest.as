package tests
{
	import flexunit.framework.TestCase;
	import com.philemonworks.flex.helpers.Pre;

	public class PreTest extends TestCase
	{
		public function testNotNull():void {
			var somevar:Object = null
			Pre.notNull(null)
			Pre.notNull(null,'somevar')
		}
	}
}