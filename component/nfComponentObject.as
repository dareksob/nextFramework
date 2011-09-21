package nextFramework.component 
{
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.0 beta
	 */
	 
	public class nfComponentObject
	{
		
		function nfComponentObject(container:nfComponentObjectContainer, object:Object, name:String = "") 
		{
			this._container = container;
			this._object = object;
			this.name = name;
		}
		
		public function added():void { }
		public function removed():void { }
		public function init(conf:Object):void {}
		
		/*
		 * name of componentobject 
		 */
		private var _name:String = "";
		public function get name():String { 
			return this._name; 
		}
		public function set name(value:String):void {
			this._name = value; 
		}
		
		/*
		 * object
		 */
		private var _object:*;
		public function get object():* { 
			return this._object; 
		}
		
		/*
		 * container
		 */
		private var _container:nfComponentObjectContainer;
		public function get container():nfComponentObjectContainer { 
			return this._container; 
		}
		
	}

}