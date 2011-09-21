package nextFramework.animation
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.0 beta
	 */
	 
	internal class nfAnimationDelay implements IAnimationObject
	{
		
		function nfAnimationDelay(node:nfAnimationNode) {
			this._node = node;
		}
	
		private var _node:nfAnimationNode;
		public function get node():nfAnimationNode {
			return this._node;
		}
		
		public function getTime():Number {
			var time:Number = this.node.delay;
			if (this.node.useSeconds) {
				time = this.node.delay * 1000;
			}
			return nfAnimationValue.getValue(time);
		}
		
		private var _isStarted:Boolean = false;	
		public function get isStarted():Boolean {
			return this._isStarted;
		}
		
		private var _startOnComplete:Function;	
		
		public function start(onComplete:Function = null):IAnimationObject {
			if (!this.isStarted) {
				this._isStarted = true;
				
				var timer:Timer = new Timer(this.getTime());
				timer.addEventListener(TimerEvent.TIMER, this.eventTimerComplete);
				timer.start();
				
				this._startOnComplete = onComplete;
			}
			return this;
		}

		public function eventTimerComplete(event:TimerEvent):void {
			if (this._startOnComplete is Function) {
				this._startOnComplete(this);
			}
		}
		
	}

}