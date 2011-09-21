package nextFramework.input 
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import nextFramework.nF;
	import nextFramework.nfRegisty;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.06
	 */
	 
	public class nfKeyboard
	{
		static public const KEY_DOWN:String = KeyboardEvent.KEY_DOWN;
		static public const KEY_UP:String = KeyboardEvent.KEY_UP;
		
		static public function getKeyCode(value:*):String {
			if (value is String) {
				
				//!!!!!!
			}
			return value.toString();
		}
		
		/*
		 * keyMapping
		 */
		private var _keyMapping:nfKeyMapping = new nfKeyMapping();
		public function get keyMapping():nfKeyMapping { 
			return this._keyMapping; 
		}
		
		/*
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
		
		//return if a key is pressed
		private var _keyDown:Boolean = false;
		public function isKeyDown():Boolean {
			return this._keyDown;
		}
		
		//return the keycode of pressed
		private var _charCode:uint = 0;
		public function charCode():uint {
			return this._charCode;
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
		
		//events
		protected function eventKeyDown(event:KeyboardEvent):void 
		{
			if (this.isActivate()) {
				this._keyDown = true;
				this._charCode = event.charCode;
				this._ctrlKey = event.ctrlKey;
				this._keyCode = event.keyCode;
				this._keyLocation = event.keyLocation;
				this._shiftKey = event.shiftKey;
				this._altKey = event.altKey;
				
				this.keyMapping.callAllKeyMaps(nfKeyMapping.getKeyCodeByEvent(event, nfKeyboard.KEY_DOWN + ' ' + this._charCode));
				this.keyMapping.callAllKeyMaps(nfKeyMapping.getKeyCodeByEvent(event, nfKeyboard.KEY_DOWN));
			}
		}
		protected function eventKeyUp(event:KeyboardEvent):void 
		{
			if (this.isActivate()) {
				this._keyDown = false;
				this.keyMapping.callAllKeyMaps(nfKeyMapping.getKeyCodeByEvent(event, nfKeyboard.KEY_UP + ' ' + this._charCode));
				this.keyMapping.callAllKeyMaps(nfKeyMapping.getKeyCodeByEvent(event, nfKeyboard.KEY_UP));
			}
		}
		
		
		//constuct
		public function nfKeyboard() 
		{
			if(!nfKeyboard._canCreate){
				throw new Error('nfKeyboard is a singelton class.');
			}
		}
		
		//singelton
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
		
		//init
		static public function init():void {
			var stage:Stage = nfRegisty.instance.stage;
			
			if (stage) {
				var _this:nfKeyboard = nfKeyboard.instance;
				stage.addEventListener(KeyboardEvent.KEY_DOWN, _this.eventKeyDown, false, 0, true);
				stage.addEventListener(KeyboardEvent.KEY_UP, _this.eventKeyUp, false, 0, true);
			}else {
				nF.addLog('stage is undefined', nfKeyboard);
			}
		}
		
	}

}