package nextFramework.drawing.adapter 
{
	import flash.display.Graphics;
	import nextFramework.drawing.IArchetype;
	import nextFramework.drawing.IDrawingAdapter;
	import nextFramework.drawing.nfDrawingData;
	
	/**
	 * Drawing adapter for archetypes
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.07
	 */
	 
	public class Types implements IDrawingAdapter
	{
		private var _archetype:IArchetype;
		private var _winding:String = "evenOdd";
		
		public function Types(conf:Object) {
			if (conf.data is IArchetype) {
				this._archetype = conf.data as IArchetype;
			}
			if (conf.winding is String) {
				this._winding = conf.winding;
			}
		}
		
		/* INTERFACE nextFramework.drawing.IDrawingAdapter */
		
		public function draw(graphics:Graphics):void 
		{
			var drawingData:nfDrawingData = this._archetype.getCommandData();
			graphics.drawPath(drawingData.command, drawingData.data, this._winding);
		}
		
	}

}