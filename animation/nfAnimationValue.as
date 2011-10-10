package nextFramework.animation
{
	import nextFramework.nF;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.0 beta
	 */
	 
	internal class nfAnimationValue
	{
		static public function getValue(value:Object):Number{
			if (value is String) {
				var type = nfAnimationValue.getConvertType(value as String);
				switch(type) {
					case 'random': return nfAnimationValue.getRandomValue(value as String);	break;
					default:
						var numvalue:Number = parseFloat(value as String);
						if (numvalue is Number) {
							nfRegistry.addLog('nfAnimationValue.getValue, error type '+type+' not found');
						}
						return numvalue;
				}
			}else if (value is Number) {
				return value as Number;
			}
			
			nfRegistry.addLog('nfAnimationValue.getValue, fatal error the value object is not supported. '+value);
			return 0;
		}
		
		static public function getRandomValue(value:String):Number{
			var slides:Array = value.split('(');
			if (slides.length > 1) {
				slides = slides[1].split(',');
				
				var argone:Number = parseFloat(slides[0]);
				var argtwo:Number = parseFloat(slides[1].slice(0, slides[1].length -1));
				var rand:Number = Math.random() * argtwo + argone;

				return rand;
			}
			nfRegistry.addLog('nfAnimationValue.getRandomValue syntax error, '+value);
			return 0;
		}
		
		static public function getConvertType(value:String):String{
			var types:Array = new Array('random');
			value = value.toLowerCase();
			for each(var typename:String in types) {
				if (value.indexOf(typename) > -1) {
					return typename;
				}
			}
			return null;
		}
		
	}

}