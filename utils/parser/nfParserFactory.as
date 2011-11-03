package nextFramework.utils.parser 
{
	import flash.utils.getDefinitionByName;
	import nextFramework.nfRegistry;
	import nextFramework.utils.nfString;
	/**
	 * ...
	 * @author Darius Sobczak
	 */
	public class nfParserFactory 
	{
		static public function factory(typename:String):Class {
			var parserClass:Class;
			try{
				parserClass = getDefinitionByName("nextFramework.utils.parser."+nfString.firstUpperCase(typename, true)+"Parser") as Class;
			}catch (error:Error) {
				nfRegistry.addLog(error.message, nfParserFactory);
				parserClass = null;
			}
			return parserClass;
		}
		
	}

}