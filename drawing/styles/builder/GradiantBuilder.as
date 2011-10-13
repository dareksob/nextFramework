package nextFramework.drawing.styles.builder
{
	import flash.geom.Matrix;
	import nextFramework.utils.nfObject;
	
	/**
	 * Builder class for Gradient
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.07
	 */
	 
	public class GradiantBuilder
	{
		public function GradiantBuilder(conf:Object = null) {
			nfObject.setProps(this, conf);
		}

		/**
		 * set optional colors, alpha and ratio by array
		 * 
		 * @param	stops:Array
		 * @return	GradiantBuilder
		 */
		public function setStops(stops:Array):GradiantBuilder {
			for each(var stop:Object in stops) {
				//color
				if(stop.color is uint){
					this.colors.push(stop.color as uint);
				}
				//ratio
				if(stop.ratio is Number){
					this.ratios.push(stop.color as Number);
				}
				//alpha
				if(stop.alpha is Number){
					this.alphas.push(stop.alpha as Number);
				}
			}
			return this;
		}
		
		public function createBox(conf:Object):GradiantBuilder {
			var rotation:Number = conf.rotation is Number ? conf.rotation : 0;
			var tx:Number 		= conf.x is Number ? conf.x : 0;
			var ty:Number 		= conf.y is Number ? conf.y : 0;
			var width:Number 	= conf.width as Number;
			var height:Number 	= conf.height as Number;
			this.matrix.createGradientBox(width, height, rotation, tx, ty);
			return this;
		}
		
		
		/** Matrix */
		public var matrix:Matrix = new Matrix;
		
		/** Spread */
		public var spread:String = "pad";
		
		/** Enterpolation */
		public var interpolation:String = "rgb";
		
		/** Type */
		public var fillType:String = "linear";
		
		/** Colors */
		public var colors:Array = new Array;
		
		/** Alphas */
		public var alphas:Array = new Array;
		
		/** Ratios */
		public var ratios:Array = new Array;
		
		/** focalPointRatio */
		public var focalPointRatio:Number = 0;
		
		
	}

}