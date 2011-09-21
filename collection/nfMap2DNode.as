package nextFramework.collection 
{
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.06
	 */
	
	public class nfMap2DNode
	{
		private var _x:uint = 0;
		private var _y:uint = 0;
		private var _object:* = null;
		
		public function nfMap2DNode(x:uint, y:uint, object:* = null) {
			this._x = x;
			this._y = y;
			this._object = object;
		}
		
		public function get object():* {
			return this._object;	
		}
		public function set object(value:*):void {
			this._object = value;
		}
		
		public function get x():uint {
			return this._x;	
		}
		public function get y():uint {
			return this._y;	
		}
		
	}

}