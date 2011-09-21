package nextFramework.collection  
{
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.0 beta
	 */
	 
	public final class nfKeyValueNode
	{
		
		public function nfKeyValueNode(key:Object, value:*) 
		{
			this.key = key;
			this.value = value;
		}
		
		/*
		 * key
		 */
		private var _key:Object;
		public function get key():Object { 
			return this._key; 
		}
		public function set key(value:Object):void {
			this._key = value; 
		}
		
		/*
		 * value
		 */
		private var _value:*;
		public function get value():* { 
			return this._value; 
		}
		public function set value(value:*):void {
			this._value = value; 
		}
		
	}

}