package com.philemonworks.flex.util
{
	import mx.core.Application;
		
	[Bindable]
	public class ApplicationContext extends HashCollection
	{
		// Sole Instance
		public static var current:ApplicationContext = new ApplicationContext();
		// Login
		public var currentLogin:String;
		public var currentRole:String;
		// Debug info
		public var DEBUG:Boolean = false;
		public var debugLogin:String;
		public var debugPassword:String;			
	}
}