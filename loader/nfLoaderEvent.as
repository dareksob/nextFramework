package nextFramework.loader
{
	import flash.events.Event;
	import nextFramework.loader.nfLoaderNode;
	
	/**
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.0 beta
	 */
	 
	public class nfLoaderEvent extends Event
	{
		
		public function nfLoaderEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
		}
		
		static public function create(type:String, loaderNode:nfLoaderNode, bubbles:Boolean = false, cancelable:Boolean = false):nfLoaderEvent {
			var event:nfLoaderEvent = new nfLoaderEvent(type, bubbles, cancelable);
			event.loaderNode = loaderNode;
			return event;
		}
		
		/*
		 * loaderNode
		 */
		private var _loaderNode:nfLoaderNode = null;
		public function get loaderNode():nfLoaderNode{ 
			return this._loaderNode; 
		}
		public function set loaderNode(value:nfLoaderNode):void {
			this._loaderNode = value; 
		}
		
		public function get object():*{ 
			if (this._loaderNode) {
				return this._loaderNode.object;
			}
			return null;
		}
		
	}

}