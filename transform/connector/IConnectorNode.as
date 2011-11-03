package nextFramework.transform.connector 
{
	
	/**
	 * ...
	 * @author Darius Sobczak
	 */
	public interface IConnectorNode
	{
		function update():void;
		function get name():String;
		function set name(value:String):void;
		
		function set activate(value:Boolean):void;
		function get isActivate():Boolean;
	}
	
}