package com.philemonworks.flex.net
{
	[RemoteClass(alias="Dunelox.ServiceResult")]
	[Bindable]
	public class ServiceResult
	{
		public var errorMessages:Array;
		public var heading:String;

		public function isError():Boolean {
			return errorMessages = null || errorMessages.length == 0
		}
	}
}