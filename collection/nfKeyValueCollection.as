package nextFramework.collection 
{
	
	/**
	 * list collection by key and value, optional can be unique and lockable objects
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.07
	 */
	 
	public class nfKeyValueCollection
	{
		function nfKeyValueCollection(unique:Boolean = false) {
			this._unique = unique;
		}
		
		/*
		 * unique
		 */
		private var _unique:Boolean = false;
		public function get unique():Boolean { 
			return this._unique; 
		}
		
		/*
		 * collection
		 */
		private var _collection:Vector.<IKeyValueNode> = new Vector.<IKeyValueNode>();
		public function get collection():Vector.<IKeyValueNode> { 
			return this._collection; 
		}
		
		/*
		 * length
		 */
		public function get length():int { 
			return this.collection.length; 
		}
		
		//get
		public function getNodeByKey(key:Object):IKeyValueNode {
			for each(var kvnode:IKeyValueNode in this.collection) {
				if (kvnode.key == key) {
					return kvnode;
				}
			}
			return null;
		}
		public function getNodeAt(index:uint):IKeyValueNode {
			if (this.collection.length < index) {
				return this.collection[index];
			}
			return null;
		}
		
		//has
		public function hasKey(key:Object):Boolean {
			for each(var kvnode:IKeyValueNode in this.collection) {
				if (kvnode.key == key) {
					return true;
				}
			}
			return false;
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
		
		
		//removing
		public function remove(node:IKeyValueNode):nfKeyValueCollection {
			var nCollection:Vector.<IKeyValueNode> = new Vector.<IKeyValueNode>();
			
			for each(var kvnode:IKeyValueNode in this.collection) {
				if (kvnode != node) {
					nCollection.push(kvnode);
				}else {
					if (kvnode is ILockable && (kvnode as ILockable).isLocked) {
						nCollection.push(kvnode);
					}
				}
			}
			this._collection = nCollection;
			return this;
		}
		
		public function removeByKey(key:Object):nfKeyValueCollection {
			var nCollection:Vector.<IKeyValueNode> = new Vector.<IKeyValueNode>();
			for each(var kvnode:IKeyValueNode in this.collection) {
				if (kvnode.key != key) {
					nCollection.push(kvnode);
				}else {
					if (kvnode is ILockable && (kvnode as ILockable).isLocked) {
						nCollection.push(kvnode);
					}
				}
			}
			this._collection = nCollection;
			return this;
		}
		
		public function removeByValue(value:*):nfKeyValueCollection {
			var nCollection:Vector.<IKeyValueNode> = new Vector.<IKeyValueNode>();
			for each(var kvnode:IKeyValueNode in this.collection) {
				if (kvnode.value != value) {
					nCollection.push(kvnode);
				}else {
					if (kvnode is ILockable && (kvnode as ILockable).isLocked) {
						nCollection.push(kvnode);
					}
				}
			}
			this._collection = nCollection;
			return this;
		}
		
		public function getAndRemoveByKey(key:Object):IKeyValueNode {
			var keyNode:IKeyValueNode;
			var nCollection:Vector.<IKeyValueNode> = new Vector.<IKeyValueNode>();
			for each(var kvnode:IKeyValueNode in this.collection) {
				if (kvnode.key != key) {
					nCollection.push(kvnode);
				}else {
					keyNode = kvnode;
					
					if (kvnode is ILockable && (kvnode as ILockable).isLocked) {
						nCollection.push(kvnode);
					}
				}
			}
			this._collection = nCollection;
			return keyNode;
		}
		
		public function each(func:Function):nfKeyValueCollection {
			if (func is Function) {
				var length:uint = this.collection.length;
				for (var i:int = 0; i < length; i++) {
					var keyNode:IKeyValueNode = this.collection[i];
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
			
			var keyNode:IKeyValueNode;
			var removedList:Array = new Array;
			var nCollection:Vector.<IKeyValueNode> = new Vector.<IKeyValueNode>();
			var removeIt:Boolean = false;
			var kvnode:IKeyValueNode = null;
			var canRemove:Boolean = true;
			
			for (var i:int = 0; i < this._collection.length; i++) {
				removeIt = false;
				kvnode = this._collection[i];
				canRemove = true;
				
				if(kvnode is ILockable && (kvnode as ILockable).isLocked) {
					canRemove = false;
				}
				
				//check list and add to remove list if it the right
				if(canRemove){
					for each(var removeIndex:int in index) {
						if (i == removeIndex) {
							removeIt = true;
							removedList.push(kvnode);
							break;
						}
					}
				}
				
				if(!removeIt){
					nCollection.push(kvnode);
				}
			}
			this._collection = nCollection;
			return removedList;
		}
		
		public function clear():nfKeyValueCollection {
			this._collection = new Vector.<IKeyValueNode>();
			return this;
		}
	}

}