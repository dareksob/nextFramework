package nextFramework 
{
	import flash.display.DisplayObject;
	import flash.events.ErrorEvent;
	import nextFramework.debug.ILog;
	import nextFramework.loader.nfLoader;
	import nextFramework.loader.nfLoaderEvent;
	import nextFramework.loader.nfRessources;
	/**
	 * ...
	 * @author Darius Sobczak
	 */
	public class nfStartup 
	{
		private var _debug:Boolean = true;
		private var _root:DisplayObject;
		private var _conf:Object;
		private var _xml:XML;
		
		public function nfStartup(root:DisplayObject, conf:Object, init:Function = null, debug:Boolean = false) {
			this._debug = debug;
			this._root = root;
			this._conf = conf == null ? { } : conf;
			
			this._conf.init = init;
			
			this.initNextFramework();
			
		}
		
		private function initNextFramework():void {
			
			var registry:nfRegistry = nfRegistry.instance;

			//add logger
			if (this._debug && this._conf.log is ILog) {
				registry.log = this._conf.log;
			}
			
			this.addLog("init nextFramework");

			registry.initClasses(this._conf.initClasses);	
			registry.setRoot(this._root);
			
			//load xml
			if (this._conf.loadXML is String) {
				nfLoader.instance.load("Text", this._conf.loadXML, 
				{ 
					onComplete: this.onXMLLoadedComplete, 
					onError: this.errorHandler
				} 
				);
			}else {
				this.initRessources();
			}
		}
		

		private function initRessources():void {
			this.addLog("init Ressources");
			
			var ressources:nfRessources = new nfRessources(
				this._root.loaderInfo.applicationDomain, 
				this.onRessourceReady
			);
			nfRegistry.instance.add("ressources", ressources);
			
			
			var file:String;
			
			//load ressources by conf
			if (this._conf.ressources is Array) {
				for each(file in this._conf.ressources) {
					this.addLog("add Ressource: " + file);
					ressources.loadRessource(file);
				}
			}
			
			//load ressources by xml
			if(this._xml){
				if (this._xml.ressources.ressource) {
					for each(var ressource:XML in this._xml.ressources.ressource) {
						file = ressource.toString();
						if (file) {
							ressources.loadRessource(file);
							this.addLog("add Ressource: " + file);
						}
					}
				}
			}
			
			ressources.startLoading();
		}
		
		/**
		 * xml loaded
		 */
		private function onXMLLoadedComplete(node:nfLoaderEvent):void {
			this.addLog("xml loaded");
			try{
				this._xml = XML(node.object);
				nfRegistry.instance.add("configXML", this._xml);
				
			}catch (error:Error) {
				this.errorHandler(new ErrorEvent(error.name, false, false, error.message));
				return;
			}
			this.initRessources();
		}
		
		/**
		 * ressources loaded
		 */
		private function onRessourceReady(res:nfRessources):void {
			this.addLog("ressources loaded");
			if (this._conf.init is Function) {
				nfRegistry.instance.initFunc(this._conf.init);
			}
		}
		
		/**
		 * error event handler
		 * @param	event
		 */
		private function errorHandler(event:ErrorEvent):void {
			nfRegistry.addLog(event.text, event.currentTarget);
		}
		
		/**
		 * add log text
		 * @param	text
		 */
		private function addLog(text:String):void {
			if(this._debug){
				nfRegistry.addLog(text, this);
			}			
		}
	}

}