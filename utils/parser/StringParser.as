package nextFramework.utils.parser 
{
	/**
	 * Parser Objekt to String, this is a good way to set default value or adjustable
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.09
	 */
	public class StringParser implements IParser
	{
		public static function parse(value:*, defaultValue:String = ""):String {
			var result:String = defaultValue
			if (value) {
				result = String(value);
			}
			return result;
	}

}