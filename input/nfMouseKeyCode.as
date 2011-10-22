package nextFramework.input 
{
	/**
	 * EventCodes for nfMouse
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.08
	 */
	 
	public class nfMouseKeyCode
	{
		static public const EVENT_MOUSEDOWN:String = 'mouseDown';
		static public const EVENT_MOUSEUP:String = 'mouseUp';
		static public const EVENT_CLICK:String = 'click';
		static public const EVENT_DOUBLECLICK:String = 'doubleClick';
		static public const EVENT_MOVEMOUSEDOWN:String = 'move+mouseDown';
		static public const EVENT_MOVE:String = 'move';
		static public const EVENT_MOUSEOUT:String = 'out';
		static public const EVENT_MOUSEOVER:String = 'over';
		
		static public const DELTA_LEFT:uint = 0;
		static public const DELTA_RIGHT:uint = 1;
		static public const DELTA_MIDDLE:uint = 2;
	}

}