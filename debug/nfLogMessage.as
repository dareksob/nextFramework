package nextFramework.debug 
{
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.0 beta
	 */
	 
	internal class nfLogMessage
	{
		
		public function nfLogMessage(message:*, caller:* = null) 
		{
			this.caller = caller;
			this.message = message;
		}
		
		/*
		 * message
		 */
		private var _message:*;
		public function get message():* { 
			return this._message; 
		}
		public function set message(value:*):void {
			this._message = value; 
		}
		
		/*
		 * message
		 */
		private var _caller:*;
		public function get caller():* { 
			return this._caller; 
		}
		public function set caller(value:*):void {
			this._caller = value; 
		}
		
		public function toString():String {
			return this.message + ' called by ' + this.caller;
		}
		
	}

}