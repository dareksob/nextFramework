package nextFramework.debug 
{
	import flash.events.IEventDispatcher;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.0 beta
	 */
	 
	public interface ILog extends IEventDispatcher
	{
		function addLog(object:*, caller:* = null):ILog;
		function getLogs():Array;
		function clear():ILog;
		
		function get lastLog():Object;
		function get length():uint;
		
		function traceLog():ILog;	
	}
	
}