package nextFramework.utils 
{
	import nextFramework.collection.IKeyValueCollection;
	import nextFramework.collection.nfKeyValueCollection;
	import nextFramework.collection.nfKeyValueNode;
	import nextFramework.utils.rendering.nfRender;
	/**
	 * ...
	 * @author Darius Sobczak
	 */
	public final class nfCalling implements IKeyValueCollection
	{
		private var _collection:nfKeyValueCollection;
		public static const MODE_REPEAT:uint = 0x01;
		public static const MODE_END:uint = 0x02;
		
		public function addCall(func:Function, time:Number, mode:uint = nfCalling.MODE_END, key:Object = null):nfCalling {
			this._collection.add(new nfKeyValueNode(key, { time: time, func:func, mode: mode }, false));
			return this;
		}
		
		public function get collection():nfKeyValueCollection {
			return this._collection;
		}
		
		public function getCallByKey(key:Object):Object {
			var node:nfKeyValueNode = this._collection.getNodeByKey(key);
			if (node) {
				return node.value;
			}
			return null;
		}
		
		
		private function update(time:Number):void {
			
			if (this._collection.length == 0) return;
			
			var removeIndices:Array = new Array;
			
			//update all request
			for (var i:int = 0; i < this._collection.length; i++) {
				var call:Object = this._collection.collection[i].value;
				call.time -= time;

				if (call.time > 0) {					
					//mode MODE_REPEAT
					if (call.mode == nfCalling.MODE_REPEAT) {
						call.func();
					}
				}else if (call.mode == nfCalling.MODE_END) {
					removeIndices.push(i); 
					call.func();
				}
			}
			
			this._collection.removeByIndex(removeIndices);
		}
		
		
		/*
		 * singleton
		 */
		public function nfCalling(){
			if (!_canCreate) {
				throw new Error('nfCalling is a singelton class use the instance property');
			}
			this._collection = new nfKeyValueCollection(false); //no unique keys
			
			//start updating
			nfRender.instance.addRender(this.update);
		}
		static private var _instance:nfCalling = null;
		static private var _canCreate:Boolean = false;
		static public function get instance():nfCalling {
			if (_instance == null) {
				nfCalling._canCreate = true;
				nfCalling._instance = new nfCalling;
				nfCalling._canCreate = false;
			}
			return nfCalling._instance;
		}
		
	}

}