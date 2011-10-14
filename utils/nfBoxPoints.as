package nextFramework.utils 
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import nextFramework.nfProperties;
	
	/**
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.05 beta
	 */
	 
	public final class nfBoxPoints
	{
		function nfBoxPoints(object:Object) {
			if (object is Stage) {
				this.setPointsByStage(object as Stage);
			}else if (object is DisplayObject) {
				this.setPointsByDisplayObject(object as DisplayObject);
			}else if (object is Rectangle) {
				this.setPointsByRect(object as Rectangle);
			}else if (object is Object) {
				nfProperties.setObjectProperties(this._rect, object);
			}
		}
		
		static public function create(object:Object):nfBoxPoints {
			return new nfBoxPoints(object);
		}
		
		/*
		 * methodes for spezial type
		 */
		private function setPointsByStage(stage:Stage):void {
			this.setPointsOfRect(new Rectangle(0, 0, stage.stageWidth, stage.stageHeight));
			this._stagePostition = new Point(0, 0);
			this.setPosition(0,0);
		}
		
		private function setPointsByRect(rect:Rectangle):void {
			this.setPointsOfRect(rect);
			this._stagePostition = rect.topLeft;
			this.setPosition(rect.left, rect.top);
		}
		
		private function setPointsByDisplayObject(object:DisplayObject):void {
			this.setPointsOfRect(object.getRect(null));
			this._stagePostition = object.localToGlobal(new Point);
			this.setPosition(object.x, object.y);
		}
		
		/*
		 * for all support elements
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
		private function setPosition(x:Number, y:Number):void {
			this._position = new Point(x, y);
		}
		
		public function getByStage(propname:String):Point {
			var point:Point = this[propname];
			point = point.add(this.stagePostition);
			return point;
		}

		/*
		 * rightBottom
		 */
		public function get rightBottom():Point { 
			return new Point(this.rect.right, this.rect.bottom);
		}
		
		/*
		 * leftBottom
		 */
		public function get leftBottom():Point { 
			return new Point(this.rect.left, this.rect.bottom);
		}
		
		/*
		 * rightTop
		 */
		public function get rightTop():Point { 
			return new Point(this.rect.right, this.rect.top);
		}
		
		/*
		 * leftTop
		 */
		public function get leftTop():Point { 
			return new Point(this.rect.left, this.rect.top);
		}
		
		/*
		 * position
		 */
		private var _position:Point = new Point;
		public function get position():Point { 
			return this._position; 
		}
		
		/*
		 * pivotPointLeftTop
		 */
		private var _stagePostition:Point = new Point;
		public function get stagePostition():Point { 
			return this._stagePostition; 
		}

		/*
		 * centerPoint
		 */
		private var _centerPoint:Point = new Point;
		public function get centerPoint():Point { 
			return this._centerPoint; 
		}
		
		/*
		 * centerPointRelative
		 */
		private var _centerPointRelative:Point = new Point;
		public function get centerPointRelative():Point { 
			return this._centerPointRelative; 
		}
		
		
		/*
		 * absLeftTop
		 */
		private var _absLeftTop:Point = new Point;
		public function get absLeftTop():Point { 
			return this._absLeftTop; 
		}
		
		/*
		 * rect
		 */
		private var _rect:Rectangle = new Rectangle
		public function get rect():Rectangle { 
			return this._rect; 
		}
		
		/*
		 * hSize
		 */
		public function get hSize():Point { 
			return new Point(this.width / 2, this.height / 2);
		}
		
		/*
		 * size
		 */
		public function get size():Point { 
			return new Point(this.width, this.height);
		}
		
		/*
		 * width
		 */
		public function get width():Number { 
			return this._rect.width; 
		}
		
		/*
		 * height
		 */
		public function get height():Number { 
			return this._rect.height; 
		}
	}

}