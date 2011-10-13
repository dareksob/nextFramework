package nextFramework.drawing.styles
{
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import nextFramework.utils.nfObject;
	
	/**
	 * Fill style by gradiant
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.07
	 */
	 
	public class FillGradiant implements IStyle
	{
		
		public function FillGradiant(conf:Object = null) 
		{
			nfObject.setProps(this, conf);
		}
		
		public function setStyle(graphics:Graphics):void {
			graphics.beginGradientFill(
				this.fillType, this.colors, this.alphas, 
				this.ratios, this.matrix, this.spread, 
				this.interpolation, this.focalPointRatio
			);
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
		public var colors:Array;
		
		/** Alphas */
		public var alphas:Array;
		
		/** Ratios */
		public var ratios:Array;
		
		/** focalPointRatio */
		public var focalPointRatio:Number = 0;
		
		
	}

}