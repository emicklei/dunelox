package com.philemonworks.flex.util
{
	/**
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