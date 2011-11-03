package nextFramework.utils.parser 
{
	/**
	 * Parser Objekt to Boolean
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.09
	 */
	public class BooleanParser 
	{
		
		public static function parse(value:*, defaultValue:Boolean = false):Boolean{
			var result:Boolean = defaultValue;
			
			if(value){
				value = value.toString();
				if (value.length > 0) {
					switch(value) {
						case "false":
						case "0": result = false;
							break;
						case "true":
						case "1": result = true;
							break;
					}
				}
			}
			return result;
		}
		
	}

}