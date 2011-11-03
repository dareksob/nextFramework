package nextFramework.loader.types 
{
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import nextFramework.loader.nfLoaderObject_Abstract;
	import nextFramework.loader.ILoaderClass;
	import nextFramework.loader.nfLoader;
	import flash.events.Event;

	/**
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.02 beta
	 * @created 11.02.2011
	 */
	public class nfLoaderClass_Binary extends nfLoaderObject_Abstract implements ILoaderClass
	{
		
		public function nfLoaderClass_Binary() { }
		
		static public function init():void {
			nfLoader.registLoaderClass('Binary', nfLoaderClass_Binary);
		}
		
		public function load():void
		{
			var loader:URLLoader = new URLLoader();
			var urlrequest:URLRequest = new URLRequest(this.loaderNode.url.toString());
			
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			this.setHandler(loader);
			loader.load(urlrequest);
		}
		
		override protected function eventCompleteHandler(event:Event):void 
		{
			this.loaderNode.object = event.currentTarget.data as ByteArray;		
			super.eventCompleteHandler(event);
		}	
	}

}