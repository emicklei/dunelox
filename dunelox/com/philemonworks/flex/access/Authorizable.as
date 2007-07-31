package com.philemonworks.flex.access
{
	public interface Authorizable
	{
		function setEnabled(isAuthorized:Boolean,notAllowedTip:String = null,allowedTip:String = null):void;
		function setEditable(isAuthorized:Boolean,notAllowedTip:String = null,allowedTip:String = null):void;
	}
}