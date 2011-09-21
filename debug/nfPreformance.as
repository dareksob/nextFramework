package nextFramework.debug 
{
	import flash.utils.getTimer;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.0 beta
	 */
	 
	public class nfPreformance extends nfTest
	{
		
		public function nfPreformance(name:String = "", loops:int = 1000) 
		{
			super(name);
			this.setLoops(loops);
		}
		
		public function setName(name:String):nfPreformance {
			this.name = name;
			return this;
		}
		
		public var loops:int = 0;
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
		
		
		private var starttime:int = 0;
		private var endtime:int = 0;
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
		
		public function loopFunction(func:Function, args:Object = null):nfPreformance {
			for (var count:int = 0; count < this.loops; count++) {
				func.call(null, args);
			}
			return this;
		}
		public function loopFunctionTest(func:Function):nfPreformance {
			this.stop().start();
			for (var count:int = 0; count < this.loops; count++) {
				func.call(null);
			}
			this.stop().print();
			return this;
		}
		
		public function print():nfPreformance {
			trace(this.toString());
			return this;
		}
		public function toString():String {
			return '[nfPreformance] name:' + this.name + ' time:' + this.getTime() + _selectedTimeformat + ' by ' + this.loops + ' loops';
		}
	}

}