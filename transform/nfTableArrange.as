package nextFramework.transform 
{
	import nextFramework.nfProperties;
	import flash.display.DisplayObject;
	import nextFramework.utils.nfBoxPoints;
	import flash.geom.Point;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.06
	 */
	
	public final class nfTableArrange
	{
		
		function nfTableArrange(conf:Object = null) {
			nfProperties.setObjectProperties(this, conf);
		}
		
		public function arrangeList(list:Vector.<Object>):nfTableArrange {
			this.getPositionCollection(list).objectToPosition(nfDirection.XY);
			return this;
		}
		
		public function getPositionCollection(list:Vector.<Object>):nfPositionObjectCollection {			
			var position:Point = new Point;
			var positionCollection:nfPositionObjectCollection = new nfPositionObjectCollection;
			
			var paraDirection:String = 'y';
			if (this.direction == 'y') { //direction by y
				paraDirection = 'x';
			}
			
			var cellCount:int = 0;
			
			for (var index:int = 0; index < list.length; index++) {
				var node:DisplayObject = list[index] as DisplayObject;
				
				if (node) {
					var boxPoints:nfBoxPoints = new nfBoxPoints(node);
					var offsetPosition:Point = position.clone();
					
					offsetPosition = offsetPosition.subtract(nfAlignPosition.getPointByBoxPoint(this._alignPosition, boxPoints));
					
					positionCollection.pushByValue(node, offsetPosition);
					
					if (cellCount >= this._cells) {
						cellCount = 0;
						position[paraDirection] += this._spacing[paraDirection];
						position[this._direction] = 0;
					}else {
						position[this._direction] += this._spacing[this._direction];
						cellCount++;
					}
				}
				
			}
			return positionCollection;
		}
		
		/*
		 * spacing
		 */
		private var _spacing:Point = new Point();
		public function get spacing():Point { 
			return this._spacing; 
		}
		public function set spacing(value:Point):void {
			this._spacing = value; 
		}
		public function set spacingX(value:Number):void {
			this._spacing.x = value; 
		}
		public function set spacingY(value:Number):void {
			this._spacing.y = value; 
		}
		
		/*
		 * cells
		 */
		private var _cells:int = 5;
		public function get cells():int { 
			return this._cells; 
		}
		public function set cells(value:int):void {
			this._cells = value;
		}
		
		
		/*
		 * direction
		 */
		private var _direction:String = 'x';
		public function get direction():String { 
			return this._direction; 
		}
		public function set direction(value:String):void {
			if (value == 'x') {
				this._direction = 'x';
			}else{
				this._direction = 'y';
			}
		}
		
		/*
		 * alignPosition
		 */
		private var _alignPosition:String = 'center';
		public function get alignPosition():String { 
			return this._alignPosition; 
		}
		public function set alignPosition(value:String):void {
			this._alignPosition = value;
		}
		
	}

}