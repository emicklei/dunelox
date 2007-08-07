package com.philemonworks.flex.util
{
	/**
	 * Observe is a tiny helper class to bind a property to handler.
	 * If a property changes, the source setter is called which in response calls the handler.
	 * 
	 * @author Paul Williams, See http://weblogs.macromedia.com/paulw/archives/2006/05/the_worlds_smal.cfm
	 */
	 public class Observe 
	 { 
		public var handler : Function; 
	 
		public function set source( source : * ) : void 
		{ 
			handler.call(); 
		} 
	}
}