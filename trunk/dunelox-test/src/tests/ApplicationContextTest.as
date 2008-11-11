package tests
{
	import flexunit.framework.TestCase;
	import com.philemonworks.flex.util.ApplicationContext;
	import flexunit.framework.Assert;
	
	public class ApplicationContextTest extends TestCase
	{
		public var ctx:ApplicationContext = new ApplicationContext()
		
		public function testEmpty():* {
			ctx.get('missing')	
		}
		public function testOne():* {
			ctx.put('one', 'one')
			Assert.assertEquals(ctx.get('one'),'one')
		}
		public function testEmptyKey():* {
			ctx.put('', 'empty')
			Assert.assertEquals(ctx.get(''),'empty')
		}	
		public function testNull():* {
			ctx.put('null', null)
			Assert.assertEquals(ctx.get('null'),null)
		}			

	}
}