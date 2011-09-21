package nextFramework.utils.color 
{
	import flash.geom.ColorTransform;
	/**
	 * ...
	 * @author Darius Sobczak
	 */
	public class RGB
	{
		public var r:uint = 0;
		public var g:uint = 0;
		public var b:uint = 0;
		
		public function get color():uint {
			return uint('0x'+ nfColor.intToHexCode(r) + nfColor.intToHexCode(g) + nfColor.intToHexCode(b));
		}
		
		public function RGB(color:uint) {
			var hex:HEX = new HEX(color);
			this.r = uint(hex.r);
			this.g = uint(hex.g);
			this.b = uint(hex.b);
		}
		
		//color to rgb convert
		public static function byRGB(r:uint = 0, g:uint = 0, b:uint = 0):RGB {
			var rgb:RGB = new RGB(0);
			rgb.r = r;
			rgb.g = g;
			rgb.b = b;
			return rgb;
		}
		
		public function normalize():RGB {
			if (r > 255) r = 255;
			if (g > 255) g = 255;
			if (b > 255) b = 255;
			
			return this;
		}
		
		//temp method fix overhight value if you use negative operations
		public function overloadfix():RGB {
			if (r > 255) r = 0;
			if (g > 255) g = 0;
			if (b > 255) b = 0;
			
			return this;
		}
		
		
		
		public function get colorTransform():ColorTransform {
			return new ColorTransform(r / 255, g / 255, b / 255);
		}
		
		public function toString():String {
			return '[RGB r:' + r + ' g:' + g + ' b:' + b + ']';
		}
	}

}