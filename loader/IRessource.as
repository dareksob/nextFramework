package nextFramework.loader 
{
	
	/**
	 * interface for ressource manager like nfRessource
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.08
	 */
	public interface IRessource 
	{
		function getRessource(name:String):*;
		function hasRessource(name:String):Boolean;
	}
	
}