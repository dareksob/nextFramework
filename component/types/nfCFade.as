package nextFramework.component.types 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import nextFramework.animation.nfAnimation;
	import nextFramework.component.nfComponentObject;
	import nextFramework.component.nfComponentObjectContainer;
	import nextFramework.nF;
	import nextFramework.utils.nfObject;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.01 beta
	 */
	 
	public final class nfCFade extends nfComponentObject
	{
		
		public function nfCFade(container:nfComponentObjectContainer, object:Object, name:String = "") 
		{
			super(container, object, name);
			if (!nfAnimation.isInit) {
				trace('the Component nfCFade need the nfAnimation extention');
			}
		}
		
		override public function added():void 
		{
			if (this.object is DisplayObject) {
				this.addHandlerToDisplayObject(this.object as DisplayObject);
				if (this.object.parent is DisplayObjectContainer) {
					this.eventAddedToStage(null);
				}
			} 
		}
		override public function removed():void 
		{
			if (this.object is DisplayObject) {
				this.removeHandlerToDisplayObject(this.object as DisplayObject);
			}
		}
		
		
		//methode for DisplayObject
		private function addHandlerToDisplayObject(object:DisplayObject):void {
			object.addEventListener(Event.ADDED_TO_STAGE, this.eventAddedToStage);
			object.addEventListener(Event.REMOVED_FROM_STAGE, this.eventRemovedFromStage);
		}
		private function removeHandlerToDisplayObject(object:DisplayObject):void {
			object.removeEventListener(Event.ADDED_TO_STAGE, this.eventAddedToStage);
			object.removeEventListener(Event.REMOVED_FROM_STAGE, this.eventRemovedFromStage);
		}
		
		private function eventAddedToStage(event:Event) {
			if (nfAnimation.isInit) {
				if (this.mode == 'in' || this.mode == 'both') {
					nF.create(this.object).prop(this.startIn).ani(this.endIn);
				}
			}
		}
		
		private function eventRemovedFromStage(event:Event) {
			if (nfAnimation.isInit) {
				if(this.mode == 'in' || this.mode == 'both'){
					nF.create(this.object).prop(this.startOut).ani(this.endOut);
				}
			}
		}
		
		/*
		 * startIn
		 */
		private var _startIn:Object = {alpha: 0};
		public function get startIn():Object { 
			return this._startIn; 
		}
		public function set startIn(value:Object) {
			this._startIn = nfObject.merge(this._startIn,value);
		}
		/*
		 * endIn
		 */
		private var _endIn:Object = {alpha: 1, time: 3};
		public function get endIn():Object { 
			return this._endIn; 
		}
		public function set endIn(value:Object) {
			this._endIn = nfObject.merge(this._endIn, value);
		}
		
		/*
		 * startOut
		 */
		private var _startOut:Object = {};
		public function get startOut():Object { 
			return this._startOut; 
		}
		public function set startOut(value:Object) {
			this._startOut = nfObject.merge(this._startOut,value);
		}
		/*
		 * endIn
		 */
		private var _endOut:Object = {alpha: 0, time: 5};
		public function get endOut():Object { 
			return this._endOut; 
		}
		public function set endOut(value:Object) {
			this._endOut = nfObject.merge(this._endOut, value);
		}
		
		
		
		/*
		 * mode
		 */
		private var _mode:String = 'both';
		public function get mode():String { 
			return this._mode; 
		}
		public function set mode(value:String) {
			switch(value) {
				case 'in': this._mode = value; break;
				case 'out': this._mode = value; break;
				case 'both': this._mode = value; break;
			}
		}
	}

}