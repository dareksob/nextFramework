package nextFramework.transform 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import nextFramework.debug.nfDrawRect;
	import nextFramework.nF;
	import nextFramework.nfProperties;
	import nextFramework.utils.nfBoxPoints;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.05 beta
	 */
	 
	public final class nfArrange
	{
		
		function nfArrange(conf:Object = null) {
			nfProperties.setObjectProperties(this, conf);
		}
		
		public function arrangeList(list:Vector.<Object>):nfArrange {
			this.getArrangePositionCollection(list).objectToPosition(this.direction);
			return this;
		}
		
		public function getArrangePositionCollection(list:Vector.<Object>):nfPositionObjectCollection {			
			var position:Point = new Point;
			var positionCollection:nfPositionObjectCollection = new nfPositionObjectCollection;
			
			for (var index:int = 0; index < list.length; index++) {
				var node:DisplayObject = list[index] as DisplayObject;
				
				if (node) {
					var boxPoints:nfBoxPoints = new nfBoxPoints(node);
					
					//offset
					if(index == 0){
						position = position.add(this.offset);
					}

					position = position.add(new Point(-boxPoints.absLeftTop.x, -boxPoints.absLeftTop.y));
					positionCollection.pushByValue(node, position);
					position = position.add(boxPoints.size).add(boxPoints.absLeftTop);
					
					//spacing
					position = position.add(this.spacing);
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
		 * offset
		 */
		private var _offset:Point = new Point();
		public function get offset():Point { 
			return this._offset; 
		}
		public function set offset(value:Point):void {
			this._offset = value; 
		}
		public function set offsetX(value:Number):void {
			this._offset.x = value; 
		}
		public function set offsetY(value:Number):void {
			this._offset.y = value; 
		}
		
		/*
		 * direction
		 */
		private var _direction:String = 'x';
		public function get direction():String { 
			return this._direction; 
		}
		public function set direction(value:String):void {
			this._direction = value;
		}
		
		
	}

}