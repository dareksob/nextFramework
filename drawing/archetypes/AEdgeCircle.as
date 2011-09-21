package nextFramework.drawing.archetypes
{
	import nextFramework.drawing.IArchetype;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import nextFramework.drawing.nfDrawingData;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.0 beta
	 */
	 
	public class AEdgeCircle implements IArchetype
	{
		function AEdgeCircle(radius:Number, edges:uint){
			this.radius = radius;
			this.edges = edges;
		}
		

		public function getCommandData():nfDrawingData {
			var angle:Number = 360 / this.edges;
			var hPiAngle:Number = Math.PI / 180 * angle;
			
			return this.getCircleCommandData(angle, hPiAngle);
		}
		
		protected function getCircleCommandData(angle:Number, hPiAngle:Number):nfDrawingData {
			var commandData:nfDrawingData = new nfDrawingData();
			
			commandData.moveTo(0, 0);
			
			for (var edge:uint = 0; edge <= this.edges; edge++) {
				commandData.lineTo(
					Math.cos(edge * hPiAngle) * this.radius,
					Math.sin(edge * hPiAngle) * this.radius
				);
			}

			commandData.close();
			
			return commandData;
		}
		
		/*
		 * radius
		 * min value 0
		 */
		private var _radius:Number;
		public function get radius():Number { return this._radius; }
		public function set radius(value:Number):void {
			if (value < 0) value = 0;
			this._radius = value;
		}
		
		/*
		 * edges
		 * min value 3
		 */
		private var _edges:uint = 3;
		public function get edges():uint { return this._edges; }
		public function set edges(value:uint):void {
			if (value < 3) value = 3;
			this._edges = value;
		}
		
	}

}