package nextFramework.loader 
{
	import flash.events.ErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.EventDispatcher;
	import nextFramework.loader.nfLoaderNode;
	import nextFramework.nfRegistry;
	
	/**
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.0 beta
	 */
	 
	public class nfLoaderObject_Abstract
	{
		
		private var _loaderNode:nfLoaderNode;
		public function get loaderNode():nfLoaderNode {
			return this._loaderNode;
		}
		
		public function set loaderNode(value:nfLoaderNode):void {
			this._loaderNode = value;
		}
		
		
		protected function setHandler(dispatcher:EventDispatcher):void {
			dispatcher.addEventListener(Event.COMPLETE, this.eventCompleteHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, this.eventErrorHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, this.eventProgressHandler);
		}
		
		protected function eventCompleteHandler(event:Event):void {
			if (this.loaderNode.conf.onComplete is Function) {
				this.loaderNode.conf.onComplete(nfLoaderEvent.create(event.type, this.loaderNode, event.bubbles, event.cancelable));
			}
		}
		protected function eventErrorHandler(event:ErrorEvent):void {
			if (this.loaderNode.conf.onError is Function) {
				this.loaderNode.conf.onError(event);
			}
			nfRegistry.addLog(event.text, event.target);
		}
		protected function eventProgressHandler(event:ProgressEvent):void {
			if (this.loaderNode.conf.onProcess is Function) {
				this.loaderNode.conf.onProcess(event);
			}
		}

	}

}