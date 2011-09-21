package nextFramework.translate 
{
	import flash.geom.Matrix;
	/**
	 * ...
	 * @author Darius Sobczak
	 */
	public class nfTranslate 
	{
		public const DEGREES_TO_RADIANS:Number = 2 * Math.PI;
		public const RADIANS_TO_DEGREES:Number = 180 / Math.PI;
		public var position:nfVector = null;
		public var rotation:Number = 0;
		
		public function nfTranslate(position:nfVector = null, rotation:Number = 0) {
			if (position is nfVector) {
				this.position = position;
			}else {
				this.position = new nfVector;
			}
			this.rotation = rotation;
		}
		
		public function moveTo(x:Number, y:Number):nfTranslate {
			this.position.x = x;
			this.position.y = y;
			return this;
		}
		
		// return a transform matrix
		public function get matrix():Matrix {
			var mat:Matrix = new Matrix;
			mat.translate(position.x, position.y);
			mat.rotate(rotation);
			return mat;
		}
		
		
	}

}