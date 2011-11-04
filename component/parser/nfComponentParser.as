package nextFramework.component.parser 
{
	import nextFramework.xml.parser.WorldParser;
	
	/**
	 * ...
	 * @author Darius Sobczak
	 */
	public class nfComponentParser extends WorldParser 
	{
		
		public function nfComponentParser() 
		{
			this._objectKey = "components";
			this._addTranslate = false;
		}
	}

}