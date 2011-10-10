package nextFramework.component 
{
	
	/**
	 * interface for component object
	 * @author Darius Sobczak
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
	}
	
}