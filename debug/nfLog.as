package nextFramework.debug 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import nextFramework.debug.ILog;
	
	/**
	 * default logger class for nextframework
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.07
	 */
	 
	public class nfLog implements ILog
	{
		private var _logCollection:Array = new Array;
		public var autoTrace:Boolean = true;
		
		/**
		 * add a log to the list
		 * @param	message, normaly a string
		 * @param	caller, a class who call this log event
		 * @return	ILog
		 */
		public function addLog(message:*, caller:* = null):ILog { 
			this._logCollection.push(new nfLogMessage(message, caller));
			if (this.autoTrace) {
				this.traceLastLog();
			}
			return this;
		}
		
		/**
		 * return all logs
		 * @return	Array
		 */
		public function getLogs():Array {
			return this._logCollection;
		}
		
		/**
		 * return the last log entry
		 * @return
		 */
		public function get lastLog():Object {
			if (this._logCollection.length > 0) {
				return this._logCollection[this._logCollection.length-1];
			}
			return null;
		}
		
		/**
		 * clear all log enties
		 * @return	ILog
		 */
		public function clear():ILog {
			this._logCollection = new Array;
			return this;
		}
		
		
		/**
		 * return the log count
		 */
		public function get length():uint {
			return this._logCollection.length;
		}
		
		/**
		 * trace all log entries
		 * 
		 * @return	ILog
		 */
		public function traceLog():ILog {
			for each(var log:Object in this._logCollection) {
				trace(log.toString());
			}
			return this;
		}
		/**
		 * trace the last log entry
		 * @return	ILog
		 */
		public function traceLastLog():ILog {
			trace(this.lastLog);
			return this;
		}	
	}

}