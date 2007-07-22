package com.philemonworks.flex.controls
{
	import mx.controls.TextInput;
	import com.philemonworks.flex.util.Time;

	public class TimeField extends TextInput
	{
		public var _time:Time;
		
		public function TimeField() {
			super()
		}
		
		public function set time(newTime:Time):void {
			this.text = newTime.toString()
		}
	}
}