package nextFramework.loader 
{
	import flash.display.LoaderInfo;
	import flash.events.*;
	import nextFramework.event.nfLoaderEvent;
	import nextFramework.loader.nfLoaderNode;
	
	/*
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
		}
		protected function eventProgressHandler(event:ProgressEvent):void {
			if (this.loaderNode.conf.onProcess is Function) {
				this.loaderNode.conf.onProcess(event);
			}
		}

	}

}