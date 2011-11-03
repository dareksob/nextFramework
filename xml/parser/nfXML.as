package nextFramework.xml.parser 
{
	import nextFramework.nfRegistry;
	import nextFramework.utils.nfObject;
	import nextFramework.utils.parser.nfParserFactory;
	/**
	 * ...
	 * @author Darius Sobczak
	 */
	public class nfXML 
	{
		
		public static function parseXmlToObject(xml:XML):Object {
			var object:Object = nfObject.extend({}, nfXML.parseAttrToObject(xml));
			var list:XMLList = xml.children();

			if(list.length()){
				for each(var child:XML in xml.children()) {
					var childobject:Object = nfXML.parseXmlToObject(child);
					object[child.name().toString()] = childobject;
				}
			}
			return object;
		}
		
		/**
		 * parse xml attributes to a object
		 * 
		 * @param	xml
		 * @return	Object
		 */
		public static function parseAttrToObject(xml:XML):Object {
			var obj:Object = { };
			for(var index:Object in xml.attributes()) {
				var attr:XML = xml.attributes()[index];
				obj[attr.name().toString()] = attr.toString();
			}
			return obj;
		}
		
	}

}