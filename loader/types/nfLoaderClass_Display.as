package nextFramework.loader.types
{
	import flash.display.AVM1Movie;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import nextFramework.loader.ILoaderClass;
	import nextFramework.loader.nfLoader;
	import nextFramework.loader.nfLoaderObject_Abstract;
	import nextFramework.utils.nfObject;
	
	/**
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.09
	 */
	 
	public class nfLoaderClass_Display extends nfLoaderObject_Abstract implements ILoaderClass
	{
		function nfLoaderClass_Display() { }
		
		static public function init():void {
			nfLoader.registLoaderClass('DisplayObject', nfLoaderClass_Display);
		}
		
		public function load():void
		{
			var loader:Loader = new Loader();
			var urlrequest:URLRequest = new URLRequest(this.loaderNode.url.toString());
			
			this.setHandler(loader.contentLoaderInfo);
			loader.load(urlrequest);
		}
		
		override protected function eventCompleteHandler(event:Event):void 
		{
			if ( LoaderInfo(event.currentTarget).content is AVM1Movie) {
				this.loaderNode.object = LoaderInfo(event.currentTarget).loader;
			}else{
				this.loaderNode.object = LoaderInfo(event.currentTarget).content;
			}
			
			nfObject.setProps(this.loaderNode.object, this.loaderNode.conf.prop);
			
			super.eventCompleteHandler(event);
		}		
	}

}