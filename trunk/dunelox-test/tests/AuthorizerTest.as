package tests
{
	import com.philemonworks.flex.access.Authorizer;
	
	import flexunit.framework.TestCase;

	public class AuthorizerTest extends TestCase
	{
		private var auth:Authorizer;
		
		override public function setUp():void {
			auth = new Authorizer()
			auth.matrix.allowAll("root")
			auth.matrix.authorizeRolesToAction(true,["viewer","editor"],"read")
			auth.matrix.authorize(true,"editor","write")
		}
		public function testRoot():void {
			auth.currentRole = "root"
			assertTrue(auth.isAllowed("read"))
			assertTrue(auth.isAllowed("write"))
			assertTrue(auth.isAllowed("execute"))						
		}
		public function testViewer():void {
			auth.currentRole = "viewer"
			assertTrue(auth.isAllowed("read"))
			assertFalse(auth.isAllowed("write"))
			assertFalse(auth.isAllowed("execute"))			
		}		
		public function testEditor():void {
			auth.currentRole = "editor"
			assertTrue(auth.isAllowed("read"))
			assertTrue(auth.isAllowed("write"))
			assertFalse(auth.isAllowed("execute"))			
		}		
	}
}