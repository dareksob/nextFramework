package nextFramework.component.components 
{
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import nextFramework.component.nfComponentObject;
	import nextFramework.component.nfComponentObjectContainer;
	
	/**
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.04 beta
	 */
	 
	public class nfCClipStopper extends nfComponentObject
	{
		
		public function nfCClipStopper(container:nfComponentObjectContainer, object:Object, name:String = "") 
		{
			super(container, object, name);
		}
		
		override public function added():void 
		{
			if (!(this.object is MovieClip)) {
				throw new Error('Component nfCClipStopper supported only MovieClip elements');
			}else {
				_timer = new Timer(0, 0);
				_timer.addEventListener(TimerEvent.TIMER, this.playClip);
				_timer.stop();
			}
		}
		private var _timer:Timer;
		public function stopByTime(time:Number):void {
			if (_timer.running) {
				_timer.reset();
			}
			_timer.delay = time * 1000;
			_timer.start();
			this.object.stop();
		}
		public function play():void {
			this.playClip(null);
		}
		public function clear():void {
			if (_timer.running) {
				_timer.stop();
			}
		}
		private function playClip(event:TimerEvent):void {
			if (_timer.running) {
				_timer.stop();
			}
			this.object.play();
		}
		public function get isStoppedByTime():Boolean {
			return _timer.running;
		}
	}

}