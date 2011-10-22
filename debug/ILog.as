package nextFramework.debug 
{
	import flash.events.IEventDispatcher;
	
	/**
	 * interface for logger classes
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.0 beta
	 */
	 
	public interface ILog
	{
		function addLog(object:*, caller:* = null):ILog;
	}
	
}