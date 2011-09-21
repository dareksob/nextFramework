package nextFramework.component 
{
	
	/**
	 * @author Darius Sobczak
	 *  @version 1.05 beta
	 */
	
	public interface IComponentContainerObject extends IComponentContainer
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