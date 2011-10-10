package nextFramework.collection  
{
	
	/**
	 * data holder object 
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.07
	 */
	 
	public final class nfKeyValueNode implements IKeyValueNode, ILockable
	{
		
		public function nfKeyValueNode(key:Object, value:*, locked:Boolean = false) 
		{
			this.key = key;
			this.value = value;
			this.lock = value;
		}
		
		/**
		 * key
		 */
		private var _key:Object;
		public function get key():Object { 
			return this._key; 
		}
		public function set key(value:Object):void {
			this._key = value; 
		}
		
		/**
		 * lock property
		 */
		private var _locked:Boolean;
		public function get isLocked():Boolean { 
			return this._locked; 
		}
		public function set lock(value:Boolean):void {
			this._locked = value; 
		}

		
		/**
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