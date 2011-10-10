package nextFramework.component 
{
	
	/**
	 * interface for component container class
	 * @author Darius Sobczak
	 *  @version 1.05 beta
	 */
	
	public interface IComponentContainerObject
	{
		function addComponent(comp:Class, conf:Object = null):int;
		
		function removeComponent(comp:Class):void;
		
		function hasComponent(comp:Class):Boolean;
		
		function getComponent(comp:Class):*;
		
		function getComponentByName(name:String):*;
		
		//properties
		function get length():uint;
	}
	
}