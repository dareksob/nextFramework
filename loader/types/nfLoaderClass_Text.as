package nextFramework.loader.types
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import nextFramework.loader.ILoaderClass;
	import nextFramework.loader.nfLoader;
	import nextFramework.loader.nfLoaderObject_Abstract;
	
	/**
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.09
	 */
	 
	public class nfLoaderClass_Text extends nfLoaderObject_Abstract implements ILoaderClass
	{
		function nfLoaderClass_Text() { }
		
		static public function init():void {
			nfLoader.registLoaderClass('Text', nfLoaderClass_Text);
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
			this.loaderNode.object = event.target.data;
			super.eventCompleteHandler(event);
		}
		
	}

}