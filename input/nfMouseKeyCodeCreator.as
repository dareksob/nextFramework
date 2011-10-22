package nextFramework.input
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * helper class for keycode creation
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.08
	 */
	public class nfMouseKeyCodeCreator
	{
		
		/**
		 * create a keycode for mouse events
		 * @param	event
		 * @param	delta
		 * @param	shift
		 * @param	alt
		 * @param	ctrl
		 * @return	String
		 */
		public static function create(event:String, delta:uint = 0, shift:Boolean = false, alt:Boolean = false, ctrl:Boolean = false):String {
			var code:Array = new Array;
			code.push(event);
			
			if (delta) {
				switch(event) {
					case nfMouseKeyCode.EVENT_CLICK:
					case nfMouseKeyCode.EVENT_DOUBLECLICK:
					case nfMouseKeyCode.EVENT_MOVEMOUSEDOWN:
					case nfMouseKeyCode.EVENT_MOUSEDOWN:
					case nfMouseKeyCode.EVENT_MOUSEUP:
						code.push(delta.toString());
				}
			}
			var keys:String = nfMouseKeyCodeCreator.getKeys(shift, alt, ctrl);
			if (keys.length > 0) {
				code.push(keys);
			}
			return code.join("+");
		}
		
		/**
		 * create keycode for mouse events by event
		 * @param	eventname
		 * @param	event
		 * @return	String
		 */
		internal static function createByEvent(eventname:String, event:MouseEvent):String {
			return nfMouseKeyCodeCreator.create(eventname, event.delta, event.shiftKey, event.altKey, event.ctrlKey);
		}
		
		private static function getKeys(shift:Boolean, alt:Boolean, ctrl:Boolean):String {
			var code:Array = new Array;
			if (shift) code.push("shift");
			if (alt) code.push("alt");
			if (ctrl) code.push("ctrl");
			return code.join("+");
		}
		
	}

}