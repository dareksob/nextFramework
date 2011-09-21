package nextFramework.loader.types
{
	import nextFramework.loader.*;
	import flash.net.*;
	import flash.events.*;
	import flash.display.*;
	import nextFramework.nF;
	import nextFramework.nfProperties;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.04 beta
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
			
			
				
			if (this.loaderNode.conf.addTo) {
				nF.create(this.loaderNode.conf.addTo, true).addChild(this.loaderNode.object, this.loaderNode.conf.prop);
			}else if (this.loaderNode.conf.prop) {
				nfProperties.setObjectProperties(this.loaderNode.object, this.loaderNode.conf.prop);
			}
			
			super.eventCompleteHandler(event);
		}		
	}

}