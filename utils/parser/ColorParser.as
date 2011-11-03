package nextFramework.utils.parser 
{
	/**
	 * Parser Objekt to Color value
	 * TEST!
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.09
	 */
	public class ColorParser 
	{
		
		public static function parse(value:*, defaultValue:uint = 0):uint {
			var result:uint = defaultValue;
			
			if(value){
				value = value.toString();
				if (value.length > 0) {
					var intval:int = IntParser.parse(value, defaultValue);
					result = uint(intval);
				}
			}
			return result;
		}
		
	}

}