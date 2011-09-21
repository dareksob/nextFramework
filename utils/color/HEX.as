package nextFramework.utils.color 
{
	/**
	 * ...
	 * @author Darius Sobczak
	 */
	public class HEX
	{
		private var _hex:String = '000000';
		
		public function get r():String {
			return '0x' + _hex.substr(0, 2);
		}
		public function get g():String {
			return '0x' + _hex.substr(2, 2);
		}
		public function get b():String {
			return '0x' + _hex.substr(4, 2);
		}
		public function get hex():String {
			return '0x' + _hex;
		}
		
		public function HEX(color:uint) 
		{
			this.convert(color);
		}
		
		private function convert(color:uint):HEX {
			var str:String = color.toString(16);
			
			/*
			 * convert fixing
			 */
			if (str.length == 4) {
				str = '00' + str;
			}else if(str.length == 2) {
				str = '00' + str;
			}else if(str.length == 0) {
				str = '000000';
			}
			
			this._hex = str;
			return this;
		}
		
		public function toString():String {
			return '[HEX value:' + this._hex + ']';
		}
		
	}

}