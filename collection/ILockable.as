package nextFramework.collection 
{
	
	/**
	 * interface for lockable objects
	 * 
	 * @author Darius Sobczak
	 */
	public interface ILockable 
	{
		function get isLocked():Boolean;
		function set lock(value:Boolean):void;
	}
	
}