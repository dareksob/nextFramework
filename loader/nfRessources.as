package nextFramework.loader 
{
	import flash.display.DisplayObject;
	import flash.events.ErrorEvent;
	import flash.system.ApplicationDomain;
	import nextFramework.nfRegistry;
	
	/**
	 * ressouce loader object, based by ApplicationDomains 
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.09
	 */
	 
	public class nfRessources implements IRessource
	{
		public var onComplete:Function;
		private var _domains:Vector.<ApplicationDomain>;
		private var _ressourcesFiles:Array = new Array;
		
		/**
		 * create new ressouce object 
		 * @param	defaultDomain
		 * @param	onComplete
		 */
		public function nfRessources(defaultDomain:ApplicationDomain, onComplete:Function = null) {
			this._domains = new Vector.<ApplicationDomain>();
			this.addRessource(defaultDomain);
			this.onComplete = onComplete;
		}
		
		/**
		 * start the ressources process
		 */
		public function startLoading():void {
			this.loadNextRessource("");
		}

		/**
		 * add ressource (application domain)
		 * 
		 * @param	domain:ApplicationDomain
		 * @return	nfRessource;
		 */
		public function addRessource(domain:ApplicationDomain):nfRessources{
			if (domain is ApplicationDomain) {
				this._domains.push(domain);
			}
			return this;
		}
		
		/**
		 * get ressource by name
		 * 
		 * @param	name
		 * @return	* can be a class, bitmapData, types of DisplayObject
		 */
		public function getRessource(name:String):* {
			for each(var appDomain:ApplicationDomain in this._domains) {
				if (appDomain.hasDefinition(name)) {
					return appDomain.getDefinition(name);
				}
			}
			return null;
		}
		
		/**
		 * has a ressouce
		 * @param	name
		 * @return	Boolean
		 */
		public function hasRessource(name:String):Boolean {
			return this.getRessource(name) != null;
		}
		
		/**
		 * load a new file ressouce like swf
		 * 
		 * @param	swffile
		 */
		public function loadRessource(file:String):void {
			_ressourcesFiles.push(file);
			this.loadNextRessource("");
		}
		
		/**
		 * load next Ressouce if not loaded also call onComplete
		 * 
		 * @param	currendLoadedUrl
		 */
		private function loadNextRessource(currendLoadedUrl:String):void {
			for (var index:int = 0; index < this._ressourcesFiles.length; index++) {
				if (currendLoadedUrl == this._ressourcesFiles[index]) {
					this._ressourcesFiles.splice(index, 1);
					break;
				}
			}
			
			if (this._ressourcesFiles.length > 0) {
				nfLoader.instance.load("DisplayObject", this._ressourcesFiles[0], { onComplete: this.eventAddRessource, onError: this.eventErrorLoading } );
			}else {
				if (this.onComplete is Function) {
					this.onComplete(this);
				}
			}
			
		}
		
		private function eventAddRessource(event:nfLoaderEvent):void {
			var object:DisplayObject = event.object as DisplayObject;
			
			if (!object) {
				this.eventErrorLoading(new ErrorEvent("notRightObject"));
			}else {
				this.addRessource(object.loaderInfo.applicationDomain);
			}
			
			this.loadNextRessource(event.loaderNode.url);
		}
		
		private function eventErrorLoading(error:ErrorEvent):void {
			nfRegistry.addLog(error.text, this);
		}
		
	}

}