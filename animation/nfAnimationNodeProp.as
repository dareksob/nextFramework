package nextFramework.animation
{
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import nextFramework.collection.nfKeyValueCollection;
	import nextFramework.collection.nfKeyValueNode;
	import nextFramework.debug.nfTrace;
	import nextFramework.IExtension;
	import nextFramework.nF;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.0 beta
	 */
	 
	internal class nfAnimationNodeProp
	{
		static private var _notAllowedList:Array = [
				'finish',
				'begin',
				'relative',
				'mirror',
				'delay',
				'useSeconds',
				'transition',
				'onComplete',
				'time'
			];
				
		static public function isAllowedProperty(prop:String):Boolean {
			for each(var value:String in nfAnimationNodeProp._notAllowedList) {
				if (prop == value) {
					return false;
				}
			}
			return true;
		}
		
	}

}