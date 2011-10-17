package nextFramework.translate 
{
	import flash.geom.Point;
	import nextFramework.utils.nfMath;
	
	/**
	 * vector object in 2d space
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.06
	 */
	public class nfVector 
	{
		public var x:Number = 0;
		public var y:Number = 0;
		
		public function nfVector(x:Number = 0, y:Number = 0) 
		{
			this.x = x;
			this.y = y;
		}
		
		static public function create(x:Number, y:Number):nfVector {
			return new nfVector(x, y);
		}

		public function setZero():nfVector {
			this.x = 0;
			this.y = 0;
			return this;
		}
		public function compine():Number {
			return this.x + this.y;
		}
		
		/**
		 * clone this vector
		 * @return	nfVector
		 */
		public function clone():nfVector {
			return new nfVector(this.x, this.y);
		}
		
		/*
		 * operators
		 */
		
		public function add(vector:nfVector):nfVector{
			this.x += vector.x;
			this.y += vector.y;
			return this;
		}
		public function scalarAdd(value:Number):nfVector{
			this.x += value;
			this.y += value;
			return this;
		}
		
		public function minus(vector:nfVector):nfVector{
			this.x -= vector.x;
			this.y -= vector.y;
			return this;
		}
		public function scalarMinus(value:Number):nfVector{
			this.x -= value;
			this.y -= value;
			return this;
		}
		
		public function multyply(vector:nfVector):nfVector {
			this.x *= vector.x;
			this.y *= vector.y;
			return this;
		}
		public function scalarMultyply(value:Number):nfVector {
			this.x *= value;
			this.y *= value;
			return this;
		}
		
		public function divide(vector:nfVector):nfVector {
			this.x /= vector.x;
			this.y /= vector.y;
			return this;
		}
		public function divideFactor(factor:Number):nfVector {
			this.x /= factor;
			this.y /= factor;
			return this;
		}
		
		public function slope(vector:nfVector):Number {
			return (vector.y - y) / (vector.x - x);
		}
		
		public function reverse():nfVector {
			this.x *= -1;
			this.y *= -1;
			return this;
		}
		
		
		/**
		 * normalize
		 * @return	nfVector
		 */
		public function normalize():nfVector {
			var mag:Number = Math.sqrt(this.x * this.x + this.y * this.y);
			this.x /= mag;
			this.y /= mag;
			return this;
		}
		
		/**
		 * radiant of vector
		 * @return	Number
		 */
		public function get radiant():Number {
			return Math.atan2(this.y, this.x);
		}
		
		/**
		 * angle of vector
		 * @return	Number
		 */
		public function get degree():Number {
			return Math.atan2(this.y, this.x) * nfMath.degreePI;
		}
	
		
		/**
		 * dot product
		 * @param	vector
		 * @return	Number
		 */
		public function dot(vector:nfVector):Number {
			return this.x * vector.x + this.y * vector.y;
		}
		
		/**
		 * scalar product
		 * @param	value
		 * @return	Number
		 */
		public function scalar(value:Number):Number {
			return this.x * value + this.y * value;
		}
		
		/**
		 * length of this vector
		 * @return	Number
		 */
		public function get length():Number {
			return Math.sqrt(this.x * this.x + this.y * this.y);
		}
		
		/**
		 * return the middle point of this vector
		 * @return	nfVector
		 */
		public function getMidPointTo(vector:nfVector):nfVector {
			return new nfVector((this.x + vector.x) / 2, (this.y + vector.y) / 2);
		}
		
		/**
		 * calculate the distance to a vector
		 * @param	vector
		 * @return
		 */
		public function distance(vector:nfVector):Number {
			return Math.sqrt(Math.pow(vector.x - this.x, 2) + Math.pow(vector.y - this.y, 2));
		}
		
		public function offset(vector:nfVector):nfVector {
			this.x = vector.x - this.x;
			this.y = vector.y - this.y;
			return this;
		}
		
		/**
		 * convert this vector to point
		 * @return Point
		 */
		public function get point():Point {
			return new Point(x, y);
		}
		
		
		public function toString():String {
			return '[nfVector] x:'+x+' y:'+y;
		}
		
	}

}