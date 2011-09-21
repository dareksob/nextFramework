package nextFramework.component 
{
	import nextFramework.nfProperties;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.04 beta
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
		private var _componentObjectList:Vector.<nfComponentObject> = new Vector.<nfComponentObject>();
		
		public function get componentObjectList():Vector.<nfComponentObject> { 
			return this._componentObjectList; 
		}
		
		/*
		 * default methodes
		 */
		public function addComponent(comp:Class, conf:Object = null):int {
			var index:int = -1;
			if(this.hasComponent(comp)) return index; //fixing
			
			var compobj:* = new comp(this, this._object);
						
			if(compobj is nfComponentObject){
				nfProperties.setObjectProperties(compobj, conf);
				index = this._componentObjectList.push(compobj as nfComponentObject);
				compobj.init(conf);
				compobj.added();
			}
			return index;
		}
		
		public function removeComponent(comp:Class):void {
			var nList:Vector.<nfComponentObject> = new Vector.<nfComponentObject>();
			for each(var node:nfComponentObject in this.componentObjectList) {
				if (!(node is comp)) {
					nList.push(node);
				}else {
					node.removed();
				}
			}
			this._componentObjectList = nList;
		}
		
		public function hasComponent(comp:Class):Boolean {
			for each(var node:nfComponentObject in this.componentObjectList) {
				if (node is comp) {
					return true;
				}
			}
			return false;
		}
		
		public function getComponent(comp:Class):* {
			for each(var node:nfComponentObject in this.componentObjectList) {
				if (node is comp) {
					return node;
				}
			}
			return null;
		}
		
		public function getComponentByName(name:String):* {
			for each(var node:nfComponentObject in this.componentObjectList) {
				if (node.name == name) {
					return node;
				}
			}
			return null;
		}
		
		public function get length():uint { 
			return this.componentObjectList.length; 
		}
		
	}

}