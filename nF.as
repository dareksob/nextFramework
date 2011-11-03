package nextFramework
{
	import flash.display.DisplayObject;
	import nextFramework.component.nfComponent;
	import nextFramework.debug.ILog;
	import nextFramework.event.nfEachParam;
	import nextFramework.flash.nfFlashFilter;
	import nextFramework.flash.nfFlashObject;
	import nextFramework.loader.nfLoader;
	import nextFramework.loader.nfLoaderNode;
	import nextFramework.transform.nfAlign;
	import nextFramework.transform.nfArrange;
	import nextFramework.transform.nfTableArrange;
	import nextFramework.utils.nfObject;
	
	/**
	 * Base Class for mulitselection and multiformation of your objects
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.06
	 */
	 
	public dynamic class nF
	{
		
		/**
		 * set selection properies
		 */
		public function prop(conf:Object = null):nF {
			nfProperties.setListProperties(this.selection, conf);
			return this;
		}
		
		/**
		 * call a function of the selection objects
		 * warning low preformce
		 * 
		 * @param	name
		 * @param	...args
		 * @return	nF
		 */
		public function func(name:String, ...args):nF {
			this.each(function(node:Object):void {
				nfObject.func(node, name, args);
			});
			return this;
		}
		
		/**
		 * call a function of the selection objects
		 * 
		 * @param	script
		 * @return	nF
		 */
		public function condition(script:String):nF {
			var cond:nfCondition = new nfCondition;
			this._selection = cond.filter(this._selection, script);
			return this;
		}
		
		/**
		 * loop all nodes
		 * 
		 * @param	func
		 * @param	detail
		 * @return
		 */
		public function each(func:Function, detail:Boolean = false):nF {
			for (var index:int = 0; index < this.selection.length; index++) {
				var node:Object = this.selection[index];
				if(detail){
					func(new nfEachParam(node, index, this.selection.length));
				}else {
					func(node);
				}
			}
			return this;
		}
		
		/**
		 * create loader object
		 * 
		 * @param	type
		 * @param	url
		 * @param	conf
		 * @return	nF
		 */
		public function load(type:String, url:String, conf:Object = null):nF {
			//auto setting
			if (!conf) conf = { selection: this._selection, root: this._root };
			else conf.selection = this._selection; conf.root = this._root;
			
			if (!nfLoader.instance.load(type, url, conf)) {
				nfRegistry.addLog('nF.load, unknown loader type:' + type, this);
			}
			return this;
		}
		
		/**
		 * create multi Loader by array
		 * 
		 * @param	list
		 * @return	nF
		 */
		public function loadList(list:Array):nF {
			if (!nfLoader.instance.loadList(list)) {
				nfRegistry.addLog('nF.loadList, not all load could be started', this);
			}
			return this;
		}
		
		/**
		 * return a loadernode by url, name see nfLoader
		 * 
		 * @param	conf
		 * @return nfLoaderNode
		 */
		public function getLoader(conf:Object):nfLoaderNode {
			return nfLoader.instance.getLoader(conf);
		}
		

		/**
		 * add child to the selection (if class), beta
		 * 
		 * @param	object
		 * @param	conf
		 * @param	filter
		 * @return
		 */
		public function addChild(object:Object, conf:Object = null, filter:Object = null):nF {
			var selection:Vector.<Object> = new Vector.<Object>();
			if (conf is Object && conf.rootOnly == true) {
				selection.push(this.root);
			}else {
				selection = this.copy().filter(filter).selection;
			}
			
			var fobj:nfFlashObject = nfFlashObject.create()
				.addChild(
					selection,
					object,
					conf
				);
			this.setSelection(fobj.objects);
			return this;
		}
		
		/**
		 * remove childs of the root by query
		 * 
		 * @param	filter
		 * @param	conf
		 * @return
		 */
		public function removeChild(filter:Object = null, conf:Object = null):nF {
			nfFlashObject.create().removeChild(
				nF.create(this.root).setSelection(this.selection).filter(filter).selection, 
				conf
			);
			return this;
		}
		
		
		/**
		 * add events to selection
		 * 
		 * @param	func
		 * @param	detail
		 * @return	nF
		 */
		public function addEvent(eventname:String, func:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):nF {
			nfFlashObject.create().addEvent(this.selection, eventname, func, useCapture, priority, useWeakReference);
			return this;
		}
		
		/**
		 * remove events to selection
		 * 
		 * @param	func
		 * @param	detail
		 * @return	nF
		 */
		public function removeEvent(eventname:String, func:Function, useCapture:Boolean = false):nF {
			nfFlashObject.create().removeEvent(this.selection, eventname, func, useCapture);
			return this;
		}
		
		
		/**
		 * add Bitmapfilter
		 * 
		 * @param	func
		 * @param	detail
		 * @return	nF
		 */
		public function addFilter(filter:Object, conf:Object = null):nF {
			nfFlashFilter.create().addFilter(this.selection, filter, conf);
			return this;
		}
		
		/**
		 * remove Bitmapfilter
		 * 
		 * @param	func
		 * @param	detail
		 * @return	nF
		 */
		public function removeFilter(filter:Object):nF {
			nfFlashFilter.create().removeFilter(this.selection, filter);
			return this;
		}
		
		/**
		 * change property of Bitmapfilter, if the object have filter
		 * 
		 * @param	func
		 * @param	detail
		 * @return	nF
		 */
		public function changeFilter(filter:Object, conf:Object):nF {
			nfFlashFilter.create().changeFilter(this.selection, filter, conf);
			return this;
		}
		
		
		/*
		 * align the objects to a object, x and y or both
		 */
		public function align(aligntoobject:Object, conf:Object = null):nF {
			var align:nfAlign = new nfAlign(aligntoobject, conf);
				align.alignList(this.selection);
			return this;
		}
		
		/*
		 * order selection by axis or table, see nfArrange
		 */
		public function arrange(conf:Object = null):nF {
			if (conf && conf.mode == 'table') {
				(new nfTableArrange(conf)).positionObjects(this._selection);
			}else{
				nfArrange(new nfArrange(conf)).positionObjects(this._selection);
			}
			return this;
		}
		
		
		/*
		 * selection methodes
		 */
		public function getChilds(conf:Object = null):nF {
			var selector:nfSelection = new nfSelection();
			this.selection = selector.getChilds(this.root, conf);
			return this;
		}
		
		/*
		 * filter the selection
		 */
		public function filter(conf:Object):nF {
			var selector:nfSelection = new nfSelection();
			this.selection = selector.filter(this.selection, conf);
			return this;
		}
		
		/*
		 * filter the selection inverted
		 */
		public function not(conf:Object):nF {
			var selector:nfSelection = new nfSelection();
			this.selection = selector.not(this.selection, conf);
			return this;
		}
		
		/*
		 * sort methode
		 */
		public function sort(prop:String, order:String = 'up'):nF {
			var sorter:nfSort = new nfSort;
			this.selection = sorter.sort(this.selection, prop, order);
			return this;
		}
		
		
		/*
		 * clear all elements what don't have the property
		 * /
		public function hasProp(property:String):nF {
			this._selection = nfProperties.getListByProperty(this._selection, property);
			return this;
		}
		
		/*
		 *  clear the selection
		 */
		public function clear():nF {
			this.selection = new Vector.<Object>();
			return this;
		}
		
		/*
		 * set the selectiion. Optional clear all current selection
		 */
		public function setSelection(value:Object, clear:Boolean = false):nF {
			if (clear) this.clear();
			
			if(value is Vector.<Object> || value is Array){
				for each(var node:Object in value) {
					this.selection.push(node);
				}
			}else if(value is Object) {
				this.selection.push(value);
			}
			return this;
		}
		
		
		/*
		 * property root, main object and child holder, like DisplayObjectContainer
		 */
		private var _root:Object = null;
		public function get root():Object { 
			return this._root;
		}
		public function set root(value:Object):void { 
			this._root = value;
		}
		
		/*
		 * set new root
		 */
		public function setRoot(value:Object, select:Boolean = false, clear:Boolean = false):nF {
			this.root = value;
			if (clear) this.clear();
			if (select) this.setSelection(this.root);
			return this;
		}
		public function selectRoot():nF {
			return this.setRoot(this._root, true, true);			
		}
		
		/*
		 * selection property
		 */
		private var _selection:Vector.<Object> = new Vector.<Object>();
		public function get selection():Vector.<Object> { 
			return this._selection; 
		}
		public function set selection(list:Vector.<Object>):void { 
			this._selection = list;
		}
		
		public function get length():int {
			return this._selection.length;
		}

		
		
		/*
		 * return the object at index. You could user commandkey 'first' or 'last'
		 */
		public function getSelectionAt(index:*):Object {
			if (index is uint) {
				if (this.selection.length > index) {
					return this.selection[index];
				}
			}else if (index is String) {
				if (this.selection.length > 0) {
					switch(index) {
						case 'first': return this.selection[0]; break;
						case 'last' : return this.selection[this.selection.length-1]; break;
					}
				}
			}
			return null;
		}
		
		/*
		 * Constructor
		 */
		public function nF(root:Object = null, select:Boolean = false) {
			this.setRoot(root, select);
		}
		
		//return a nF object and set the root, optional select the root
		static public function create(root:Object = null, select:Boolean = false):nF {
			return new nF(root, select);
		}
		
		//main init function, start it only one time!
		static public function init(root:DisplayObject, conf:Object = null):nF {		
			//fixed init components system
			nfComponent.init();
			
			//init registy, classes, and function
			nfRegistry.instance
				.initClasses(conf && conf.initClasses ? conf.initClasses : null)
				.initFunc(conf && conf.initFunc ? conf.initFunc : null)
				.setRoot(root);
			
			//logger
			if (conf.log is ILog) {
				nfRegistry.instance.log = conf.log;
			}
			
			//create nf set properties and return it
			var _this:nF = nF.create();
			nfProperties.setObjectProperties(_this, conf);
			return _this;
		}
		
		//copy the nF object
		public function copy():nF {
			var nf:nF = new nF(this.root);
			nf.setSelection(this.selection);
			return nf;
		}
		
		/*
		 * static methode to regist extentions/plugins for nf
		 */
		static public function extend(name:String, methode:Function):void {
			if (nF.prototype[name] is Function) {
				throw new Error('nf.extend the methode ' + name + ' allways exists');
			}
			nF.prototype[name] = methode;
		}
	}
}

