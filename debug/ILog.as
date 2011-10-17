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
		function getLogs():Array;
		function clear():ILog;
		
		function get lastLog():Object;
		function get length():uint;
		
		function traceLog():ILog;
		function traceLastLog():ILog
	}
	
}