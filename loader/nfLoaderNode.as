package nextFramework.loader 
{
	import nextFramework.utils.nfObject;
	
	/**
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.07
	 */
	 
	public class nfLoaderNode
	{
		static public function create(type:String, url:String, conf:Object):nfLoaderNode {
			var _this:nfLoaderNode = new nfLoaderNode();
			nfObject.setProps(_this, conf);
			_this.type = type;
			_this.url = url;
			_this.conf = conf;
			return _this;
		}
		
		/*
		 * url
		 */
		private var _url:String;
		public function get url():String {
			return this._url; 
		}
		public function set url(value:String):void {
			this._url = value; 
		}
		
		/*
		 * name
		 */
		private var _name:String = "";
		public function get name():String { 
			return this._name; 
		}
		public function set name(value:String):void {
			this._name = value; 
		}
		
		/*
		 * type
		 */
		private var _type:String = "";
		public function get type():String { 
			return this._type; 
		}
		public function set type(value:String):void {
			this._type = value;
		}
		
		/*
		 * conf
		 */
		private var _conf:Object = {};
		public function get conf():Object { 
			return this._conf; 
		}
		public function set conf(value:Object):void {
			if(value is Object){
				this._conf = value;
			}
		}
		
		/*
		 * object was loaded
		 */
		private var _object:*;
		public function get object():* { 
			return this._object; 
		}
		public function set object(value:*):void {
			this._object = value; 
		}
	}

}