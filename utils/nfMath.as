package nextFramework.utils
{
	import flash.geom.Point;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.06
	 */
	 
	public final class nfMath
	{
		static public const degreePI:Number =  57.295779513082320876798154814105;
		static public const radiantPI:Number = 0.01745329251994329576923690768489;
		
		static public function radiantToDegree(radiant:Number):Number {
			return radiant / nfMath.radiantPI * 8;
		}
		static public function degreeToRadiant(degree:Number):Number {
			return degree * nfMath.radiantPI;
		}
		
		
		static public function getAngle(value:Number):Number {
			if (value > 360) value = 0;
			else if (value < 0) value = 360;
			return value;
		}
		
		static public function singleNumber(value:Number):Number {
			if (value > 1) value = 1;
			else if (value < 0) value = 0;
			return value;
		}
		
		static public function between(value:Number, min:Number, max:Number):Number {
			if (value < min) {
				value = min;
				trace('min:' + min);
			}else if (value > max) {
				value = max;
				trace('max:' + max);
			}
			return value;
		}
		
		static public function randomMinMax(min:Number, max:Number){
			return Math.random()*(max - min) + min;
		}
	}

}