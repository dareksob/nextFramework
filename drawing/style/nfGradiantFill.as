package nextFramework.drawing.style
{
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import nextFramework.nfProperties;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.0 beta
	 */
	 
	public class nfGradiantFill implements IFillStyle
	{
		
		public function nfGradiantFill(conf:Object = null) 
		{
			nfProperties.setObjectProperties(this, conf);
		}
		
		public function beginFill(graphics:Graphics):void {
			//graphics.beginGradientFill(this.type, this.colors, this.alphas, this.ratios, this.matrix, this.spread, this.interpolation, this.focalPointRatio);
		}
		
		
		// Matrix
		private var _matrix:Matrix = new Matrix;
		public function get matrix():Matrix { 
			return this._matrix; 
		}
		public function set matrix(value:Matrix):void {
			this._matrix = value; 
		}
		
		// Repeat
		private var _repeat:Boolean = false
		public function get repeat():Boolean { 
			return this._repeat; 
		}
		public function set repeat(value:Boolean):void {
			this._repeat = value; 
		}
		
		// Smooth
		private var _smooth:Boolean = false
		public function get smooth():Boolean { 
			return this._smooth; 
		}
		public function set smooth(value:Boolean):void {
			this._smooth = value; 
		}
	}

}