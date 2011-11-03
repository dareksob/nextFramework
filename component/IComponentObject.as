package nextFramework.component 
{
	
	/**
	 * interface for component object
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.00 beta
	 */
	public interface IComponentObject 
	{
		function added():void;
		function removed():void;
		function init(conf:Object):void;
		
		/** name of this component */
		function get name():String;
		function set name(value:String):void;
		
		/** return the object */
		function get object():*;
		
		/** return the container */
		function get container():nfComponentObjectContainer;
		
		function set activate(value:Boolean):void;
		function get activate():Boolean;
	}
	
}