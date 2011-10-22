package nextFramework.xml.parser 
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import nextFramework.loader.nfLoader;
	import nextFramework.loader.nfLoaderEvent;
	import nextFramework.nfRegistry;
	
	/**
	 * abstract XML Parser
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.08
	 */
	public class XMLObjectParser extends EventDispatcher implements IXmlParser
	{
		public static const EVENT_XMLLOADED:String = "xmlLoaded";
		public static const EVENT_XMLLOADINGERROR:String = "xmlLoadingError";
		public static const EVENT_PARSECOMPLETE:String = "parseComplete";
		
		protected var _xml:XML = null;
		
		/**
		 * load xml file and start to parse of ready
		 * @param	url
		 */
		public function loadXMLAndParse(url:String, onComplete:Function = null):void {
			if (onComplete is Function) {
				//optional call function after complete
				this.addEventListener(XMLObjectParser.EVENT_PARSECOMPLETE, onComplete);
			}
			nfLoader.instance.load("Text", url, { onComplete: this.xmlLoadedComplete, onError: this.xmlLoadedError } );
		}
		
		/**
		 * set xml document and start parsing
		 * @param	xml
		 */
		public function parseXML(xml:XML):void {
			this._xml = xml;
			this.dispatchEvent(new Event(XMLObjectParser.EVENT_XMLLOADED));
			this.startParse();
		}
		
		/**
		 * abstract start parse methode to override
		 */
		protected function startParse():void {
		}
		
		private function xmlLoadedComplete(node:nfLoaderEvent):void {
			this.parseXML(XML(node.object));
		}
		private function xmlLoadedError(error:ErrorEvent):void {
			nfRegistry.addLog(error.text, this);
			this.dispatchEvent(new ErrorEvent(XMLObjectParser.EVENT_XMLLOADINGERROR));
		}
	}

}