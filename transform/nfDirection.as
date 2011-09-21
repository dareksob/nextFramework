package nextFramework.transform 
{
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.0 beta
	 */
	 
	public final class nfDirection
	{
		
		public function nfDirection(value:String = 'x') 
		{
			this.value = value;
		}
		
		/*
		 * direction const
		 */
		public static const X:String = 'x';
		public static const Y:String = 'y';
		public static const XY:String = 'xy';
		
		/*
		 * direction
		 */
		private var _value:String;
		public function get value():String { 
			return this._value; 
		}
		public function set value(value:String):void {
			switch(value) {
				case XY:
					this._value = XY; 
					break;
				case Y:
					this._value = Y; 
					break;
				case X:
				default: 
					this._value = X; 
			}
		}
		
		public function toString():String {
			return this.value;
		}
		
	}

}