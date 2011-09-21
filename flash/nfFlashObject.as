package nextFramework.flash
{
	import flash.display.*;
	import flash.events.*;
	import nextFramework.nfProperties;
	import nextFramework.utils.nfClass;
	import nextFramework.utils.nfObject;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.0 beta
	 */
	 
	public class nfFlashObject
	{
		private var _objects:Vector.<Object>;
		public function get objects():Vector.<Object> {
			return this._objects;
		}
		private function clear():nfFlashObject {
			this._objects = new Vector.<Object>();
			return this;
		}
		
		
		public function addChild(parents:Vector.<Object>, object:Object, conf:Object = null):nfFlashObject {
			this.clear();
			
			if (conf == null) { conf = { };	}
			
			for each(var parent:Object in parents) {
				if (parent is DisplayObjectContainer) {
					
					var child:Object = null;
					if (object is Class) {
						child = new object
					}else {
						child = object;
					}
					
					if (child is DisplayObject) {
						if (conf.at is int) {
							(parent as DisplayObjectContainer).addChildAt(child as DisplayObject, conf.at as int);
						}else {
							(parent as DisplayObjectContainer).addChild(child as DisplayObject);
						}
						
						//add to list
						this._objects.push(child);
						
						//set props
						nfProperties.setObjectProperties(child, conf, ['onAdd']);
						
						//call function onAdd if set
						if (conf.onAdd is Function) {
							conf.onAdd(child);
						}
						
					}	
				}
			}
			
			return this;
		}
		
		public function removeChild(list:Vector.<Object>, conf:Object = null):nfFlashObject {
			if (conf == null) { conf = { };	}
			
			var rlist:Vector.<Object> = new Vector.<Object>();
			for each(var item:Object in list) {
				if (item is DisplayObject) {
					var itemDO:DisplayObject = (item as DisplayObject);
					
					if (itemDO.parent is DisplayObjectContainer) {
						if (conf.removeFunc is Function) {
							//passiv remove
							conf.removeFunc(item);
						}else {
							itemDO.parent.removeChild(itemDO);
							
							rlist.push(itemDO);
							if (conf.onRemoved is Function) {
								conf.onRemoved(item);
							}
						}

					}
				}	
			}
			
			if (conf.onAllRemoved is Function && (rlist.length > 0)) {
				conf.onAllRemoved(rlist);
			}
			return this;
		}
		
		public function addEvent(list:Vector.<Object>, eventname:String, func:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):nfFlashObject {
			for each(var item:Object in list) {
				if (item is EventDispatcher) {
					(item as EventDispatcher).addEventListener(eventname, func, useCapture, priority, useWeakReference);
				}	
			}
			return this;
		}
		
		public function removeEvent(list:Vector.<Object>, eventname:String, func:Function, useCapture:Boolean = false):nfFlashObject {
			for each(var item:Object in list) {
				if (item is EventDispatcher) {
					(item as EventDispatcher).removeEventListener(eventname, func, useCapture);
				}
			}
			return this;
		}
		
		public function setIndex(object:Object, index:Object):nfFlashObject {
			if (object.hasOwnProperty('parent')) {
				if (object.parent is DisplayObjectContainer) {
					var parent:DisplayObjectContainer = object.parent as DisplayObjectContainer;
					if (index is uint) {
						if (parent.numChildren > index) {
							parent.setChildIndex(object as DisplayObject, index as int);
						}
					}else if (index is String) {
						switch(index) {
							case 'top': parent.setChildIndex(object as DisplayObject, parent.numChildren-1); break;
							case 'bottom' : parent.setChildIndex(object as DisplayObject, 0); break;
						}
					}
				}
			}
			return this;
		}
		
		static public function create():nfFlashObject {
			return new nfFlashObject();
		}
		
	}

}