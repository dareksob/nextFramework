package nextFramework.drawing.archetypes
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import nextFramework.drawing.IArchetype;
	import nextFramework.drawing.nfDrawingData;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.02 beta
	 */
	 
	public class ARect implements IArchetype
	{
		
		public function ARect(width:Number, height:Number){
			this.width = width;
			this.height = height;
		}
		
		public function getCommandData():nfDrawingData {
			var commandData:nfDrawingData = new nfDrawingData();
			
			this.offsetRectangle(-(this.rectangle.width / 2), -(this.rectangle.height / 2));
			
			commandData.moveTo(this.rectangle.left, this.rectangle.top);
			commandData.lineTo(this.rectangle.right, this.rectangle.top);
			commandData.lineTo(this.rectangle.right, this.rectangle.bottom);
			commandData.lineTo(this.rectangle.left, this.rectangle.bottom);
			
			return commandData;
		}
		
		
		private var _rectangle:Rectangle = new Rectangle();
		public function get rectangle():Rectangle { return this._rectangle; }
		public function set rectangle(value:Rectangle):void 
		{
			this._rectangle = value;
		}
		
		
		//width
		public function get width():Number { return this._rectangle.width; }
		public function set width(value:Number):void 
		{
			this._rectangle.width = value;
		}
		
		//height
		public function get height():Number { return this._rectangle.height; }
		public function set height(value:Number):void 
		{
			this._rectangle.height = value;
		}
		
		private function offsetRectangle(x:Number, y:Number) {
			this.rectangle.x += x;
			this.rectangle.y += y;
		}
		
		
		
		
	}

}