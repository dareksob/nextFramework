package nextFramework.drawing.adapter 
{
	import flash.display.Graphics;
	import nextFramework.drawing.IDrawingAdapter;
	import nextFramework.flash.nfFlashDrawing;
	
	/**
	 * Drawing adapter for flash drawings, based on nfFlashDrawing
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.07
	 */
	public class Flash implements IDrawingAdapter
	{
		private var _conf:Object = null;
		
		public function Flash(conf:Object = null) 
		{
			this._conf = conf;
		}
		
		/* INTERFACE nextFramework.drawing.IDrawingAdapter */
		
		public function draw(graphics:Graphics):void 
		{
			var flashDrawing:nfFlashDrawing = new nfFlashDrawing();
			flashDrawing.draw(graphics, this._conf);
		}
	}

}