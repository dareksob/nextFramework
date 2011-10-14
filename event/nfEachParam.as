package nextFramework.event
{
	
	/**
	 * event object for each loops
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.07
	 */
	 
	public final class nfEachParam
	{
		
		function nfEachParam(object:Object, index:int = 0, length:int = 0) 
		{
			this._object = object;
			this._index = index;
			this._length = length;
		}
		
		/**
		 * object
		 */
		private var _object:Object = null;
		public function get object():Object { 
			return this._object; 
		}
		
		/**
		 * index
		 */
		private var _index:int = 0;
		public function get index():int { 
			return this._index; 
		}
		
		/**
		 * length
		 */
		private var _length:int = 0;
		public function get length():int { 
			return this._length; 
		}
	}

}