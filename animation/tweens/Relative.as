package nextFramework.animation.tweens 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import nextFramework.animation.nfTweenEvents;
	import nextFramework.utils.nfObject;
	/**
	 * ...
	 * @author Darius Sobczak
	 */
	
	public class Relative implements ITween, IEasingTween
	{
		protected var _target:Object;
		protected var _easing:Function;
		protected var _property:String;
		
		protected var _start:Number 	= Number.NaN;
		protected var _end:Number 		= 0;
		protected var _time:Number		= 0;
		protected var _duration:Number 	= 0;
		
		private var _events:EventDispatcher;
		
		public function Relative(conf:Object) {
			this._events = new EventDispatcher();
			
			nfObject.setProps(this, conf);
			
			if (isNaN(_start)) {
				this._start = this.target[this._property];
			}
			
			if (conf.onComplete is Function) {
				this.addEventListener(nfTweenEvents.EVENT_COMPLETE, conf.onComplete);
			}
		}
		
		/**
		 * event
		 * @param	type
		 * @param	func
		 */
		public function addEventListener(type:String, func:Function):void {
			this._events.addEventListener(type, func);
		}
		
		/**
		 * update methode to set object tweens
		 * 
		 * @param	prop
		 * @param	time
		 * @return	Boolean, return false if the tween is finished;
		 */
		public function update(time:Number):Boolean {
			this._time += time;
			
			this.updateProperty();
			
			if (this._time >= this._duration) {
				this._events.dispatchEvent(new Event(nfTweenEvents.EVENT_COMPLETE));

				//remove tween on stack
				return true; 
			}
			return false;
		}
		
		protected function updateProperty():void {
			this._target[this._property] = this._easing(this._time, this._start, this._end, this._duration);
		}
		
		/** target */
		public function get target():Object {
			return this._target;
		}
		public function set target(value:Object):void {
			this._target = value;
		}
		
		/** easing */
		public function set easing(value:Function):void {
			this._easing = value;
		}
		
		/** duration */
		public function get duration():Number {
			return this._duration;
		}
		public function set duration(value:Number):void {
			this._duration = value;
		}
		
		/** time */
		public function get time():Number {
			return this._time;
		}
		public function set time(value:Number):void {
			this._time = value;
		}
		
		/** start */
		public function get start():Number {
			return this._start;
		}
		public function set start(value:Number):void {
			this._start = value;
		}
		
		/** end */
		public function get end():Number {
			return this._end;
		}
		public function set end(value:Number):void {
			this._end = value;
		}
		
		/**
		 * property name
		 */
		public function set property(value:String):void {
			this._property = value;
		}
		
	}

}