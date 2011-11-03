package nextFramework.utils.parser 
{
	/**
	 * Parser Objekt to Int
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.09
	 */
	public class IntParser implements IParser
	{
		public static function parse(value:*, defaultValue:int = 0):int{
			var result:int = defaultValue;
			if(value){
				value = value.toString()
				if (!isNaN(Number(value))) {
					result = parseInt(value);
				}
			}
			return result;
		}
		
	}

}