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
	 * Page represents a selection from a data collection.
	 * It contains that selection and information about the "window" in that collection.
	 * If the page represents a partial result of of search request then the searchPattern is available.
	 * 
	 * @author emicklei
	 */	
	public class Page
	{
		public var to:int;
		public var from:int;
		public var total:int;
		public var sortKey:String;
		public var sortMethod:String;
		public var searchPattern:String;
		public var data:XMLList;
		
		/**
		 * Page with fixed data set.
		 */
		public function Page(newData:XMLList = null) {
			super()
			if (newData != null) {
				this.data = newData
				this.from = 1
				this.total = newData.length()
				this.to = this.total
			}	
		}
		public function isEmpty():Boolean {
			return this.total == 0
		}
	}
}