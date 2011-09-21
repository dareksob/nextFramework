package nextFramework.loader 
{
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.0 beta
	 */
	 
	public interface ILoaderClass 
	{		
		function get loaderNode():nfLoaderNode;
		function set loaderNode(value:nfLoaderNode):void;
		
		function load():void;
	}
	
}