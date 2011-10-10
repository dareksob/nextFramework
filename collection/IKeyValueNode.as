package nextFramework.collection 
{
	
	/**
	 * base keyvaluenode interface 
	 * 
	 * @author Darius Sobczak
	 */
	public interface IKeyValueNode 
	{
		function get key():Object;
		function set key(value:Object):void;
		function get value():*;
		function set value(value:*):void;
	}
	
}