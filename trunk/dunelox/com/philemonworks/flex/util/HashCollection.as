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
		private var _keyToIndexHash:Object = new Object();
		
		[Bindable("collectionChange")]
		public function put(key:Object,value:Object):void {
			var indexOrNull:* = _keyToIndexHash[key]
			if (indexOrNull == undefined) {
				var index:int = this.length
				this.addItem(value)
				_keyToIndexHash[key]=index
			} else {
				this.setItemAt(value,indexOrNull as int)
			}
		}			
		[Bindable("collectionChange")]
		public function get(key:Object):Object {
			var indexOrNull:* = _keyToIndexHash[key]
			if (indexOrNull == undefined) {
				trace('no value for key [' + key + '] returning null')
				return null
			}
			var index:int = indexOrNull as int
			return super.getItemAt(index)
		}
		/**
		 * Convenience method to access a String value
		 */
		[Bindable("collectionChange")]
		public function getString(key:String):String {
			var value:Object = this.get(key)
			return value == null ? null : value as String
		}
	}
}