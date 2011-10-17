package nextFramework.utils 
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * coordinate object for rectangle data
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.07
	 */
	 
	public final class nfBoxPoints
	{
		function nfBoxPoints(object:Object) {
			var position:Point = new Point;
			var stagePosition:Point = new Point;
			var rect:Rectangle = new Rectangle;
			
			if (object is Stage) {
				//stage
				rect.width = object.stageWidth;
				rect.height = object.stageHeight;
			}else if (object is DisplayObject) {
				//DisplayObject
				rect = object.getRect(null);
				stagePosition = object.localToGlobal(new Point);
				position = new Point(object.x, object.y);
			}else if (object is Rectangle) {
				//rectange
				stagePosition = object.topLeft;
				position = new Point(object.left, object.top);
			}else if (object is Object) {
				if (object.width is Number) {
					rect.width = object.width ;
				}
				if (object.height is Number) {
					rect.height = object.height;
				}
				if (object.x is Number) {
					rect.x = object.x;
				}
				if (object.y is Number) {
					rect.y = object.y;
				}
			}
			
			this.setPointsOfRect(rect);
			this._stagePostition = stagePosition;
			this._position = position;
		}

		
		/**
		 * for all support elements
		 * @param	rect
		 */		
		private function setPointsOfRect(rect:Rectangle):void {		
			this._rect = rect;
			
			this._absLeftTop = new Point(rect.x, rect.y);
			this._centerPointRelative = new Point(rect.width/2, rect.height/2);
			this._centerPoint = new Point(
				this.leftTop.x + this.centerPointRelative.x,
				this.leftTop.y + this.centerPointRelative.y
			);
		}
		
		public function getByStage(propname:String):Point {
			var point:Point = this[propname];
			point = point.add(this.stagePostition);
			return point;
		}

		/**
		 * rightBottom
		 */
		public function get rightBottom():Point { 
			return new Point(this.rect.right, this.rect.bottom);
		}
		
		/**
		 * leftBottom
		 */
		public function get leftBottom():Point { 
			return new Point(this.rect.left, this.rect.bottom);
		}
		
		/**
		 * rightTop
		 */
		public function get rightTop():Point { 
			return new Point(this.rect.right, this.rect.top);
		}
		
		/**
		 * leftTop
		 */
		public function get leftTop():Point { 
			return new Point(this.rect.left, this.rect.top);
		}
		
		/**
		 * position
		 */
		private var _position:Point = new Point;
		public function get position():Point { 
			return this._position; 
		}
		
		/**
		 * pivotPointLeftTop
		 */
		private var _stagePostition:Point = new Point;
		public function get stagePostition():Point { 
			return this._stagePostition; 
		}

		/**
		 * centerPoint
		 */
		private var _centerPoint:Point = new Point;
		public function get centerPoint():Point { 
			return this._centerPoint; 
		}
		
		/**
		 * centerPointRelative
		 */
		private var _centerPointRelative:Point = new Point;
		public function get centerPointRelative():Point { 
			return this._centerPointRelative; 
		}
		
		
		/**
		 * absLeftTop
		 */
		private var _absLeftTop:Point = new Point;
		public function get absLeftTop():Point { 
			return this._absLeftTop; 
		}
		
		/**
		 * rect
		 */
		private var _rect:Rectangle = new Rectangle
		public function get rect():Rectangle { 
			return this._rect; 
		}
		
		/**
		 * hSize
		 */
		public function get hSize():Point { 
			return new Point(this.width / 2, this.height / 2);
		}
		
		/**
		 * size
		 */
		public function get size():Point { 
			return new Point(this.width, this.height);
		}
		
		/**
		 * width
		 */
		public function get width():Number { 
			return this._rect.width; 
		}
		
		/**
		 * height
		 */
		public function get height():Number { 
			return this._rect.height; 
		}
	}

}