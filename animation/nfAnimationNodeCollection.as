package nextFramework.animation
{
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import nextFramework.collection.nfKeyValueCollection;
	import nextFramework.collection.nfKeyValueNode;
	import nextFramework.debug.nfTrace;
	import nextFramework.IExtension;
	import nextFramework.nF;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.0 beta
	 */
	 
	internal class nfAnimationNodeCollection
	{
		function nfAnimationNodeCollection(object:Object, conf:Object) {
			this.object = object;
			this.setCollection(conf);
		}
		
		
		/*
		 * object
		 */
		private var _object:Object;
		public function get object():Object {
			return this._object;
		}
		public function set object(value:Object):void {
			this._object = value;
		}
		
		/*
		 * setter for conf
		 */
		
		private function setCollection(conf:Object):void {
			if(conf is Array){
				for each(var cnode:Object in conf){
					this.addNode(cnode);
				}
			}else {
				this.addNode(conf);
			}
		}
		
		private function addNode(conf:Object):void {
			var node:nfAnimationNode = nfAnimationNode.create(this.object, conf);
			if (node) {
				if (node.delay > 0) {
					//add delay object
					this.collection.push(new nfAnimationDelay(node));
				}else {
					//add node
					this.collection.push(node);
				}
				
			}
		}

		public function start():void {
			startNext();
		}
		
		private function startNext(altNode:IAnimationObject = null):void {
			if (this.collection.length > this.index) {
				var node:IAnimationObject = altNode;
				if (!altNode) {
					node = this.collection[this.index];
				}
				node.start(this.eventAnimationFinish);
			}else {
				//animation complete
				if (this.onComplete is Function) {
					this.onComplete(this);
				}
			}
		}
		
		private function eventAnimationFinish(node:IAnimationObject) {
			if (node is nfAnimationNode) {
				this.index++;
				this.startNext();
			}else if (node is nfAnimationDelay) {
				this.startNext((node as nfAnimationDelay).node);
			}
		}
		
		/*
		 * onComplete
		 */
		private var _onComplete:Function = null;
		public function get onComplete():Function {
			return this._onComplete;
		}
		public function set onComplete(value:Function):void {
			this._onComplete = value;
		}
		
		/*
		 * collection
		 */
		private var _collection:Array = new Array;
		private function get collection():Array {
			return this._collection;
		}
		
		/*
		 * index
		 */
		private var _index:uint = 0;
		public function get index():uint { 
			return this._index; 
		}
		public function set index(value:uint):void {
			this._index = value; 
		}
	}

}