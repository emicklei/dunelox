package tests
{
	import flexunit.framework.TestCase;
	import com.philemonworks.flex.helpers.Defend;

	public class DefendTest extends TestCase
	{
		public function testNotNull():void {
			Defend.notNull(null)
		}
	}
}