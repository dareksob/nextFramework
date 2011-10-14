package nextFramework.animation.tweens 
{
	
	/**
	 * Relative interface for tweens
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.07
	 */
	public interface ITween {
		function set target(value:Object):void;
		function set property(value:String):void;
		function get duration():Number;
		function set duration(value:Number):void;
		function update(time:Number):Boolean;
		function addEventListener(type:String, func:Function):void;
		
	}
	
}