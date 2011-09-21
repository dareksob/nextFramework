package nextFramework.utils.color
{
	import flash.geom.ColorTransform;
	/**
	 * ...
	 * @author Darius Sobczak
	 */
	public class nfColor
	{
		
		public static function rgbToHex(r:uint, g:uint, b:uint):String {
			return '0x'+nfColor.intToHexCode(r) + nfColor.intToHexCode(g) + nfColor.intToHexCode(b);
		}
		public static function intToHexCode(value:uint):String {
			var hex:String = '00';
			if (value > 255) {
				hex = 'ff';
			}else {
				hex = value.toString(16);
				if (hex.length == 1) {
					hex = '0' + hex;
				}
			}
			
			return hex;
		}
		
		public static function lighten(color:uint, intensity:Number):uint {
			var rgb:RGB = new RGB(color);
			rgb.r += 255 * intensity;
			rgb.g += 255 * intensity;
			rgb.b += 255 * intensity;
			rgb.normalize();
			return rgb.color;
		}
		
		public static function darken(color:uint, intensity:Number):uint {
			var rgb:RGB = new RGB(color);
			rgb.r -= 255 * intensity;
			rgb.g -= 255 * intensity;
			rgb.b -= 255 * intensity;
			
			//fix problem by overhigh
			rgb.overloadfix();
			
			return rgb.color;
		}
		
		public static function blend(color:uint, blendcolor:uint, intensity:Number):uint {
			var colorRgb:RGB = new RGB(color);
			var blendRgb:RGB = new RGB(blendcolor);
			
			var offsetR:Number = (blendRgb.r - colorRgb.r) * intensity;
			var offsetG:Number = (blendRgb.g - colorRgb.g) * intensity;
			var offsetB:Number = (blendRgb.b - colorRgb.b) * intensity;
						
			var blended:RGB = RGB.byRGB(
				colorRgb.r + offsetR, 
				colorRgb.g + offsetG, 
				colorRgb.b + offsetB
			);
			
			return blended.color;
		}
		
	}

}