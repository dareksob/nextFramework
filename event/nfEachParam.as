package nextFramework.event
{
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.0 beta
	 */
	 
	public final class nfEachParam
	{
		
		function nfEachParam(object:Object, index:int = 0, length:int = 0) 
		{
			this.object = object;
			this.index = index;
			this.length = length;
		}
		static public function create(object:Object, index:int = 0, length:int = 0):nfEachParam {
			return new nfEachParam(object, index, length);
		}
		
		/*
		 * object
		 */
		private var _object:Object = null;
		public function get object():Object { 
			return this._object; 
		}
		public function set object(value:Object):void {
			this._object = value; 
		}
		
		/*
		 * index
		 */
		private var _index:int = 0;
		public function get index():int { 
			return this._index; 
		}
		public function set index(value:int):void {
			this._index = value; 
		}
		
		/*
		 * length
		 */
		private var _length:int = 0;
		public function get length():int { 
			return this._length; 
		}
		public function set length(value:int):void {
			this._length = value; 
		}
	}

}