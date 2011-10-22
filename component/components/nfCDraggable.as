package nextFramework.component.components 
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import nextFramework.component.nfComponentObject;
	import nextFramework.component.nfComponentObjectContainer;
	import nextFramework.nF;
	import nextFramework.nfProperties;
	
	/**
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.04 beta
	 */
	 
	public class nfCDraggable extends nfComponentObject
	{
		public function nfCDraggable(container:nfComponentObjectContainer, object:Object, name:String = "") 
		{
			super(container, object, name);
		}
		
		override public function added():void 
		{
			if (this.object is DisplayObject) {
				if(this.object.stage){
					this.addedToStage(null);
				}else {
					this.object.addEventListener('addedToStage', this.addedToStage);
				}
			}
		}
		override public function removed():void 
		{
			if (this.object is DisplayObject) {
				this.removeHandler(this.object as DisplayObject);
			}
		}
		
		private function addedToStage(event:*) {
			this.addHandler(this.object as DisplayObject);
		}
		private function addHandler(object:DisplayObject):void {
			if (object.stage is Stage) {
				object.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.eventMouseMove, false, 0, true);
				object.stage.addEventListener(MouseEvent.MOUSE_UP, this.eventMouseUp, false, 0, true);
				object.addEventListener(MouseEvent.MOUSE_DOWN, this.eventMouseDown);
			}
		}
		private function removeHandler(object:DisplayObject):void {
			if(object.stage is Stage){
				object.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.eventMouseMove, false);
				object.stage.removeEventListener(MouseEvent.MOUSE_UP, this.eventMouseUp);
				object.removeEventListener(MouseEvent.MOUSE_DOWN, this.eventMouseDown);
			}
		}		

		/*
		 * 	events
		 */
		private function eventMouseDown(event:MouseEvent):void {
			if (this.object is Sprite) {
				(this.object as Sprite).startDrag();
			}

			this.setAutoIndex();
			this.mouseDown = true;
		}
		private function eventMouseUp(event:MouseEvent):void {
			if (this.object is Sprite) {
				(this.object as Sprite).stopDrag();
			}
			this.mouseDown = false;
		}
		
		private function eventMouseMove(event:MouseEvent):void {
			if (this.mouseDown) {

				if (this.object is DisplayObject) {
						nF.create(this.object).prop( { x: event.stageX, y: event.stageY } );
				}
				if (this.onDrag is Function) {
					this.onDrag(this);
				}
			}
		}
		
		
		/*
		 *  properties
		 */
		
		 
		// property mouseDown
		private var _mouseDown:Boolean = false;
		protected function get mouseDown():Boolean { 
			return this._mouseDown; 
		}
		protected function set mouseDown(value:Boolean):void {
			this._mouseDown = value; 
		}
		
		 // property childControl
		private var _childControl:* = null;
		public function get childControl():* { 
			return this._childControl; 
		}
		public function set childControl(value:*):void {
			this._childControl = value; 
		}
		public function getChildControl():Sprite {
			if (this.childControl is Sprite) {
				return this.childControl as Sprite;
			}else if (this.childControl != null) {
				return nF.create(this.object).getChilds(this.childControl).getSelectionAt('first') as Sprite;
			}
			return null;
		}
		
		 // property autoIndex
		private var _autoIndex:Boolean = false;
		public function get autoIndex():Boolean { 
			return this._autoIndex; 
		}
		public function set autoIndex(value:Boolean):void {
			this._autoIndex = value; 
		}
		
		private function setAutoIndex():void {
			if (!this.autoIndex) return;
			
			nfProperties.setObjectProperties(this.object, { index: 'top' } );
			/*if (this.object is DisplayObject) {
				var displayobject:DisplayObject = this.object as DisplayObject;
				if (displayobject.parent is DisplayObjectContainer) {
					displayobject.parent.setChildIndex(displayobject, displayobject.parent.numChildren -1);
				}
			}*/
		}
		
		/*
		 * property
		 */
		private var _onDrag:Function = null;
		public function get onDrag():Function { 
			return this._onDrag; 
		}
		public function set onDrag(value:Function):void {
			this._onDrag = value; 
		}
		
		
		
	}

}