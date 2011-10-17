package nextFramework.input 
{
	import flash.display.Stage;
	import flash.errors.IllegalOperationError;
	import flash.events.KeyboardEvent;
	import nextFramework.nfRegistry;
	
	/**
	 * input class for keyboard control
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.08
	 */
	 
	public class nfKeyboard
	{
		/**
		 * keyMapping
		 */
		private var _keyMapping:nfKeyMapping;
		public function get keyMapping():nfKeyMapping { 
			return this._keyMapping; 
		}
		
		/**
		 * activate
		 */
		private var _activate:Boolean = true;
		public function get activate():Boolean { 
			return this._activate; 
		}
		public function set activate(value:Boolean) {
			this._activate = value; 
		}
		public function isActivate():Boolean {
			return this._activate;
		}
		
		/**
		 * @return if a key is pressed
		 */
		private var _keyDown:Boolean = false;
		public function isKeyDown():Boolean {
			return this._keyDown;
		}
		
		/**
		 * @return the last charcode
		 */
		private var _charCode:uint = 0;
		public function charCode():uint {
			return this._charCode;
		}
		
		private var _pressedKeyCodes:Array = new Array;
		public function pressedKeyCodes():Array {
			return this._pressedKeyCodes;
		}

		//return the keycode of pressed
		private var _keyCode:uint = 0;
		public function keyCode():uint {
			return this._keyCode;
		}
		
		//return the keycode of pressed
		private var _keyLocation:uint = 0;
		public function keyLocation():uint {
			return this._keyLocation;
		}
		
		//ctrl status
		private var _ctrlKey:Boolean = false;
		public function ctrlKey():Boolean {
			return this._ctrlKey;
		}
		
		//shift status
		private var _shiftKey:Boolean = false;
		public function shiftKey():Boolean {
			return this._shiftKey;
		}
		
		//alt status
		private var _altKey:Boolean = false;
		public function altKey():Boolean {
			return this._altKey;
		}
		
		/**
		 * event key down
		 * @param	event
		 */
		protected function eventKeyDown(event:KeyboardEvent):void 
		{
			if (this.isActivate()) {
				this.updateKeyProperties(true, event);
				var keycode:String = nfKeyboardKeyCodeCreator.createByEvent(KeyboardEvent.KEY_DOWN, event, this._pressedKeyCodes);
				this.keyMapping.callKeyMap(keycode, event);
			}
		}
		/**
		 * event key up
		 * @param	event
		 */
		protected function eventKeyUp(event:KeyboardEvent):void 
		{
			if (this.isActivate()) {
				var releasedKeyCodes:Array = this.updateKeyProperties(false, event);
				var keycode:String = nfKeyboardKeyCodeCreator.createByEvent(KeyboardEvent.KEY_UP, event, releasedKeyCodes);
				this.keyMapping.callKeyMap(keycode, event);
			}
		}
		
		/**
		 * update function by state
		 * @param	keydown
		 * @param	event
		 * @return	Array, return removedKeyCodes
		 */
		private function updateKeyProperties(keydown:Boolean, event:KeyboardEvent):Array {
			this._keyDown = keydown;
			this._charCode = event.charCode;
			this._ctrlKey = event.ctrlKey;
			this._keyCode = event.keyCode;
			this._keyLocation = event.keyLocation;
			this._shiftKey = event.shiftKey;
			this._altKey = event.altKey;
			
			var index:int = this._pressedKeyCodes.indexOf(event.keyCode);
			var releasedKeyCodes:Array = [];
			
			if (this._keyDown) {
				if (index == -1) {
					this._pressedKeyCodes.push(event.keyCode);
				}
			}else if(index > -1) {
				releasedKeyCodes = this._pressedKeyCodes.splice(index, 1);
			}
			this._pressedKeyCodes.sort();
			return releasedKeyCodes;
		}
		
		
		/**
		 * singelton constructor
		 */
		public function nfKeyboard() {
			if(!nfKeyboard._canCreate){
				throw new IllegalOperationError('nfKeyboard is a singelton class.');
			}
			this._keyMapping = new nfKeyMapping(this);
		}
		
		static private var _instance:nfKeyboard = null;
		static private var _canCreate:Boolean = false;
		static public function get instance():nfKeyboard
		{
			if (nfKeyboard._instance == null) {
				nfKeyboard._canCreate = true;
				nfKeyboard._instance = new nfKeyboard();
				nfKeyboard._canCreate = false;
			}
			
			return nfKeyboard._instance;
		}
		
		/**
		 * init nfKeyboard class for catching events
		 * !important call this method if the Registry has the stage
		 */
		static public function init():void {
			var stage:Stage = nfRegistry.instance.stage;
			
			if (stage) {
				var _this:nfKeyboard = nfKeyboard.instance;
				stage.addEventListener(KeyboardEvent.KEY_DOWN, _this.eventKeyDown, false, 0, true);
				stage.addEventListener(KeyboardEvent.KEY_UP, _this.eventKeyUp, false, 0, true);
			}else {
				nfRegistry.addLog('stage is undefined', nfKeyboard);
			}
		}
		
	}

}