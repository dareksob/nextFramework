package nextFramework.component 
{	
	import nextFramework.utils.nfObject;

	/**
	 * container and connector for components
	 * 
	 * @author 	Darius Sobczak
	 * @website dsobczak.de
	 * @mail 	mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.07
	 */
	 
	public class nfComponentObjectContainer
	{
		private var _object:*;
		public function get object():*{
			return this._object;
		}
		
		public function nfComponentObjectContainer(object:*) {
			this._object = object;
		}
		
		/*
		 * componentObjectList
		 */
		private var _componentObjects:Vector.<IComponentObject> = new Vector.<IComponentObject>();
		
		public function get componentObjects():Vector.<IComponentObject> { 
			return this._componentObjects; 
		}
		
		/*
		 * default methodes
		 */
		public function addComponent(comp:Class, conf:Object = null):int {
			var index:int = -1;
			if(this.hasComponent(comp)) return index; //fixing
			
			var compobj:* = new comp(this, this._object);
						
			if(compobj is IComponentObject){
				nfObject.setProps(compobj, conf);
				index = this._componentObjects.push(compobj as IComponentObject);
				compobj.init(conf);
				compobj.added();
			}
			return index;
		}
		
		public function removeComponent(comp:Class):void {
			var nList:Vector.<IComponentObject> = new Vector.<IComponentObject>();
			for each(var node:IComponentObject in this.componentObjects) {
				if (!(node is comp)) {
					nList.push(node);
				}else {
					node.removed();
				}
			}
			this._componentObjects = nList;
		}
		
		public function hasComponent(comp:Class):Boolean {
			for each(var node:IComponentObject in this.componentObjects) {
				if (node is comp) {
					return true;
				}
			}
			return false;
		}
		
		public function getComponent(comp:Class):IComponentObject {
			for each(var node:IComponentObject in this.componentObjects) {
				if (node is comp) {
					return node;
				}
			}
			return null;
		}
		
		public function getComponentByName(name:String):IComponentObject {
			for each(var node:IComponentObject in this.componentObjects) {
				if (node.name == name) {
					return node;
				}
			}
			return null;
		}
		
		public function get length():uint { 
			return this.componentObjects.length; 
		}
		
	}

}