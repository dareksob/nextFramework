package nextFramework.drawing.archetypes
{
	import nextFramework.drawing.nfDrawingData;
	import nextFramework.utils.nfMath;
	import nextFramework.drawing.IArchetype;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.0 beta
	 */
	 
	public class AEdgeCircleAngle extends AEdgeCircle
	{
		
		function AEdgeCircleAngle(radius:Number, angle:Number, edges:uint){
			super(radius, edges);			
			this.angle = angle;
		}
		override public function getCommandData():nfDrawingData
		{
			var angle:Number = this.angle / this.edges;
			var hPiAngle:Number = Math.PI / 180 * angle;
			
			return this.getCircleCommandData(angle, hPiAngle);
		}
		
		/*
		 * angle
		 * max value 360, min value 0
		 */
		private var _angle:Number = 360;
		public function get angle():Number { 
			return this._angle; 
		}
		public function set angle(value:Number) {
			this._angle = nfMath.getAngle(value);
		}
		
	}

}