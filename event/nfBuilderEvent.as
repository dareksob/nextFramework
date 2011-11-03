package nextFramework.event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Darius Sobczak
	 */
	public class nfBuilderEvent extends Event 
	{
		public static const PARSE_COMPLETE:String = "parseComplete";
		public static const BUILD_COMPLETE:String = "buildComplete";
		
		public function nfBuilderEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);			
		}
		
	}

}