package nextFramework.input 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	/**
	 * Keymapping class for combine keycodes with events
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.08
	 */
	 
	public final class nfKeyMapping
	{
		private var _owner:Object = null;
		private var _dispatcher:EventDispatcher;
		
		public function nfKeyMapping(owner:Object) {
			this._owner = owner;
			this._dispatcher = new EventDispatcher()
		}
		
		/**
		 * add KeyMap
		 * 
		 * @param	keyCode
		 * @param	call
		 * @param	overrideExists, remove the event if exists
		 * @return	nfKeyMapping
		 */
		public  function addKeyMap(keyCode:String, call:Function = null, overrideExists:Boolean = false):nfKeyMapping {
			if (overrideExists) {
				if (this._dispatcher.hasEventListener(keyCode)) {
					this._dispatcher.removeEventListener(keyCode, call);
				}
			}
			this._dispatcher.addEventListener(keyCode, call);
			return this;
		}
		
		/**
		 * remove KeyMap
		 * @param	keyvalue
		 * @param	func
		 * @return	nfKeyMapping
		 */
		public function removeKeyMap(keyCode:String, func:Function):nfKeyMapping {
			this._dispatcher.removeEventListener(keyCode, func);
			return this;
		}
		
		/**
		 * call event
		 * @param	keyCode
		 */
		internal function callKeyMap(keyCode:String, event:Event) {
			this._dispatcher.dispatchEvent(new nfKeyMappingEvent(keyCode, event));
		}
		
	}

}