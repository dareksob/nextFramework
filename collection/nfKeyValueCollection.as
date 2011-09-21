package nextFramework.collection 
{
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.06
	 */
	 
	public final class nfKeyValueCollection
	{
		function nfKeyValueCollection(unique:Boolean = false) {
			this.unique = unique;
		}
		
		/*
		 * unique
		 */
		private var _unique:Boolean = false;
		public function get unique():Boolean { 
			return this._unique; 
		}
		public function set unique(value:Boolean):void {
			this._unique = value; 
		}
		
		/*
		 * collection
		 */
		private var _collection:Vector.<nfKeyValueNode> = new Vector.<nfKeyValueNode>();
		public function get collection():Vector.<nfKeyValueNode> { 
			return this._collection; 
		}
		
		/*
		 * length
		 */
		public function get length():int { 
			return this.collection.length; 
		}
		
		//get
		public function getNodeByKey(key:Object):nfKeyValueNode {
			for each(var kvnode:nfKeyValueNode in this.collection) {
				if (kvnode.key == key) {
					return kvnode;
				}
			}
			return null;
		}
		public function getNodeAt(index:uint):nfKeyValueNode {
			if (this.collection.length < index) {
				return this.collection[index];
			}
			return null;
		}
		
		//has
		public function hasKey(key:Object):Boolean {
			for each(var kvnode:nfKeyValueNode in this.collection) {
				if (kvnode.key == key) {
					return true;
				}
			}
			return false;
		}
		
		//adding
		public function add(node:nfKeyValueNode):nfKeyValueCollection {
			if (this.unique) {
				if (this.hasKey(node.key)) {
					return this;
				}
			}
			this.collection.push(node);
			return this;
		}
		public function addByValue(key:Object, value:*):nfKeyValueCollection {
			if (this.unique) {
				if (this.hasKey(key)) {
					return this;
				}
			}
			this._collection.push(new nfKeyValueNode(key,value));
			return this;
		}
		
		//removing
		public function remove(node:nfKeyValueNode):nfKeyValueCollection {
			var nCollection:Vector.<nfKeyValueNode> = new Vector.<nfKeyValueNode>();
			for each(var kvnode:nfKeyValueNode in this.collection) {
				if (kvnode != node) {
					nCollection.push(kvnode);
				}
			}
			this._collection = nCollection;
			return this;
		}
		
		public function removeByKey(key:Object):nfKeyValueCollection {
			var nCollection:Vector.<nfKeyValueNode> = new Vector.<nfKeyValueNode>();
			for each(var kvnode:nfKeyValueNode in this.collection) {
				if (kvnode.key != key) {
					nCollection.push(kvnode);
				}
			}
			this._collection = nCollection;
			return this;
		}
		
		public function removeByValue(value:*):nfKeyValueCollection {
			var nCollection:Vector.<nfKeyValueNode> = new Vector.<nfKeyValueNode>();
			for each(var kvnode:nfKeyValueNode in this.collection) {
				if (kvnode.value != value) {
					nCollection.push(kvnode);
				}
			}
			this._collection = nCollection;
			return this;
		}
		
		public function getAndRemoveByKey(key:Object):nfKeyValueNode {
			var keyNode:nfKeyValueNode;
			var nCollection:Vector.<nfKeyValueNode> = new Vector.<nfKeyValueNode>();
			for each(var kvnode:nfKeyValueNode in this.collection) {
				if (kvnode.key != key) {
					nCollection.push(kvnode);
				}else {
					keyNode = kvnode;
				}
			}
			this._collection = nCollection;
			return keyNode;
		}
		
		public function each(func:Function):nfKeyValueCollection {
			if (func is Function) {
				var length:uint = this.collection.length;
				for (var i:int = 0; i < length; i++) {
					var keyNode:nfKeyValueNode = this.collection[i];
					func(keyNode, i, length);
				}
			}
			return this;
		}
		
		public function removeByIndex(index:Object):Array {
			
			//multi removeable
			if (!(index is Array)) {
				index = new Array(int(index));
			}
			
			var keyNode:nfKeyValueNode;
			var removedList:Array = new Array;
			var nCollection:Vector.<nfKeyValueNode> = new Vector.<nfKeyValueNode>();
			var removeIt:Boolean = false;
			var node:nfKeyValueNode = null;
			
			for (var i:int = 0; i < this._collection.length; i++) {
				removeIt = false;
				node = this._collection[i];
				
				for each(var removeIndex:int in index) {
					if (i == removeIndex) {
						removeIt = true;
						removedList.push(node);
						break;
					}
				}
				if(!removeIt){
					nCollection.push(node);
				}
			}
			this._collection = nCollection;
			return removedList;
		}
		
		public function clear():nfKeyValueCollection {
			this._collection = new Vector.<nfKeyValueNode>();
			return this;
		}
	}

}