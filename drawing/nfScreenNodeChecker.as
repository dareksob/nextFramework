package nextFramework.drawing 
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	/**
	 * ...
	 * @author Darius Sobczak
	 */
	public class nfScreenNodeChecker extends nfScreenNode
	{
		protected var _fieldBitmapData:BitmapData;
		private var _width:Number = 0;
		private var _height:Number = 0;
		
		public function nfScreenNodeChecker(width:Number, height:Number, bitmapdata:BitmapData)
		{
			this._width = width;
			this._height = height;
			
			super(bitmapdata);
			
			this.updateBitmapData();
		}
		
		override public function get bitmapData():BitmapData { 
			return this._fieldBitmapData; 
		}
		
		private function updateBitmapData():void {
			_fieldBitmapData = new BitmapData(_width, _height);
			
			for (var vy:Number = 0; vy < _height; vy += this._bitmapData.height) {
				for (var vx:Number = 0; vx < _width; vx += this._bitmapData.width) {
					var mat:Matrix = new Matrix;
					mat.translate(vx, vy);
					_fieldBitmapData.draw(this._bitmapData, mat);
				}
			}
			
		}
	}

}