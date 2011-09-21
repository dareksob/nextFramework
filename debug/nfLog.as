package nextFramework.debug 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import nextFramework.debug.ILog;
	import nextFramework.nF;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.0 beta
	 */
	 
	public class nfLog extends EventDispatcher implements ILog
	{
		public static const EVENT_NEWLOG:String = 'newLog';
		public static const EVENT_CLEARLOG:String = 'clearLog';
		function nfLog() {
			this.clear();
		}
		
		public function autoShowByNewLog():ILog {
			if (!this.hasEventListener(EVENT_NEWLOG)) {
				this.addEventListener(nfLog.EVENT_NEWLOG, this.eventNewLog);	
			}
			return this;
		}
		private function eventNewLog(event:Event):void { 
			trace(event.target.lastLog);
		}
		
		private var _logCollection:Array;
		
		/* INTERFACE nextFramework.debug.ILog */
		
		public function addLog(message:*, caller:* = null):ILog {
			this._logCollection.push(new nfLogMessage(message, caller));
			this.dispatchEvent(new Event(EVENT_NEWLOG, false, false));
			return this;
		}
		
		public function getLogs():Array {
			return this._logCollection;
		}
		
		public function get lastLog():Object {
			if (this._logCollection.length > 0) {
				return this._logCollection[this._logCollection.length-1];
			}
			return null;
		}
		
		public function clear():ILog {
			this._logCollection = new Array;
			this.dispatchEvent(new Event(EVENT_CLEARLOG, false, false));
			return this;
		}
		
		
		
		public function get length():uint {
			return this._logCollection.length;
		}
		
		public function traceLog():ILog {
			for each(var log:Object in this._logCollection) {
				trace(log.toString());
			}
			return this;
		}
		public function traceLastLog():ILog {
			trace(this.lastLog);
			return this;
		}

		static public function defaultInit():nfLog {
			//regist logger
			var log:nfLog = new nfLog;
			log.addEventListener(
				nfLog.EVENT_NEWLOG, 
				function(e:Event) { 
					trace( e.target.lastLog) 
				} 
			);
			return log;
		}
		
		

		
	}

}