package nextFramework.loader 
{
	import flash.events.ErrorEvent;
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
	 
	public class nfLoaderError extends ErrorEvent
	{
		static public const ERROR_WRONGTYPE:String = "Wrong filetype";
		
		public function nfLoaderError(type:String, bubbles:Boolean = false, cancelable:Boolean = false, text:String = '') 
		{
			if (text.length == 0) {
				text = type;
			}
			super(type, bubbles, cancelable, text);
		}
	}

}