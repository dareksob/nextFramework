package nextFramework.utils.parser 
{
	
	/**
	 * ...
	 * @author Darius Sobczak
	 */
	public interface IParserBuilder 
	{
		function loadAndBuild(url:String, onBuilded:Function = null):void;
		function build(conf:Object):Array;
		function get parser():IAssetParser;
	}
	
}