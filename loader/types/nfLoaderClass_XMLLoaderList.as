package nextFramework.loader.types
{
	import nextFramework.collection.nfKeyValueCollection;
	import nextFramework.event.nfLoaderError;
	import nextFramework.event.nfLoaderEvent;
	import nextFramework.loader.*;
	import flash.net.*;
	import flash.events.*;
	import flash.display.*;
	import nextFramework.nfRegistry;
	import nextFramework.nfProperties;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.5 beta
	 */
	 
	public class nfLoaderClass_XMLLoaderList extends nfLoaderObject_Abstract implements ILoaderClass
	{
		private var _loadList:XMLList;
		private var _currentIndex:int = 0;
		private var _nodes:Vector.<nfLoaderNode>;
		
		function nfLoaderClass_XMLLoaderList() { }
		
		static public function init():void {
			nfLoader.registLoaderClass('XMLLoaderList', nfLoaderClass_XMLLoaderList);
		}
		
		public function load():void
		{
			var loader:URLLoader = new URLLoader();
			var urlrequest:URLRequest = new URLRequest(this.loaderNode.url.toString());

			this.setHandler(loader);
			loader.load(urlrequest);
		}
		
		override protected function eventCompleteHandler(event:Event):void 
		{
			var data:XML = new XML(event.target.data);

			if (data is XML) {
				if (data.load is XMLList) {
					this._nodes = new Vector.<nfLoaderNode>();
					this._loadList = data.load;
					this.loadNextNode();
				}else {
					nfRegistry.addLog('list not exist', this);
				}
			}else {
				super.eventErrorHandler(new nfLoaderError(nfLoaderError.ERROR_WRONGTYPE, false, false));
			}
			//super.eventCompleteHandler(event);
		}

		private function loadNextNode():void {
			if (this._loadList[_currentIndex] is XML) {
				var element:XML = this._loadList[_currentIndex];

				var conf:Object = { onComplete: this.eventNodeCompleteHandler, onError: this.eventErrorHandler };
				
				if (element.name) {
					conf.name = element.name.toString();
				}
				if (element.data) {
					conf.data = element.data;
				}

				nfLoader.instance.load(element.type, element.url, conf);
				this._currentIndex++;
			}else {
				//complete
				
				this.loaderNode.object = this.getNodes();
				super.eventCompleteHandler(new Event(Event.COMPLETE));
			}

		}
		private function getNodes():Array {
			var list:Array = new Array();
			for each(var node:nfLoaderNode in this._nodes) {
					list.push(node.object);
			}
			return list;
		}
		private function eventNodeCompleteHandler(node:nfLoaderEvent):void {
			this._nodes.push(node.loaderNode);
			this.loadNextNode();
		}
	}

}