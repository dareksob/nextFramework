package nextFramework.drawing.styles 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import nextFramework.utils.nfObject;
	
	/**
	 * Fill style by bitmap
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.07
	 */
	 
	public class FillBitmap implements IStyle
	{
		
		function FillBitmap(conf:Object = null):void
		{
			nfObject.setProps(this, conf);
		}
		
		public function setStyle(graphics:Graphics):void {
			graphics.beginBitmapFill(this.bitmapData as BitmapData, this.matrix, this.repeat, this.smooth);
		}
		
		/** BitmapData */
		private var _bitmapData:Object;
		public function get bitmapData():Object { 
			return this._bitmapData; 
		}
		/** can be set as  BitmapData or Bitmap Object */
		public function set bitmapData(value:Object):void {
			if(value is BitmapData){
				this._bitmapData = value; 
			}else if (value is Bitmap) {
				this._bitmapData = (value as Bitmap).bitmapData;
			}
		}
		
		// Matrix
		public var matrix:Matrix = new Matrix;
		
		// Repeat
		public var repeat:Boolean = true;
		
		// Smooth
		public var smooth:Boolean = false;
		
	}

}