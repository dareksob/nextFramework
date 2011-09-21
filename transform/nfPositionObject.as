package nextFramework.transform 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import nextFramework.debug.nfDrawRect;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.0 beta
	 */
	 
	public class nfPositionObject
	{
	
		public function nfPositionObject(object:Object, position:Point) 
		{
			this.object = object;
			this.position = new Point(position.x, position.y);
		}
		
		/*
		 * Object
		 */
		private var _object:Object;
		public function get object():Object { 
			return this._object; 
		}
		public function set object(value:Object):void {
			this._object = value; 
		}
		
		/*
		 * position
		 */
		private var _position:Point;
		public function get position():Point { 
			return this._position; 
		}
		public function set position(value:Point):void {
			this._position = value; 
		}
		
		public function setObjectToPosition(x:Boolean = true, y:Boolean = true):void {
			if (this.object is DisplayObject) {
				if(x) (this.object as DisplayObject).x = this.position.x;
				if (y) (this.object as DisplayObject).y = this.position.y;
			}
			
		}
		
		public function toString():String {
			return '[Object nfPositionObject] object:' + this.object + ' position:' + this.position;
		}
		
	}

}