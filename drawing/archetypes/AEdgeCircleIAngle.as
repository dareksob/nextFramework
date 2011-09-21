package nextFramework.drawing.archetypes
{
	import flash.geom.Point;
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
	 
	public class AEdgeCircleIAngle implements IArchetype
	{
		private var _innerCircle:AEdgeCircleAngle;
		private var _outerCircle:AEdgeCircleAngle;
		
		public function AEdgeCircleIAngle(radius:Number, angle:Number, innerradius:Number, edges:uint) 
		{
			this.innerRadius = innerradius;	
			
			this._outerCircle = new AEdgeCircleAngle(radius, angle, edges);
			this._innerCircle = new AEdgeCircleAngle(this.getInnerRadius, this.angle, this.edges);
		}
		
		public function getCommandData():nfDrawingData {
			var outerpoints:nfDrawingData = this._outerCircle.getCommandData();
			
			//update innerpoint circle
			var innerpoints:nfDrawingData = this.getUpdatedInnerPoints();
			
			outerpoints.remove(1, outerpoints.length - 1);
			/*
			innerpoints.remove(1, innerpoints.length - 1).reverse();
			
			outerpoints.merge(innerpoints);
*/
			return outerpoints;
		}
		
		private function getUpdatedInnerPoints():nfDrawingData  {
			this._innerCircle.angle = this._outerCircle.angle;
			this._innerCircle.edges = this._outerCircle.edges;
			this._innerCircle.radius = this.getInnerRadius;
			
			return this._innerCircle.getCommandData();
		}
		
		/*
		 * innerradius
		 * min value 0, max value = 1
		 */
		private var _innerRadius:Number = 0;
		public function get getInnerRadius():Number {
			return this._outerCircle.radius * this.innerRadius;
		}
		public function get innerRadius():Number { 
			return this._innerRadius; 
		}
		public function set innerRadius(value:Number) {
			this._innerRadius = nfMath.singleNumber(value);
		}
		
		/*
		 * radius
		 */
		public function get radius():Number { return this._outerCircle.radius; }
		public function set radius(value:Number):void {
			this._outerCircle.radius = value;
		}
		
		/*
		 * angle
		 */
		public function get angle():Number { 
			return this._outerCircle.angle; 
		}
		public function set angle(value:Number) {			
			this._outerCircle.angle = value;
		}
		
		/*
		 * edges
		 */
		public function get edges():uint { return this._outerCircle.edges; }
		public function set edges(value:uint):void {
			this._outerCircle.edges = value;
		}
	}

}