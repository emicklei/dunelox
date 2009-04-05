/*
       Copyright 2007 Ernest Micklei, PhilemonWorks.com

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
package com.philemonworks.flex.util
{
	/**
	 * DisplayItem can be used to display a Record without having its whole state ; it is a reference.
	 * Such display objects can be used in Lists, ComboBoxes and Labels.
	 * 
	 * @author Ernest.Micklei
	 */
	[RemoteClass(alias="com.philemonworks.flex.util.DisplayItem")] 
	public class DisplayItem
	{
		public var id:int;
		public var object_class:String;
		public var display:String;
		
		public function DisplayItem(data:XML = null) {
			super()
			if (data != null) {
				this.id = int(data.id)
				this.object_class = data['object-class']
				this.display = data.display
			}
		}
		
		public function toString():String { return display }
		
		public function toXML():XML {
			return <display-item>
				<id>{id}</id>
				<object-class>{object_class}</object-class>	
				<display>{display}</display>
			</display-item>
		}		
	}
}