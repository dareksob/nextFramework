package nextFramework.collection 
{
	import nextFramework.event.nfEachParam;
	
	/**
	 * list collection by key and value, optional can be unique and lockable objects
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.07
	 * @since 1.0
	 */
	 
	public class nfKeyValueCollection
	{
		function nfKeyValueCollection(unique:Boolean = false) {
			this._unique = unique;
		}
		
		/**
		 * unique
		 */
		private var _unique:Boolean = false;
		public function get unique():Boolean { 
			return this._unique; 
		}
		
		/**
		 * collection
		 */
		private var _collection:Vector.<IKeyValueNode> = new Vector.<IKeyValueNode>();
		public function get collection():Vector.<IKeyValueNode> { 
			return this._collection; 
		}
		
		/**
		 * return the length
		 */
		public function get length():int { 
			return this.collection.length; 
		}
		
		/**
		 * loop function add parameter with object details, index, node, length
		 * @param	func
		 * @return	nfKeyValueCollection
		 */
		public function each(func:Function):nfKeyValueCollection {
			var count:int = this._collection.length;
			if (count > 0) {
				for (var index:int = 0; index < count; index++) {
					if(func(new nfEachParam(this._collection[index], index, count))) {
						break;
					}
				}
			}
			return this;
		}
		
		/**
		 * return nfEachParam by key
		 * @param	key
		 * @return
		 */
		public function getNodeDetailsByKey(key:Object):nfEachParam {
			var nodeDetails:nfEachParam;
			this.each(function(data:nfEachParam):Boolean {
				if (data.object.key == key) {
					nodeDetails = data;
					return true;
				}
				return false;
			});
			return nodeDetails;
		}
		
		/**
		 * return IKeyValueNode by key
		 * @param	key
		 * @param	detail
		 * @return	IKeyValueNode
		 */
		public function getNodeByKey(key:Object, remove:Boolean = false):IKeyValueNode {
			var nodeDetails:nfEachParam = this.getNodeDetailsByKey(key);
			
			//optional remove
			if (nodeDetails) {
				if(remove){
					this.removeByIndex(nodeDetails.index);
				}
				return nodeDetails.object as IKeyValueNode;
			}
			return null;
		}
		
		/**
		 * get IKeyValueNode by key and remove it from collection
		 * @param	key
		 * @return	IKeyValueNode
		 */
		public function getAndRemoveByKey(key:Object):IKeyValueNode {
			return this.getNodeByKey(key, true);
		}
		
		/**
		 * return IKeyValueNode by index
		 * @param	index
		 * @return	IKeyValueNode
		 */
		public function getNodeAt(index:uint):IKeyValueNode {
			if (this._collection.length > index) {
				return this.collection[index];
			}
			return null;
		}
		
		/**
		 * has IKeyValueNode by key
		 * @param	index
		 * @return	IKeyValueNode
		 */
		public function hasKey(key:Object):Boolean {
			return this.getNodeDetailsByKey(key) is nfEachParam;
		}
		
		/**
		 * add a new keynode object
		 * @param	node
		 * @return	nfKeyValueCollection
		 */
		public function add(node:IKeyValueNode):nfKeyValueCollection {
			if (this.unique) {
				if (this.hasKey(node.key)) {
					return this;
				}
			}
			this.collection.push(node);
			return this;
		}
		
		
		/**
		 * remove by keyvalue node
		 * @param	node
		 * @return	nfKeyValueCollection
		 */
		public function remove(node:IKeyValueNode):nfKeyValueCollection {
			var nodeDetails:nfEachParam;
			this.each(function(each:nfEachParam):Boolean {
				if (each.object == node) {
					nodeDetails = each;
					return true;
				}
				return false;
			});
			
			if(nodeDetails){
				this.removeByIndex(nodeDetails.index);
			}
			return this;
		}
		
		/**
		 * remove node by key
		 * @param	key
		 * @return	nfKeyValueCollection
		 */
		public function removeByKey(key:Object):nfKeyValueCollection {
			var nodeDetails:nfEachParam = this.getNodeDetailsByKey(key);
			if(nodeDetails){
				this.removeByIndex(nodeDetails.index);
			}
			return this;
		}
		
		
		/**
		 * remove by index
		 * @param	index
		 * @return	nfKeyValueCollection
		 */
		public function removeByIndex(index:int):nfKeyValueCollection {
			if (this._collection.length > index) {
				var node:IKeyValueNode = this._collection[index];
				if (node is ILockable && (node as ILockable).isLocked) {
					return this;
				}
				this._collection.splice(index, 1);
			}
			return this;
		}
		
		/**
		 * remove by index
		 * @param	index
		 * @return
		 */
		public function removeByIndices(array:Array):nfKeyValueCollection {
			
			for each(var index:int in array) {
				this.removeByIndex(index);
			}
			return this;
		}
		
		/**
		 * clear all collection nodes, ignor Looked elements
		 * @return
		 */
		public function clear():nfKeyValueCollection {
			this._collection = new Vector.<IKeyValueNode>();
			return this;
		}
	}

}