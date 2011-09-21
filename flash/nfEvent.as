package flash 
{
	import flash.events.EventDispatcher;
	import nextFramework.collection.nfKeyValueCollection;
	/**
	 * ...
	 * @author Darius Sobczak
	 * @status on work
	 * @usage nfEvent.add(this, Event.ADDED_TO_STAGE, this.init, { call: 1 } );
	 */
	public class nfEvent
	{
		static private var _list:nfKeyValueCollection = new nfKeyValueCollection();
		
		static public function add(obj:EventDispatcher, event:String, func:Function, conf:Object = null) {
			
		}
		static public function remove(obj:EventDispatcher, event:String, func:Function) {
			
		}
		
		static private function calling(event:*):void {
			
		}
		
	}

}