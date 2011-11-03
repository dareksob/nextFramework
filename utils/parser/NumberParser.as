package nextFramework.utils.parser 
{
	/**
	 * Parser Objekt to Number
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.09
	 */
	public class NumberParser implements IParser
	{
		public static function parse(value:*, defaultValue:Number = 0):Number{
			var result:Number = defaultValue;
			if (value) {
				result = parseFloat(value.toString());
				if (isNaN(result)) {
					result = defaultValue;
				}
			}
			return result;
		}
		
	}

}