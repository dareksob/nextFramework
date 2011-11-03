package nextFramework.debug 
{
	import flash.utils.getTimer;
	
	/**
	 * Test Class for preformance testing
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.08
	 */
	 
	public class nfPreformance
	{
		private var _loops:int = 0;
		private var _name:String = "";
		private var starttime:int = 0;
		private var endtime:int = 0;
		
		public function nfPreformance(loops:int = 1000) 
		{
			this.setLoops(loops);
		
		}
		/*
		 * name
		 */
		public function get name():String { 
			return this._name; 
		}
		public function set name(value:String) {
			this._name = value; 
		}
		
		public function setName(name:String):nfPreformance {
			this.name = name;
			return this;
		}
		
		public function get loops():int { 
			return this._loops; 
		}
		public function set loops(value:int) {
			this._loops = value; 
		}
		
		public function setLoops(loops:int = 1000):nfPreformance {
			this.loops = loops;
			return this;
		}
		
		/*
		 * defaultTimeformat
		 */
		private var _defaultTimeformat:String = 'ms';
		public function get defaultTimeformat():String { 
			return this._defaultTimeformat; 
		}
		public function set defaultTimeformat(value:String):void {
			this._defaultTimeformat = value; 
		}
		public function setDefaultTimeformat(value:String):nfPreformance {
			this.defaultTimeformat = value;
			return this;
		}
		

		public function start():nfPreformance {
			this.starttime = getTimer();
			return this;
		}
		public function stop():nfPreformance {
			this.endtime = getTimer();
			return this;
		}
		
		private var _selectedTimeformat:String = 'ms';
		public function getTime(timeformat:String = ""):Number {
			var time:Number = Number(this.endtime - this.starttime);
			
			if (timeformat.length > 0) {
				_selectedTimeformat = timeformat;
			}
			
			switch(_selectedTimeformat) {
				case 's':	time /= 1000;
				case 'm':	time /= (1000 * 60);
			}
			return time;
		}
		

		public function loopFunctionTest(testName:String, func:Function, args:Object = null):nfPreformance {
			this.name = testName;
			this.stop().start();
			for (var count:int = 0; count < this._loops; count++) {
				func.call(args);
			}
			this.stop().print();
			return this;
		}
		
		public function print():nfPreformance {
			trace(this.toString());
			return this;
		}
		
		public function toString():String {
			return '[nfPreformance] name:' + this.name + ' time:' + this.getTime() + this._selectedTimeformat + ' by ' + this.loops + ' loops';
		}
	}

}