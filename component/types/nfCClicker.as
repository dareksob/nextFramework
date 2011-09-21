package nextFramework.component.types 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import nextFramework.component.*;
	import nextFramework.nF;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.05 beta
	 */
	 
	public class nfCClicker extends nfComponentObject
	{
		private var _stage:Stage;
		
		public function nfCClicker(container:nfComponentObjectContainer, object:Object, name:String = "") 
		{
			super(container, object, name);
		}
		override public function added():void 
		{
			if(this.object is DisplayObject){
				if (this.object.stage) {
					this.addedToStage(null);
				}else {
					_stage.removeEventListener(Event.ADDED_TO_STAGE, this.addedToStage);
				}
			}
		}
		private function addedToStage(event:Event):void {
			_stage = this.object.stage;
			_stage.removeEventListener(Event.ADDED_TO_STAGE, this.addedToStage);
			_stage.addEventListener(MouseEvent.CLICK, this.clicked, true, 1, true);
			if (this.object.root is Sprite) {
				(this.object.root as Sprite).buttonMode = true;
			}
		}
		override public function removed():void 
		{
			if (this._stage) {
				_stage.removeEventListener(MouseEvent.CLICK, this.clicked, true);
			}
		}

		
		protected function clicked(event:MouseEvent):void {
			if (this.url.length > 0) {
				var urlRequest:URLRequest = new URLRequest(this._url);
				navigateToURL(urlRequest, this.window);
			}
			
			if (this.callJS) {
				if (ExternalInterface.available) {
					ExternalInterface.call(this.callJS, this.url);
				}
			}
		}
		
		
		/*
		 * url
		 */
		private var _url:String = '';
		public function get url():String { 
			return this._url; 
		}
		public function set url(value:String):void {
			this._url = value; 
		}
		
		/*
		 * window
		 */
		private var _window:String = '_blank';
		public function get window():String { 
			return this._window; 
		}
		public function set window(value:String):void {
			this._window = value; 
		}
		
		private var _callJS:String = '';
		public function get callJS():String { 
			return this._callJS; 
		}
		public function set callJS(value:String):void {
			this._callJS = value; 
		}
		
		
		
	}

}