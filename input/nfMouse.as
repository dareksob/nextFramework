package nextFramework.input 
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.*;
	import nextFramework.nF;
	import nextFramework.nfRegisty;
	import nextFramework.translate.nfVector;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.06
	 */
	 
	public class nfMouse
	{
		static public const KEY_MOUSEDOWN:String = 'mouseDown';
		static public const KEY_CLICK:String = 'click';
		static public const KEY_DOUBLECLICK:String = 'doubleClick';
		static public const KEY_MOVE_MOUSEDOWN:String = 'move+mouseDown';
		static public const KEY_MOVE:String = 'move';
		static public const KEY_MOUSEOUT:String = 'out';
		static public const KEY_MOUSEOVER:String = 'over';
		
		/*
		 * mousePosition
		 */
		private var _mousePosition:nfVector = new nfVector;
		public function get mousePosition():nfVector { 
			return this._mousePosition; 
		}
		
		/*
		 * lastMousePosition
		 */
		private var _lastMousePosition:nfVector = new nfVector;
		public function get lastMousePosition():nfVector { 
			return this._lastMousePosition; 
		}
		
		/*
		 * mousePositionMouseDown
		 */
		private var _mousePositionMouseDown:nfVector = new nfVector;
		public function get mousePositionMouseDown():nfVector { 
			return this._mousePositionMouseDown; 
		}
		
		/*
		 * mousePositionMouseUp
		 */
		private var _mousePositionMouseUp:nfVector = new nfVector;
		public function get mousePositionMouseUp():nfVector { 
			return this._mousePositionMouseUp; 
		}
		
		/*
		 * mouse button pressed
		 */
		private var _isPressed:Boolean = false;
		public function get isPressed():Boolean { 
			return this._isPressed; 
		}
		
		/*
		 * mouse button left pressed
		 */
		private var _isLeftPressed:Boolean = false;
		public function get isLeftPressed():Boolean { 
			return this._isLeftPressed; 
		}
		
		/*
		 * mouse button right pressed
		 */
		private var _isRightPressed:Boolean = false;
		public function get isRightPressed():Boolean { 
			return this._isRightPressed; 
		}
		
		/*
		 * delta value
		 */
		private var _delta:uint = 0;
		public function get delta():uint { 
			return this._delta; 
		}
		
		/*
		 * is over stage
		 */
		private var _isOver:Boolean = false;
		public function isOver():Boolean { 
			return this._isOver; 
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
	
		
		/*
		 * keyMapping
		 */
		private var _keyMapping:nfKeyMapping = new nfKeyMapping();
		public function get keyMapping():nfKeyMapping { 
			return this._keyMapping; 
		}
		
		
		//events
		protected function eventMouseDown(event:MouseEvent):void 
		{
			if (this.isActivate()) {
				this._isPressed = true;
				this._isLeftPressed = event.delta == 0 ? true : false;
				this._isRightPressed = event.delta == 1 ? true : false;
				this._mousePositionMouseDown = new nfVector(event.stageX, event.stageY);
				this.keyMapping.callAllKeyMaps(nfKeyMapping.getKeyCodeByEvent(event, 'mouseDown'));
			}
		}
		protected function eventMouseClick(event:MouseEvent):void 
		{
			if (this.isActivate()) {
				this._isPressed = false;
				this._isLeftPressed = false;
				this._isRightPressed = false;
				this._mousePositionMouseUp = new nfVector(event.stageX, event.stageY);
				this.keyMapping.callAllKeyMaps(nfKeyMapping.getKeyCodeByEvent(event, 'click'));
			}
		}
		
		protected function eventMouseDoubleClick(event:MouseEvent):void 
		{
			if (this.isActivate()) {
				this._isPressed = false;
				this.keyMapping.callAllKeyMaps(nfKeyMapping.getKeyCodeByEvent(event, 'doubleClick'));
			}
		}
		
		protected function eventMouseMove(event:MouseEvent):void 
		{
			if (this.isActivate()) {
				if (!this._isOver) {
					this.keyMapping.callAllKeyMaps(nfKeyMapping.getKeyCodeByEvent(event, 'over'));
				}
				this._isOver = true;
				this._mousePosition = new nfVector(event.stageX, event.stageY);
				this._isPressed = true;
				this._delta = event.delta;

				if (event.buttonDown) {
					this.keyMapping.callAllKeyMaps(nfKeyMapping.getKeyCodeByEvent(event, 'move+mouseDown'));
				}else {
					this.keyMapping.callAllKeyMaps(nfKeyMapping.getKeyCodeByEvent(event, 'move'));
				}
			}
		}

		protected function eventMouseLeave(event:Event):void 
		{
			if(this.isActivate()){
				this._isOver = false;
				this.keyMapping.callAllKeyMaps(nfKeyMapping.getKeyCodeByEvent(event, 'out'));
			}
		}
		
		//singelton
		static private var _instance:nfMouse = null;
		static private var _canCreate:Boolean = false;
		static public function get instance():nfMouse
		{
			if (nfMouse._instance == null) {
				nfMouse._canCreate = true;
				nfMouse._instance = new nfMouse();
				nfMouse._canCreate = false;
			}
			return nfMouse._instance;
		}
		public function nfMouse() 
		{
			if(!nfMouse._canCreate){
				throw new Error('nfMouse is a singelton class.');
			}
		}
		
		
		//init
		static public function init():void {
			var stage:Stage = nfRegisty.instance.stage;
			
			if(stage){
				var _this:nfMouse = nfMouse.instance;
				stage.addEventListener(MouseEvent.MOUSE_DOWN, _this.eventMouseDown, false, 0, true);
				stage.addEventListener(MouseEvent.CLICK, _this.eventMouseClick, false, 0, true);
				stage.addEventListener(MouseEvent.DOUBLE_CLICK, _this.eventMouseDoubleClick, false, 0, true);
				stage.addEventListener(MouseEvent.MOUSE_MOVE, _this.eventMouseMove, false, 0, true);
				stage.addEventListener(Event.MOUSE_LEAVE, _this.eventMouseLeave, false, 0, true);
			}else {
				nF.addLog('stage is undefined', nfMouse);
			}
		}
		
	}

}