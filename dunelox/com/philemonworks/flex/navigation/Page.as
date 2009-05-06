/*
   Copyright 2008 Ernest.Micklei @ PhilemonWorks.com

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/
package com.philemonworks.flex.navigation
{
	/**
	 * Page represents a selection from a data collection (XMLList or Array).
	 * It contains that selection and information about the "window" in that collection.
	 * If the page represents a partial result of of search request then the searchPattern is available.
	 * 
	 * @author emicklei
	 */	
	[RemoteClass(alias="com.philemonworks.flex.navigation.Page")]
	public class Page
	{
		public var to:int;
		public var from:int;
		public var total:int;
		public var sortKey:String;
		public var sortMethod:String;
		public var searchPattern:String;
		public var data:XMLList;
		public var items:Array;
		
		/**
		 * Page with fixed data set.
		 */
		public function Page(newData:Object = null,fromIndex:Number = -1,toIndex:Number = -1, totalDataSize:Number = -1) {
			super()
			if (newData != null) {
				if (newData is XMLList) {
					this.data = newData as XMLList
					this.initFromXMLList(fromIndex,toIndex,totalDataSize)
				} else {
					if (newData is Array) {
						this.items = newData as Array
						this.initFromArray(fromIndex,toIndex,totalDataSize)
					} else {
						trace("XMLList or Array expected but got:" + newData.toString())
					}
				}
			}
		}
		private function initFromXMLList(fromIndex:Number = -1,toIndex:Number = -1, totalDataSize:Number = -1):void{
			this.from = fromIndex == -1 ? 1 : fromIndex
			this.total = totalDataSize == -1 ? data.length() : totalDataSize 
			this.to = toIndex == -1 ? data.length() : toIndex
		}
		private function initFromArray(fromIndex:Number = -1,toIndex:Number = -1, totalDataSize:Number = -1):void{
			this.from = fromIndex == -1 ? 1 : fromIndex
			this.total = totalDataSize == -1 ? items.length : totalDataSize 
			this.to = toIndex == -1 ? items.length : toIndex
		}
		public function isEmpty():Boolean {
			if (data != null) {
				return data.length() == 0
			} 
			if (items != null) {
				return items.length == 0
			}
			return true
		}
		public function contents():Object {
			if (data != null) 
				return data
			else
				return items
		}
	}
}