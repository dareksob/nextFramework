﻿package nextFramework.loader 
{
	import nextFramework.IExtension;
	import nextFramework.nF;
	import nextFramework.loader.types.*;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.05 beta
	 */
	 
	public class nfLoader
	{
		//singelton
		static private var _canCreate:Boolean = false;
		static private var _instance:nfLoader = null;
		
		function nfLoader(conf:Object = null) {
			if (!_canCreate) {
				throw new Error('nfLoader is a singelton class use the instance property');
			}
			
			nfLoaderClass_Display.init();
			nfLoaderClass_Text.init();
			nfLoaderClass_TextField.init();
			nfLoaderClass_Binary.init();
			nfLoaderClass_XMLLoaderList.init();
			
			this.reset();
		}
		
		static public function get instance():nfLoader {
			if (_instance == null) {
				nfLoader._canCreate = true;
				nfLoader._instance = new nfLoader;
				nfLoader._canCreate = false;
			}
			return nfLoader._instance;
		}
		
		/*
		 * loader methode
		 */
		public function load(type:String, url:Object, conf:Object = null):ILoaderClass {
			var loaderNode:nfLoaderNode = nfLoaderNode.create(type, url, conf);
			var loaderClass:ILoaderClass = nfLoader._loaderClassCollection.getLoaderClassByType(type);
			
			if (loaderClass) {
				var addNode:Boolean = true;
				
				if (this.checkDublicate && loaderNode.name != '') {
					if (this.getLoader({name: loaderNode.name, url: loaderNode.url})) {
						nF.addLog('Dublicate loader, Name:' + loaderNode.name + ' URL:' + loaderNode.url, this);
						addNode = false;
					}
				}
				
				if(addNode){
					//add to loaderlist
					if (loaderNode.name) {
						
						this.loaderList.push(loaderNode);
					}

					//save loader and start loading
					loaderClass.loaderNode = loaderNode;
					loaderClass.load();
					return loaderClass;
				}
			}
			return null;
		}

		public function loadList(list:Array):Boolean {
			var completeAdded:Boolean = true;
			for each(var node:Object in list) {
				if (!this.load(node.type, node.url, node.conf)) {
					completeAdded = false;
				}
			}
			return completeAdded;
		}
		
		/*
		 * checkDublicate
		 */
		private var _checkDublicate:Boolean = true;
		public function get checkDublicate():Boolean { 
			return this._checkDublicate; 
		}
		public function set checkDublicate(value:Boolean):void {
			this._checkDublicate = value; 
		}
		
		/*
		 * loaderlist
		 */
		private var _loaderList:Vector.<nfLoaderNode>;
		public function get loaderList():Vector.<nfLoaderNode> { 
			return this._loaderList; 
		}
		public function reset():nfLoader {
			this._loaderList = new Vector.<nfLoaderNode>();
			return this;
		}
		
		// @addedsince: 1.05b
		public function getLoaderIndex(conf:Object):int {
			if (!(conf is Array)) {
				conf = new Array(conf);
			}

			for each(var param:Object in conf) {
				for (var index:int = 0; index < this._loaderList.length; index++) {
					var node:nfLoaderNode = this._loaderList[index];
					
					if (node.name == param['name']) {
						return index;
					}else if (node.url == param['url']) {
						return index;
					}
				}
			}
			return -1;
		}
		public function getLoader(conf:Object):nfLoaderNode {
			var index:int = this.getLoaderIndex(conf);
			if (index > -1) {
				return this._loaderList[index];
			}
			return null;
		}
		
		// @addedsince: 1.04b
		public function getLoaderByName(name:String):nfLoaderNode {
			return this.getLoader( { name: name } );
		}
		
		// @addedsince: 1.04b
		public function getLoaderByUrl(url:String):nfLoaderNode {
			return this.getLoader( { url: url } );
		}
		
		// @addedsince: 1.05b
		public function removeLoader(conf:Object):Boolean {

			var index:int = this.getLoaderIndex(conf);
			if (index > -1) {
				this._loaderList = this._loaderList.splice(index, 1);
				return true
			}
			return false;
		}
		// @addedsince: 1.04b
		public function removeLoaderByName(name:String):Boolean {
			return this.removeLoader( { name: name } );
		}
		
		// @addedsince: 1.04b
		public function removeLoaderByUrl(url:String):Boolean  {
			return this.removeLoader( { url: url } );
		}
		
		
		/*
			loader Class Collection
		*/
		static private var _loaderClassCollection:nfLoaderClassCollection = new nfLoaderClassCollection;
				
		static public function registLoaderClass(type:String, loaderClass:Class, priority:int = 0):void {
			nfLoader._loaderClassCollection.registLoaderClass(type, loaderClass, priority);
		}
	}

}