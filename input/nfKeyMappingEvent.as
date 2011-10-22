package nextFramework.input 
{
	import flash.events.Event;
	
	/**
	 * event for key mapping
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.08
	 */
	public class nfKeyMappingEvent extends Event 
	{
		private var _parentEvent:Event;
		
		public function nfKeyMappingEvent(type:String, parentEvent:Event) 
		{ 
			super(type, false, false);
			this._parentEvent = parentEvent;
		} 
		
		public function get parentEvent():Event {
			return this._parentEvent;
		}
		//
		public override function clone():Event 
		{ 
			return new nfKeyMappingEvent(type, this._parentEvent);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("nfKeyMappingEvent", "type", "parentEvent"); 
		}
		
	}
	
}