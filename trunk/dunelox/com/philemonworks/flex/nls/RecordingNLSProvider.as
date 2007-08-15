/*
   Copyright [2007] Ernest.Micklei @ PhilemonWorks.com

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
package com.philemonworks.flex.nls
{
	import com.philemonworks.flex.nls.NLSProvider;

	public class RecordingNLSProvider implements NLSProvider
	{
		private var entries:XML;
		private var fallback:NLSProvider;
		[Bindable]
		public var recordNewOnly:Boolean = true;
		
		public function RecordingNLSProvider(hitmissProvider:NLSProvider = null) {
			super()
			this.fallback = hitmissProvider
			this.entries = <locale language={fallback == null ? 'us' : fallback.language} />
		}
		
		public function getString(key:String, absentValue:String):String
		{
			var localAbsentValue:String = "RecordingNLSProvider"
			var value:String = entries[key]
			if (value.length == 0) {
				if (fallback != null) {
					value = fallback.getString(key,localAbsentValue)
					if (value != localAbsentValue) {
						if (!recordNewOnly) entries[key]=value
						return value
					}
				}
				trace("[nls recorder] hit miss, recording default value for:" + key)
				var recordedValue:String = absentValue == null ? key : absentValue
				entries[key] = recordedValue
				value = recordedValue
			}
			return value				
		}
		
		public function language():String
		{
			return entries.@language;
		}
		
		public function getPropertiesContents():String {
			var buffer:String = ''
			var keys:Array = []
			for each (var entry:XML in entries.children()) {
				keys.push(entry.name())
			}
			keys.sort()
			for each (var key:String in keys) {	
				 buffer += key + "=" + entries[key] + "\n"
			}
			return buffer
		}		
	}
}