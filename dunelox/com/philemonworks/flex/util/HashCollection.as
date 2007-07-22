package com.philemonworks.flex.util
{
	import mx.collections.ArrayCollection;

	/**
	 * HashCollection implements a Hash in which the values are Bindable.
	 * This means that other objects can be notified when a value changes.
	 * 
	 * @author Ernest.Micklei, 2007
	 */
	public class HashCollection extends ArrayCollection
	{
		public function HashCollection(source:Array=null)
		{
			super(source);
		}
		private var _keyToIndexHash:Object = new Object()
		
		public function put(key:Object,value:Object):void {
			var index:int = this.length
			this.addItem(value)
			_keyToIndexHash[key]=index
		}		
		
		[Bindable("collectionChange")]		
		public function get(key:Object):Object {
			var indexOrNull:* = _keyToIndexHash[key]
			if (indexOrNull == undefined) {
				trace('no value for key [' + key + ']')
				return null
			}
			var index:int = indexOrNull as int
			return super.getItemAt(index)
		}
	}
}