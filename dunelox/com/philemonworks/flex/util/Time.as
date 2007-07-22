package com.philemonworks.flex.util
{
	import mx.utils.StringUtil;
	import com.adobe.utils.IntUtil;
	
	[Bindable]
	public class Time
	{
		public var hours:int = 12;
		public var minutes:int = 0;
		public var seconds:int = 0;
		
		public function Time(){
			var now:Date = new Date();
			this.hours = now.hours
			this.minutes = now.minutes
			this.seconds = now.seconds
		}
		
		public static function fromSeconds(secondsValue:int):Time {
			return new Time().initializeFromSeconds(secondsValue)
		}
		public static function fromHMS(hours:int,minutes:int,seconds:int):Time {
			var now:Time = new Time()
			now.hours = hours
			now.minutes = minutes
			now.seconds = seconds
			return now		
		}
		
		public function initializeFromSeconds(secondsValue:int):Time {
			this.hours = (secondsValue / 3600) % 24
			this.minutes = (secondsValue % 3600) / 60
			this.seconds = secondsValue % 60
			return this;
		}
		
		public static function parse(input:String):Time {			
			if (input == null) return null
			var trimmed:String = StringUtil.trim(input)
			if (trimmed.length == 0) return null
			var delta_negative:Boolean = trimmed.indexOf('-') == 0
			var delta_positive:Boolean = trimmed.indexOf('+') == 0
			if (delta_negative || delta_positive) trimmed = trimmed.slice(1)
			var parts:Array = trimmed.split(':')
			var hours:int = int(parts[0])
			var minutes:int = parts.length > 1 ? int(parts[1]) : 0
			var seconds:int = parts.length > 2 ? int(parts[2]) : 0
			
			var totalSeconds:int = ((hours * 60) + minutes) * 60 + seconds
			if (delta_negative) { // relative				
				totalSeconds = new Time().toSeconds() - totalSeconds
			}
			if (delta_positive) { // relative				
				totalSeconds += new Time().toSeconds()
			}			
			return Time.fromSeconds(totalSeconds)		
		}
		
		public function validate():Time {
			return this;
		}
		
		public function add(delta:Time):void {
			this.initializeFromSeconds(this.toSeconds() + delta.toSeconds())			
		}
		
		public function toSeconds():int {
			return ((this.hours * 60) + this.minutes) * 60 + seconds
		}
		
		public function toString():String {
			return two(hours)+":"+two(minutes)+":"+two(seconds)
		}
		private function two(value:int):String {
			return value < 10 ? "0" + String(value) : String(value)
		}
	}
}