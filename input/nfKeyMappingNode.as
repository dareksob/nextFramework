package nextFramework.input 
{
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.06
	 */
	 
	public class nfKeyMappingNode
	{
		
		public function nfKeyMappingNode(keyvalue:String, func:Function, userdata:* = null) 
		{
			this.keyvalue = keyvalue;
			this.func = func;
			this.userdata = userdata;
		}
		
		/*
		 * keyvalue
		 */
		private var _keyvalue:String = "";
		public function get keyvalue():String { 
			return this._keyvalue; 
		}
		public function set keyvalue(value:String) {
			this._keyvalue = value; 
		}
		
		/*
		 * function
		 */
		private var _func:Function;
		public function get func():Function { 
			return this._func; 
		}
		public function set func(value:Function) {
			this._func = value; 
		}
		public function call() {
			if (this._func is Function) {
				this._func(this);
			}
		}
		
		/*
		 * userdata
		 */
		private var _userdata:*;
		public function get userdata():* { 
			return this._userdata; 
		}
		public function set userdata(value:*) {
			this._userdata = value; 
		}
		
		public function toString():String {
			return '[nfKeyMappingNode]  keyvalue:' + this.keyvalue;
		}
		
	}

}