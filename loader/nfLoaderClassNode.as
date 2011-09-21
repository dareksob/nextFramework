package nextFramework.loader 
{
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.0 beta
	 */
	 
	internal class nfLoaderClassNode
	{
		
		private var _type:String = "";
		public function get type():String 
		{
			return this._type;
		}
		
		public function set type(value:String):void 
		{
			this._type = value;
		}
		
		
		private var _priority:int = 0;
		public function get priority():int 
		{
			return this._priority;
		}
		
		public function set priority(value:int):void 
		{
			this._priority = value;
		}
		
		private var _loaderClass:Class = null;
		public function get loaderClass():Class 
		{
			return this._loaderClass;
		}
		
		public function set loaderClass(value:Class):void 
		{
			this._loaderClass = value;
		}
		
	}

}