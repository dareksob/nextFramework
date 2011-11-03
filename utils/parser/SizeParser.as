package nextFramework.utils.parser 
{
	import nextFramework.translate.nfSize;
	
	/**
	 * Parser Objekt to nfSize
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.09
	 */
	public class SizeParser 
	{
		
		public static function parse(value:*, defaultWidth:Number = 0, defaultHeight:Number = 0):nfSize{
			var result:nfSize = new nfSize(defaultWidth, defaultHeight);
			if (value) {
				if (value is nfSize) {
					result = value as nfSize;
				}else{
					if (typeof(value) == "string") {
						value = String(value).split(",");
					}else if (typeof(value) == "xml") {
						value = [value.@width, value.@height];
					}else if (value is Object) {
						value = [value["width"], value["height"]];
					}
					if (value is Array) {
						result.width = NumberParser.parse(value[0], defaultWidth);
						result.height = NumberParser.parse(value[1], defaultHeight);
					}
				}
			}
			return result;
		}
		
	}

}