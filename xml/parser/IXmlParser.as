package nextFramework.xml.parser 
{
	
	/**
	 * Interface for XML Parser
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.08
	 */
	public interface IXmlParser 
	{
		function loadXMLAndParse(file:String, onComplete:Function = null):void;
		function parseXML(xml:XML):void;
	}
	
}