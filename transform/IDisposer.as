package nextFramework.transform 
{
	import nextFramework.transform.nfPositionObjectCollection;
	
	/**
	 * interface for transformer classes like align, arrange, tablearrange
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.07
	 */
	public interface IDisposer
	{
		function positionObjects(list:Vector.<Object>):*;
		function getPositionObjectCollection(list:Vector.<Object>):nfPositionObjectCollection;
	}
	
}