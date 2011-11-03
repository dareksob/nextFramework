package nextFramework.debug 
{
	import com.demonsters.debugger.MonsterDebugger;
	
	/**
	 * Logger to use Monster Debugger
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.08
	 */
	public class nfMonsterDebuggerLog implements ILog
	{
		private var _flashTracing:Boolean = false;
		public function nfMonsterDebuggerLog(base:Object, flashTracing:Boolean = false, address:String = "127.0.0.1", onConnect:Function = null) 
		{
			MonsterDebugger.initialize(base, address, onConnect);
			this._flashTracing = flashTracing;
		}
		
		public function addLog(object:*, caller:* = null):ILog {
			MonsterDebugger.trace(caller, object.toString());
			
			if (this._flashTracing){
				var message:nfLogMessage = new nfLogMessage(object, caller);
				trace(message.toString());
			}
			return this;
		}
		
	}

}