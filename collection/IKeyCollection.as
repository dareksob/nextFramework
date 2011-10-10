package nextFramework.collection 
{
	
	/**
	 * ...
	 * @author Darius Sobczak
	 */
	public interface IKeyCollection 
	{
		function add(key:Object, value:*):void ;
		function getByKey(key:Object):*;
		function hasKey(key:Object):Boolean;
	}
	
}