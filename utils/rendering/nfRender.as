package nextFramework.utils.rendering
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.getTimer;
	import flash.utils.Timer;

	public class nfRender
	{
		private var _timer:Timer;
		private var _lastTimer:uint = 0;
		private var _lastRenderTime:Number = 0;
		
		
		
		public function nfRender():void{
			if (!_canCreate) {
				throw new Error('nfRender is a singelton class use the instance property');
			}
			this._timer = new Timer(1, 0);
			this._lastTimer = flash.utils.getTimer();
			this._timer.addEventListener(TimerEvent.TIMER, this.update);
			this._timer.start();
		}

		static private var _instance:nfRender = null;
		static private var _canCreate:Boolean = false;
		static public function get instance():nfRender {
			if (_instance == null) {
				nfRender._canCreate = true;
				nfRender._instance = new nfRender;
				nfRender._canCreate = false;
			}
			return nfRender._instance;
		}
		
		
		/*
		 * return the last rendering time
		 */
		public function get lastRenderTime():Number {
			return this._lastRenderTime;
		}
		
		/*
		 * main render methode
		 */
		private function update(event:TimerEvent):void{
			var time:int = flash.utils.getTimer();
			var renderTime:uint = time - this._lastTimer;
			this._lastTimer = time;

			this._lastRenderTime = renderTime / 1000;

			//call registed functions
			for each(var funcNode:Function in _renderList) {
				funcNode(this._lastRenderTime);
			}
		}
		
		private var _renderList:Vector.<Function> = new Vector.<Function>();
		public function addRender(func:Function):nfRender {
			this._renderList.push(func);
			return this;
		}
		public function removeRender(func:Function):nfRender {
			var tempList:Vector.<Function> = new Vector.<Function>();
			for each(var funcNode:Function in _renderList) {
				if (funcNode != func) {
					tempList.push(func);
				}
			}
			this._renderList = tempList;
			return this;
		}
	}
}