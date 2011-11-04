package nextFramework.input 
{
	import flash.display.Stage;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import nextFramework.nfRegistry;
	import nextFramework.translate.nfPoint;
	
	/**
	 * input class for mouse control
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.09
	 */
	 
	public final class nfMouse
	{		
		/**
		 * mousePosition
		 */
		private var _mousePosition:nfPoint = new nfPoint;
		public function get mousePosition():nfPoint { 
			return this._mousePosition; 
		}
		
		/**
		 * lastMousePosition
		 */
		private var _lastMousePosition:nfPoint = new nfPoint;
		public function get lastMousePosition():nfPoint { 
			return this._lastMousePosition; 
		}
		
		/**
		 * mousePositionMouseDown
		 */
		private var _mousePositionMouseDown:nfPoint = new nfPoint;
		public function get mousePositionMouseDown():nfPoint { 
			return this._mousePositionMouseDown; 
		}
		
		/*
		 * mousePositionMouseUp
		 */
		private var _mousePositionMouseUp:nfPoint = new nfPoint;
		public function get mousePositionMouseUp():nfPoint { 
			return this._mousePositionMouseUp; 
		}
		
		/**
		 * mouse button pressed
		 */
		private var _isPressed:Boolean = false;
		public function get isPressed():Boolean { 
			return this._isPressed; 
		}
		
		/**
		 * mouse button left pressed
		 */
		private var _isLeftPressed:Boolean = false;
		public function get isLeftPressed():Boolean { 
			return this._isLeftPressed; 
		}
		
		/**
		 * mouse button right pressed
		 */
		private var _isRightPressed:Boolean = false;
		public function get isRightPressed():Boolean { 
			return this._isRightPressed; 
		}
		
		/**
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
		
		/**
		 * activate
		 */
		private var _activate:Boolean = true;
		public function get activate():Boolean { 
			return this._activate; 
		}
		public function set activate(value:Boolean):void {
			this._activate = value; 
		}
		public function isActivate():Boolean {
			return this._activate;
		}
	
		
		/**
		 * keyMapping
		 */
		private var _keyMapping:nfKeyMapping;
		public function get keyMapping():nfKeyMapping { 
			return this._keyMapping; 
		}
		
		
		/**
		 * Event Handler method for MouseDown
		 * @param	event
		 */
		private function eventMouseDown(event:MouseEvent):void 
		{
			if (this.isActivate()) {
				this._isPressed = true;
				this._isLeftPressed = event.delta == 0 ? true : false;
				this._isRightPressed = event.delta == 1 ? true : false;
				this._delta = event.delta;
				this._mousePositionMouseDown = new nfPoint(event.stageX, event.stageY);
				
				this.keyMapping.callKeyMap(nfMouseKeyCodeCreator.createByEvent(nfMouseKeyCode.EVENT_MOUSEDOWN, event), event);
			}
		}
		/**
		 * Event Handler method for MouseUp (Click)
		 * @param	event
		 */
		private function eventMouseUp(event:MouseEvent):void 
		{
			if (this.isActivate()) {
				this._isPressed = false;
				this._isLeftPressed = false;
				this._isRightPressed = false;
				this._mousePositionMouseUp = new nfPoint(event.stageX, event.stageY);
				this.keyMapping.callKeyMap(nfMouseKeyCodeCreator.createByEvent(nfMouseKeyCode.EVENT_MOUSEUP, event), event);
				this.keyMapping.callKeyMap(nfMouseKeyCodeCreator.createByEvent(nfMouseKeyCode.EVENT_CLICK, event), event);
			}
		}
		/**
		 * Event Handler method for MouseDoubleClick
		 * @param	event
		 */
		protected function eventMouseDoubleClick(event:MouseEvent):void 
		{
			if (this.isActivate()) {
				this._isPressed = false;
				this.keyMapping.callKeyMap(nfMouseKeyCodeCreator.createByEvent(nfMouseKeyCode.EVENT_DOUBLECLICK, event), event);
			}
		}
		
		/**
		 * Event Handler method for MouseMove
		 * @param	event
		 */
		protected function eventMouseMove(event:MouseEvent):void 
		{
			if (this.isActivate()) {
				
				if (!this._isOver) {
					this.keyMapping.callKeyMap(nfMouseKeyCode.EVENT_MOUSEOVER, event);
				}
				
				this._isOver = true;
				this._mousePosition = new nfPoint(event.stageX, event.stageY);
				this._delta = event.delta;

				if (event.buttonDown) {
					this.keyMapping.callKeyMap(nfMouseKeyCodeCreator.create(nfMouseKeyCode.EVENT_MOVEMOUSEDOWN, this._delta, event.shiftKey, event.altKey, event.ctrlKey), event);
				}else {
					this.keyMapping.callKeyMap(nfMouseKeyCode.EVENT_MOVE, event);
				}
			}
		}
		
		/**
		 * Event Handler method for MouseLeave
		 * @param	event
		 */
		protected function eventMouseLeave(event:Event):void {
			if(this.isActivate()){
				this._isOver = false;
				this.keyMapping.callKeyMap(nfMouseKeyCode.EVENT_MOUSEOUT, event);
			}
		}

		/**
		 * singelton constructor
		 */
		public function nfMouse() {
			if(!nfMouse._canCreate){
				throw new IllegalOperationError('nfMouse is a singelton class.');
			}
			this._keyMapping = new nfKeyMapping(this);
		}
		
		static protected var _instance:nfMouse = null;
		static protected var _canCreate:Boolean = false;
		static public function get instance():nfMouse{
			if (nfMouse._instance == null) {
				nfMouse._canCreate = true;
				nfMouse._instance = new nfMouse();
				nfMouse._canCreate = false;
			}
			return nfMouse._instance;
		}
		
		/**
		 * init all handlers
		 */
		static public function init():void {
			var stage:Stage = nfRegistry.instance.stage;
			
			if (stage) {
				var _this:nfMouse = nfMouse.instance;
				stage.addEventListener(MouseEvent.MOUSE_DOWN, _this.eventMouseDown, false, 0, true);
				stage.addEventListener(MouseEvent.MOUSE_UP, _this.eventMouseUp, false, 0, true);
				stage.addEventListener(MouseEvent.DOUBLE_CLICK, _this.eventMouseDoubleClick, false, 0, true);
				stage.addEventListener(MouseEvent.MOUSE_MOVE, _this.eventMouseMove, false, 0, true);
				stage.addEventListener(Event.MOUSE_LEAVE, _this.eventMouseLeave, false, 0, true);
			}else {
				nfRegistry.addLog('stage is undefined', nfMouse);
			}
		}
		
	}

}