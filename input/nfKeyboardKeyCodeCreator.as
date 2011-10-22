package nextFramework.input 
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	/**
	 * ...
	 * @author Darius Sobczak
	 */
	public class nfKeyboardKeyCodeCreator
	{
		
		public static function create(event:String, keyCode:Object = null, shift:Boolean = false, alt:Boolean = false, ctrl:Boolean = false):String {
			var code:Array = new Array;
			code.push(event);
							
			if (keyCode) {
				if (keyCode is Array) {
					(keyCode as Array).sort();
					keyCode = (keyCode as Array).join("+");
				}
				code.push(keyCode);
			}
			
			var keys:String = nfKeyboardKeyCodeCreator.getKeys(shift, alt, ctrl);
			if (keys.length > 0) {
				code.push(keys);
			}
			return code.join("+");
		}
		
		internal static function createByEvent(eventname:String, event:KeyboardEvent, keyCodes:Array) {
			return nfKeyboardKeyCodeCreator.create(
				eventname, 
				(keyCodes.length > 0 ? keyCodes.join("+") : null), 
				event.shiftKey, 
				event.altKey, 
				event.ctrlKey
			);
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