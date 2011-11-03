package nextFramework 
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import nextFramework.debug.ILog;
	import nextFramework.loader.IRessource;
	import nextFramework.utils.nfList;
	
	/**
	 * Registry class for regist functions, static classes with init() and objects
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.09
	 */
	public final class nfRegistry
	{
		private var _root:DisplayObject = null;
		private var _stage:Stage = null;
		private var _initList:Vector.<Function>;
		private var _collection:Object;
		
		//singelton construction
		public function nfRegistry() 
		{
			if(!nfRegistry._canCreate){
				throw new Error('nfRegistry is a singelton class.');
			}
			this._initList = new Vector.<Function>();
			this._collection = { };
		}
		
		static private var _instance:nfRegistry = null;
		static private var _canCreate:Boolean = false;
		static public function get instance():nfRegistry
		{
			if (nfRegistry._instance == null) {
				nfRegistry._canCreate = true;
				nfRegistry._instance = new nfRegistry();
				nfRegistry._canCreate = false;
			}
			return nfRegistry._instance;
		}
		
		
		/**
		 * add new key 
		 * 
		 * @param	key
		 * @param	value
		 */
		public function add(key:String, value:*):Boolean {
			if (!this.hasKey(key)) {
				this._collection[key] = value;
				return true;
			}
			nfRegistry.addLog('This key has been set: ' + key, this);
			return false;
		}
		
		/**
		 * return a key or give else it call an exception
		 * 
		 * @param	key
		 * @param	value
		 * @return	keynode value
		 */
		public function getByKey(key:String):* {
			return this._collection[key];
		}
		
		/**
		 * condition query 
		 * 
		 * @param	key
		 * @return	Boolean
		 */
		public function hasKey(key:String):Boolean {
			return this._collection[key] != null;
		}
		
		
		/**
		 * return the root object
		 * 
		 * @return	DisplayObject
		 */
		public function get root():DisplayObject {
			return this._root;
		}
		
		/**
		 * return the Stage object
		 * 
		 * @return	Stage
		 */
		public function get stage():Stage {
			return this._stage;
		}

		/**
		 * log object
		 */
		static private var _log:ILog;
		public function get log():ILog { 
			return nfRegistry._log; 
		}
		public function set log(value:ILog):void {
			nfRegistry._log = value;
		}
		
		/**
		 * 	return a ressource object if set
		 *	if you want to set it uses a "ressources" key 
		 */
		public function get ressources():IRessource {
			if (this.hasKey("ressources")) {
				return this.getByKey("ressources") as IRessource;
			}
			return null;
		}
		public function set ressources(value:IRessource):void {
			if (!this.hasKey("ressources")) {
				this.add("ressources", value);
			}
		}
		
		/**
		 * catch the errors and messages methode, if regist a ILog class, nF Internal
		 */
		static public function addLog(message:*, caller:* = null):void {
			if (nfRegistry._log is ILog) {
				nfRegistry._log.addLog(message, caller);
			}
		}
		
		/**
		 * set root, can be only set one time
		 * 
		 * @param	value
		 * @return	nfRegistry
		 */
		public function setRoot(value:DisplayObject):nfRegistry {
			if (!this._root) {				
				this._root = value.root;
				
				if (this._root.stage) {
					this.eventAdded(null);	
				}else {
					this._root.addEventListener(Event.ADDED_TO_STAGE, eventAdded);
				}
			}
			return this;
		}
		
		/**
		 * init function for auto calling
		 * 
		 * @param	func
		 * @return	nfRegistry
		 */
		public function initFunc(func:Function):nfRegistry {
			if(func is Function){
				this._initList.push(func);
				
				//call all regist if its possible
				this.callFunctions();
			}
			return this;
		}
		
		/**
		 * regist classes for initialize, only one time calling if all elements are registred, root and stage
		 * 
		 * @param	value have to be a array with classes or a class, the class have to have a static init method
		 * @return	nfRegistry
		 */
		public function initClasses(value:Object):nfRegistry {
			if (value is Array) {
				for each(var classNode:Object in value) {
					if (classNode is  Class) {
						this.initFunc(classNode.init);
					}
				}
			}else if (value is Class) {
				this.initFunc(value.init);
			}
			return this;
		}
		
		private function eventAdded(event:Event):void {
			this._root.removeEventListener(Event.ADDED_TO_STAGE, eventAdded);
			this._stage = this._root.stage;
			this.callFunctions();
			
		}
		
		private function callFunctions():void {
			if (!this._stage) return;
			
			//savety, make backtup and remove all
			var list:Array = nfList.toArray(this._initList);
			this._initList = new Vector.<Function>();
			
			//init all functions
			for each(var func:Function in list) {
				func();
			}
			
		}
		
		
		
		
	}

}