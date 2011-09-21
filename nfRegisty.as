package nextFramework 
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import nextFramework.utils.nfList;
	/**
	 * ...
	 * @author Darius Sobczak
	 */
	public final class nfRegisty
	{
		private var _root:DisplayObject = null;
		private var _stage:Stage = null;
		private var _initList:Vector.<Function> = new Vector.<Function>();
		
		public function initFunc(func:Function):nfRegisty {
			if(func is Function){
				this._initList.push(func);
				
				//call all regist if its possible
				this.callFunctions();
			}
			return this;
		}
		
		public function get root():DisplayObject {
			return this._root;
		}
		public function get stage():Stage {
			return this._stage;
		}
		
		internal function setRoot(value:DisplayObject):nfRegisty {
			if (!this._root) {				
				this._root = value;
				
				if (this._root.stage) {
					this.eventAdded(null);	
				}else {
					this._root.addEventListener(Event.ADDED_TO_STAGE, eventAdded);
				}
			}
			return this;
		}
		
		//regist classes for initialize
		public function initClasses(value:Object):nfRegisty {
			if (value is Array) {
				for each(var classNode:Object in value) {
					if (classNode is  Class) {
						this.initFunc(classNode.init);
					}
				}
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
		
		
		//singelton construction
		static private var _instance:nfRegisty = null;
		static private var _canCreate:Boolean = false;
		static public function get instance():nfRegisty
		{
			if (nfRegisty._instance == null) {
				nfRegisty._canCreate = true;
				nfRegisty._instance = new nfRegisty();
				nfRegisty._canCreate = false;
			}
			return nfRegisty._instance;
		}
		public function nfRegisty() 
		{
			if(!nfRegisty._canCreate){
				throw new Error('nfRegisty is a singelton class.');
			}
		}
		
	}

}