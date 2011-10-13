package nextFramework.drawing.adapter 
{
	import flash.display.Graphics;
	import nextFramework.drawing.IDrawingAdapter;
	import nextFramework.drawing.nfDrawingData;
	
	/**
	 * ...
	 * @author Darius Sobczak
	 */
	public class Data implements IDrawingAdapter
	{
		private var _drawingData:nfDrawingData;
		private var _winding:String = "evenOdd";
		
		public function Data(conf:Object) {
			if (conf.data is nfDrawingData) {
				this._drawingData = conf.data as nfDrawingData;
			}
			if (conf.winding is String) {
				this._winding = conf.winding;
			}
		}
		
		/* INTERFACE nextFramework.drawing.IDrawingAdapter */
		
		public function draw(graphics:Graphics):void 
		{
			graphics.drawPath(this._drawingData.command, this._drawingData.data, this._winding);
		}
		
	}

}